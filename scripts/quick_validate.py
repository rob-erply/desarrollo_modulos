#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Validador simple y robusto para __manifest__.py
"""

import sys
import os
import re
from pathlib import Path

def load_manifest_simple(manifest_path):
    """Cargar manifest usando importlib dinámico"""
    try:
        import importlib.util
        spec = importlib.util.spec_from_file_location("manifest", manifest_path)
        module = importlib.util.module_from_spec(spec)
        
        # Ejecutar el archivo como módulo
        with open(manifest_path, 'r', encoding='utf-8') as f:
            code = compile(f.read(), manifest_path, 'exec')
            exec(code, module.__dict__)
        
        # Buscar el diccionario en el namespace del módulo
        for name, value in module.__dict__.items():
            if isinstance(value, dict) and 'name' in value:
                return value
        
        # Si no se encuentra como variable, eval el archivo completo
        with open(manifest_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Evaluar directamente (método de respaldo)
        return eval(content)
        
    except Exception as e:
        print(f"Error cargando manifest: {e}")
        return None

def quick_validate(module_path):
    """Validación rápida del manifest"""
    module_path = Path(module_path)
    manifest_file = module_path / '__manifest__.py'
    
    if not manifest_file.exists():
        print("❌ __manifest__.py no encontrado")
        return False
    
    manifest = load_manifest_simple(manifest_file)
    if not manifest:
        print("❌ Error cargando manifest")
        return False
    
    print(f"✅ Manifest cargado correctamente")
    print(f"📋 Información básica:")
    print(f"   Nombre: {manifest.get('name', 'NO DEFINIDO')}")
    print(f"   Versión: {manifest.get('version', 'NO DEFINIDO')}")
    print(f"   Autor: {manifest.get('author', 'NO DEFINIDO')}")
    print(f"   Licencia: {manifest.get('license', 'NO DEFINIDO')}")
    print(f"   Categoría: {manifest.get('category', 'NO DEFINIDO')}")
    
    # Validaciones básicas
    errors = []
    warnings = []
    
    required_fields = ['name', 'version', 'license', 'author', 'category']
    for field in required_fields:
        if not manifest.get(field):
            errors.append(f"Campo '{field}' faltante")
    
    # Validar versión semántica
    version = manifest.get('version', '')
    if version and not re.match(r'^\d+\.\d+\.\d+\.\d+\.\d+$', version):
        warnings.append(f"Versión '{version}' no sigue formato semántico")
    
    # Validar dependencias
    depends = manifest.get('depends', [])
    if 'base' not in depends:
        errors.append("Dependencia 'base' faltante")
    
    # Mostrar resultados
    if errors:
        print(f"\n❌ Errores encontrados:")
        for error in errors:
            print(f"   • {error}")
    
    if warnings:
        print(f"\n⚠️  Warnings:")
        for warning in warnings:
            print(f"   • {warning}")
    
    if not errors and not warnings:
        print(f"\n🎉 ¡Manifest válido!")
        return True
    elif not errors:
        print(f"\n✅ Manifest válido con warnings")
        return True
    else:
        print(f"\n❌ Manifest tiene errores críticos")
        return False

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Uso: python3 quick_validate.py <module_path>")
        sys.exit(1)
    
    module_path = sys.argv[1]
    success = quick_validate(module_path)
    sys.exit(0 if success else 1)
