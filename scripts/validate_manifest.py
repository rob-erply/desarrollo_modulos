#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Script Python para validar __manifest__.py de módulos Odoo
Uso: python3 validate_manifest.py [path_to_module]
"""

import sys
import os
import argparse
import re
from pathlib import Path

# Colores para output
class Colors:
    RED = '\033[0;31m'
    GREEN = '\033[0;32m'
    YELLOW = '\033[1;33m'
    BLUE = '\033[0;34m'
    PURPLE = '\033[0;35m'
    NC = '\033[0m'  # No Color

class ManifestValidator:
    def __init__(self, verbose=False, strict=False):
        self.verbose = verbose
        self.strict = strict
        self.errors = 0
        self.warnings = 0
        self.suggestions = 0
    
    def log_error(self, message):
        print(f"{Colors.RED}❌ ERROR: {message}{Colors.NC}")
        self.errors += 1
    
    def log_warning(self, message):
        print(f"{Colors.YELLOW}⚠️  WARNING: {message}{Colors.NC}")
        self.warnings += 1
    
    def log_suggestion(self, message):
        print(f"{Colors.PURPLE}💡 SUGGESTION: {message}{Colors.NC}")
        self.suggestions += 1
    
    def log_success(self, message):
        print(f"{Colors.GREEN}✅ {message}{Colors.NC}")
    
    def log_info(self, message):
        if self.verbose:
            print(f"{Colors.BLUE}ℹ️  {message}{Colors.NC}")
    
    def load_manifest(self, manifest_path):
        """Cargar y parsear el __manifest__.py"""
        try:
            with open(manifest_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # Compilar para verificar sintaxis
            try:
                compiled = compile(content, manifest_path, 'exec')
            except SyntaxError as e:
                self.log_error(f"Error de sintaxis en __manifest__.py: {e}")
                return None
            
            # Ejecutar el código
            namespace = {}
            exec(compiled, namespace)
            
            # Buscar el diccionario del manifest
            manifest_dict = None
            for key, value in namespace.items():
                if isinstance(value, dict) and 'name' in value:
                    manifest_dict = value
                    break
            
            if manifest_dict is None:
                self.log_error("No se pudo encontrar el diccionario del manifest")
                return None
                
            return manifest_dict
            
        except Exception as e:
            self.log_error(f"Error al cargar __manifest__.py: {e}")
            return None
    
    def validate_required_field(self, manifest, field, field_name):
        """Validar campo obligatorio"""
        value = manifest.get(field, '')
        if not value or value in [None, '', []]:
            self.log_error(f"Campo obligatorio '{field_name}' faltante o vacío")
            return False
        else:
            self.log_info(f"{field_name}: {value}")
            return True
    
    def validate_version(self, version):
        """Validar formato de versión"""
        pattern = r'^\d+\.\d+\.\d+\.\d+\.\d+$'
        if not re.match(pattern, version):
            self.log_error(f"Versión '{version}' no sigue formato semántico: X.Y.Z.W.V")
            return False
        
        # Verificar versión de Odoo
        odoo_version = '.'.join(version.split('.')[:2])
        valid_versions = ['15.0', '16.0', '17.0', '18.0', '19.0']
        
        if odoo_version in valid_versions:
            self.log_success(f"Versión de Odoo válida: {odoo_version}")
        else:
            self.log_warning(f"Versión de Odoo '{odoo_version}' puede no ser válida")
        
        return True
    
    def validate_license(self, license_name):
        """Validar licencia"""
        valid_licenses = ['AGPL-3', 'LGPL-3', 'GPL-3', 'MIT', 'BSD', 'OPL-1']
        
        if license_name in valid_licenses:
            self.log_success(f"Licencia válida: {license_name}")
        else:
            self.log_warning(f"Licencia '{license_name}' puede no ser compatible con Odoo Apps Store")
            self.log_suggestion(f"Usar: {', '.join(valid_licenses)}")
    
    def validate_category(self, category):
        """Validar categoría"""
        valid_categories = [
            'Accounting', 'Sales', 'Purchase', 'Inventory', 'Manufacturing',
            'Human Resources', 'Marketing', 'Website', 'Point of Sale',
            'Productivity', 'Services', 'Extra Tools', 'Theme', 'Industries',
            'Localization'
        ]
        
        main_category = category.split('/')[0] if '/' in category else category
        
        if main_category in valid_categories:
            self.log_success(f"Categoría válida: {category}")
        else:
            self.log_warning(f"Categoría '{category}' puede no ser válida")
            self.log_suggestion(f"Usar categorías estándar: {', '.join(valid_categories)}")
    
    def validate_depends(self, depends):
        """Validar dependencias"""
        if 'base' not in depends:
            self.log_error("Dependencia 'base' es obligatoria")
        
        if 'mail' in depends and 'web' not in depends:
            self.log_suggestion("Si usa 'mail', considere incluir 'web' para funcionalidad completa")
    
    def validate_data_files(self, data_files, module_path):
        """Validar archivos de datos"""
        for file_path in data_files:
            full_path = module_path / file_path
            if not full_path.exists():
                self.log_warning(f"Archivo declarado no existe: {file_path}")
    
    def validate_module_structure(self, module_path):
        """Validar estructura del módulo"""
        required_files = ['__init__.py']
        for req_file in required_files:
            if not (module_path / req_file).exists():
                self.log_error(f"Archivo requerido faltante: {req_file}")
        
        # Verificar directorios estándar
        std_dirs = ['models', 'views', 'security']
        for std_dir in std_dirs:
            dir_path = module_path / std_dir
            if dir_path.exists():
                files = list(dir_path.glob('*.py')) + list(dir_path.glob('*.xml')) + list(dir_path.glob('*.csv'))
                if not files:
                    self.log_warning(f"Directorio '{std_dir}' existe pero está vacío")
    
    def validate_apps_store_requirements(self, manifest, module_path):
        """Validar requisitos para Odoo Apps Store"""
        if not self.strict:
            return
        
        print(f"\n{Colors.BLUE}🏪 Validando para Odoo Apps Store...{Colors.NC}")
        
        # Summary
        summary = manifest.get('summary', '')
        if not summary:
            self.log_error("Campo 'summary' es obligatorio para Odoo Apps Store")
        elif len(summary) > 60:
            self.log_warning(f"Summary muy largo ({len(summary)} chars). Máximo recomendado: 60")
        
        # Website
        if not manifest.get('website'):
            self.log_error("Campo 'website' es obligatorio para Odoo Apps Store")
        
        # Icon
        icon = manifest.get('icon', '')
        if not icon:
            self.log_error("Campo 'icon' es obligatorio para Odoo Apps Store")
        else:
            icon_path = module_path / icon
            if not icon_path.exists():
                self.log_error(f"Archivo de icono no encontrado: {icon}")
        
        # Descripción extendida
        description = manifest.get('description', '')
        if not description or len(description.strip()) < 100:
            self.log_warning("Description muy corta para Apps Store (mínimo 100 caracteres)")
        
        # Directorio de descripción
        desc_dir = module_path / 'static' / 'description'
        if not desc_dir.exists():
            self.log_error("Directorio static/description/ faltante (requerido para Apps Store)")
        else:
            if not (desc_dir / 'index.html').exists():
                self.log_suggestion("Considere agregar index.html para mejor presentación")
            
            screenshots = list(desc_dir.glob('screenshot*.png'))
            if not screenshots:
                self.log_suggestion("Agregar screenshots para mejorar presentación en Apps Store")
    
    def validate_manifest(self, module_path):
        """Validar manifest completo"""
        module_path = Path(module_path)
        manifest_file = module_path / '__manifest__.py'
        
        print(f"{Colors.BLUE}🔍 Validando: {manifest_file}{Colors.NC}")
        print()
        
        if not manifest_file.exists():
            self.log_error(f"Archivo __manifest__.py no encontrado en {module_path}")
            return False
        
        # Cargar manifest
        manifest = self.load_manifest(manifest_file)
        if not manifest:
            return False
        
        print(f"{Colors.BLUE}📋 Validando campos obligatorios...{Colors.NC}")
        
        # Validar campos obligatorios
        self.validate_required_field(manifest, 'name', 'Nombre')
        self.validate_required_field(manifest, 'version', 'Versión')
        self.validate_required_field(manifest, 'license', 'Licencia')
        self.validate_required_field(manifest, 'author', 'Autor')
        self.validate_required_field(manifest, 'category', 'Categoría')
        
        # Validaciones específicas
        version = manifest.get('version')
        if version:
            print(f"\n{Colors.BLUE}📊 Validando versión...{Colors.NC}")
            self.validate_version(version)
        
        license_name = manifest.get('license')
        if license_name:
            print(f"\n{Colors.BLUE}📜 Validando licencia...{Colors.NC}")
            self.validate_license(license_name)
        
        category = manifest.get('category')
        if category:
            print(f"\n{Colors.BLUE}🏷️  Validando categoría...{Colors.NC}")
            self.validate_category(category)
        
        depends = manifest.get('depends', [])
        if depends:
            print(f"\n{Colors.BLUE}🔗 Validando dependencias...{Colors.NC}")
            self.validate_depends(depends)
        
        data_files = manifest.get('data', [])
        if data_files:
            print(f"\n{Colors.BLUE}📁 Validando archivos de datos...{Colors.NC}")
            self.validate_data_files(data_files, module_path)
        
        # Validar estructura del módulo
        print(f"\n{Colors.BLUE}📂 Validando estructura del módulo...{Colors.NC}")
        self.validate_module_structure(module_path)
        
        # Validar para Apps Store si está en modo estricto
        self.validate_apps_store_requirements(manifest, module_path)
        
        return True
    
    def print_summary(self):
        """Mostrar resumen de validación"""
        print()
        print(f"{Colors.BLUE}📊 Resumen de validación:{Colors.NC}")
        print(f"   Errores: {Colors.RED}{self.errors}{Colors.NC}")
        print(f"   Warnings: {Colors.YELLOW}{self.warnings}{Colors.NC}")
        print(f"   Sugerencias: {Colors.PURPLE}{self.suggestions}{Colors.NC}")
        
        if self.errors == 0:
            if self.warnings == 0:
                print(f"\n{Colors.GREEN}🎉 ¡Manifest válido! Sin errores ni warnings.{Colors.NC}")
                return 0
            else:
                print(f"\n{Colors.YELLOW}⚠️  Manifest válido con warnings. Revise las sugerencias.{Colors.NC}")
                return 0
        else:
            print(f"\n{Colors.RED}❌ Manifest tiene errores críticos. Corrija antes de continuar.{Colors.NC}")
            return 1

def main():
    parser = argparse.ArgumentParser(
        description='Validador de __manifest__.py para módulos Odoo',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Ejemplos:
  python3 validate_manifest.py addons_custom/mi_modulo
  python3 validate_manifest.py --strict addons_custom/mi_modulo
  python3 validate_manifest.py --verbose addons_custom/mi_modulo
        """
    )
    
    parser.add_argument('module_path', help='Ruta al módulo a validar')
    parser.add_argument('-v', '--verbose', action='store_true', help='Mostrar información detallada')
    parser.add_argument('-s', '--strict', action='store_true', help='Validación estricta para Odoo Apps Store')
    
    args = parser.parse_args()
    
    # Verificar que el directorio existe
    module_path = Path(args.module_path)
    if not module_path.exists():
        print(f"{Colors.RED}Error: Directorio '{module_path}' no encontrado{Colors.NC}")
        return 1
    
    # Crear validador
    validator = ManifestValidator(verbose=args.verbose, strict=args.strict)
    
    # Ejecutar validación
    print(f"{Colors.BLUE}=== Validador de Manifest Odoo ==={Colors.NC}")
    print()
    
    success = validator.validate_manifest(module_path)
    if not success:
        return 1
    
    # Mostrar resumen
    return validator.print_summary()

if __name__ == '__main__':
    sys.exit(main())
