#!/bin/bash

# Script para crear archivos de documentación y tests profesionales
# Uso: ./create_documentation.sh [nombre_modulo]

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para mostrar ayuda
show_help() {
    echo -e "${BLUE}=== Creador de Documentación Profesional para Módulos Odoo ===${NC}"
    echo ""
    echo "Uso: $0 [OPCIONES] nombre_modulo"
    echo ""
    echo "Opciones:"
    echo "  -h, --help     Mostrar esta ayuda"
    echo "  -a, --all      Crear todos los archivos de documentación"
    echo "  --readme       Crear solo README.md"
    echo "  --license      Crear solo LICENSE"
    echo "  --html         Crear solo index.html"
    echo "  --tests        Crear solo estructura de tests"
    echo "  --icon         Crear icono por defecto"
    echo ""
    echo "Ejemplos:"
    echo "  $0 mi_modulo_ventas"
    echo "  $0 --readme mi_modulo_ventas"
    echo "  $0 --all mi_modulo_contabilidad"
}

# Validar parámetros
if [ $# -eq 0 ]; then
    echo -e "${RED}Error: Debe especificar el nombre del módulo${NC}"
    show_help
    exit 1
fi

# Procesar argumentos
CREATE_ALL=false
CREATE_README=false
CREATE_LICENSE=false
CREATE_HTML=false
CREATE_TESTS=false
CREATE_ICON=false
MODULE_NAME=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        -a|--all)
            CREATE_ALL=true
            shift
            ;;
        --readme)
            CREATE_README=true
            shift
            ;;
        --license)
            CREATE_LICENSE=true
            shift
            ;;
        --html)
            CREATE_HTML=true
            shift
            ;;
        --tests)
            CREATE_TESTS=true
            shift
            ;;
        --icon)
            CREATE_ICON=true
            shift
            ;;
        *)
            if [ -z "$MODULE_NAME" ]; then
                MODULE_NAME=$1
            fi
            shift
            ;;
    esac
done

# Si no se especificó ninguna opción, crear todo
if [ "$CREATE_ALL" = false ] && [ "$CREATE_README" = false ] && [ "$CREATE_LICENSE" = false ] && [ "$CREATE_HTML" = false ] && [ "$CREATE_TESTS" = false ] && [ "$CREATE_ICON" = false ]; then
    CREATE_ALL=true
fi

# Validar nombre del módulo
if [ -z "$MODULE_NAME" ]; then
    echo -e "${RED}Error: Nombre del módulo requerido${NC}"
    exit 1
fi

MODULE_DIR="$MODULE_NAME"
STATIC_DIR="$MODULE_DIR/static/description"
TESTS_DIR="$MODULE_DIR/tests"

echo -e "${BLUE}=== Creando documentación para módulo: $MODULE_NAME ===${NC}"

# Verificar si el directorio del módulo existe
if [ ! -d "$MODULE_DIR" ]; then
    echo -e "${YELLOW}Advertencia: El directorio del módulo no existe. Creándolo...${NC}"
    mkdir -p "$MODULE_DIR"
fi

# Función para crear README.md
create_readme() {
    echo -e "${BLUE}📄 Creando README.md...${NC}"
    
    # Convertir nombre del módulo para título
    MODULE_TITLE=$(echo "$MODULE_NAME" | sed 's/_/ /g' | sed 's/\b\w/\U&/g')
    
    cat > "$MODULE_DIR/README.md" << EOF
# $MODULE_TITLE

[![License: LGPL-3](https://img.shields.io/badge/License-LGPL%20v3-blue.svg)](https://www.gnu.org/licenses/lgpl-3.0)
[![Odoo Version](https://img.shields.io/badge/Odoo-18.0-brightgreen.svg)](https://github.com/odoo/odoo/tree/18.0)

## 📋 Descripción

Este módulo proporciona funcionalidades avanzadas para [DESCRIBIR LA FUNCIONALIDAD ESPECÍFICA].

### Características Principales

- ✅ **Gestión Completa**: Interfaz intuitiva para administrar registros
- ✅ **Workflow Automatizado**: Estados y transiciones controladas
- ✅ **Notificaciones**: Sistema de alertas y recordatorios
- ✅ **Reportes**: Análisis y exportación de datos
- ✅ **Multicompañía**: Soporte completo para múltiples compañías
- ✅ **Internacionalización**: Disponible en múltiples idiomas

## 🚀 Instalación

### Requisitos Previos

- Odoo 18.0 Community o Enterprise
- Python 3.10+
- PostgreSQL 14+

### Dependencias

Este módulo depende de los siguientes módulos base de Odoo:
- \`base\` - Funcionalidades básicas
- \`mail\` - Sistema de mensajería
- \`web\` - Interfaz web

### Pasos de Instalación

1. **Clonar el repositorio**:
   \`\`\`bash
   git clone [url-del-repositorio]
   cd addons_custom/$MODULE_NAME
   \`\`\`

2. **Agregar el módulo al path de addons**:
   - Agregar la ruta en el archivo de configuración de Odoo
   - O copiar el módulo a la carpeta de addons existente

3. **Actualizar la lista de módulos**:
   - Ir a Apps > Actualizar Lista de Apps
   - O ejecutar: \`./odoo-bin -u all --stop-after-init\`

4. **Instalar el módulo**:
   - Buscar "$MODULE_TITLE" en Apps
   - Hacer clic en "Instalar"

## 📖 Guía de Uso

### Configuración Inicial

1. **Configurar Permisos**:
   - Ir a Configuración > Usuarios y Compañías > Grupos
   - Asignar usuarios a los grupos "Usuario" o "Manager"

2. **Configurar Secuencias**:
   - Las secuencias se crean automáticamente
   - Personalizable en Configuración > Secuencias e Identificadores > Secuencias

### Operaciones Básicas

[AGREGAR DOCUMENTACIÓN ESPECÍFICA DE USO]

## 🧪 Testing

### Ejecutar Tests

\`\`\`bash
# Tests unitarios del módulo
python3 odoo-bin -d test_db --test-enable --stop-after-init -i $MODULE_NAME

# Tests específicos
python3 odoo-bin -d test_db --test-enable --test-tags $MODULE_NAME --stop-after-init
\`\`\`

### Tests Disponibles

- \`test_model_creation\` - Creación de registros
- \`test_state_transitions\` - Transiciones de estado
- \`test_validations\` - Validaciones de campos
- \`test_permissions\` - Permisos de usuario

## 🐛 Solución de Problemas

### Problemas Comunes

#### Error: "Módulo no encontrado"
- Verificar que el módulo esté en el path de addons
- Actualizar la lista de módulos
- Verificar dependencias

#### Error: "Permiso denegado"
- Verificar que el usuario tenga los grupos correctos
- Revisar reglas de registro (record rules)
- Verificar permisos del modelo

## 📞 Soporte

### Reportar Bugs

1. Ir a [Issues del repositorio]
2. Usar la plantilla de bug report
3. Incluir:
   - Versión de Odoo
   - Pasos para reproducir
   - Logs de error
   - Capturas de pantalla

## 🤝 Contribuir

### Proceso de Contribución

1. Fork del repositorio
2. Crear rama para la funcionalidad: \`git checkout -b feature/nueva-funcionalidad\`
3. Realizar cambios y tests
4. Commit con mensaje descriptivo
5. Push y crear Pull Request

## 📄 Licencia

Este módulo está licenciado bajo LGPL-3.0. Ver archivo [LICENSE](LICENSE) para detalles.

## 🙏 Créditos

- **Autor**: $COMPANY_NAME
- **Empresa**: ERPly S.R.L. - Especialistas en Odoo
- **Contacto**: info@erply.do | +1 (849) 517-5363
- **Dirección**: Calle Dr. Jacinto Ignacio Mañón #7, República Dominicana

## 📚 Recursos Adicionales

- [Documentación Oficial de Odoo](https://www.odoo.com/documentation/18.0/)
- [OCA (Odoo Community Association)](https://github.com/OCA)
- [Odoo Apps Store](https://apps.odoo.com/)

---

**¿Necesitas ayuda?** Contacta a [info@erply.do](mailto:info@erply.do) | Tel: +1 (849) 517-5363
EOF

    echo -e "${GREEN}✅ README.md creado exitosamente${NC}"
}

# Función para crear LICENSE
create_license() {
    echo -e "${BLUE}📜 Creando LICENSE...${NC}"
    
    cat > "$MODULE_DIR/LICENSE" << EOF
GNU LESSER GENERAL PUBLIC LICENSE
Version 3, 29 June 2007

Copyright (C) $(date +%Y) ERPly S.R.L.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.

Additional permissions under GNU LGPL version 3 section 7

If you modify this Program, or any covered work, by linking or combining
it with other code, such other code is not for that reason alone subject
to any of the requirements of the GNU LGPL.
EOF

    echo -e "${GREEN}✅ LICENSE creado exitosamente${NC}"
}

# Función para crear index.html
create_html() {
    echo -e "${BLUE}🌐 Creando static/description/index.html...${NC}"
    
    mkdir -p "$STATIC_DIR"
    
    # Convertir nombre del módulo para título
    MODULE_TITLE=$(echo "$MODULE_NAME" | sed 's/_/ /g' | sed 's/\b\w/\U&/g')
    
    cat > "$STATIC_DIR/index.html" << EOF
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$MODULE_TITLE</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            line-height: 1.6;
            color: #333;
            margin: 0;
            padding: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        .header {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 3px solid #875A7B;
        }
        .header h1 {
            color: #875A7B;
            margin: 0;
            font-size: 2.5em;
        }
        .header p {
            color: #666;
            font-size: 1.2em;
            margin: 10px 0;
        }
        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin: 30px 0;
        }
        .feature {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            border-left: 4px solid #875A7B;
        }
        .feature h3 {
            color: #875A7B;
            margin-top: 0;
        }
        .feature ul {
            margin: 0;
            padding-left: 20px;
        }
        .feature li {
            margin: 8px 0;
        }
        .installation {
            background: #e3f2fd;
            padding: 20px;
            border-radius: 8px;
            margin: 30px 0;
            border-left: 4px solid #2196F3;
        }
        .installation h2 {
            color: #1976D2;
            margin-top: 0;
        }
        .installation ol {
            margin: 0;
            padding-left: 20px;
        }
        .installation li {
            margin: 10px 0;
        }
        .support {
            background: #f3e5f5;
            padding: 20px;
            border-radius: 8px;
            margin: 30px 0;
            text-align: center;
            border-left: 4px solid #9C27B0;
        }
        .support h2 {
            color: #7B1FA2;
            margin-top: 0;
        }
        .btn {
            display: inline-block;
            padding: 12px 24px;
            background: #875A7B;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin: 10px;
            transition: background 0.3s;
        }
        .btn:hover {
            background: #6d4661;
        }
        .version-badge {
            background: #4CAF50;
            color: white;
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 0.9em;
            display: inline-block;
            margin: 10px 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <h1>🚀 $MODULE_TITLE</h1>
            <p>Solución completa para [DESCRIBIR FUNCIONALIDAD]</p>
            <div>
                <span class="version-badge">Odoo 18.0</span>
                <span class="version-badge">v1.0.0</span>
                <span class="version-badge">LGPL-3</span>
            </div>
        </div>

        <!-- Características -->
        <div class="features">
            <div class="feature">
                <h3>🎯 Características Principales</h3>
                <ul>
                    <li>Gestión completa de registros</li>
                    <li>Workflow automatizado de estados</li>
                    <li>Sistema de notificaciones</li>
                    <li>Reportes y análisis avanzados</li>
                    <li>Operaciones masivas</li>
                </ul>
            </div>
            
            <div class="feature">
                <h3>🔧 Funcionalidades Técnicas</h3>
                <ul>
                    <li>Herencia de mail.thread</li>
                    <li>Campos calculados y dependientes</li>
                    <li>Validaciones personalizadas</li>
                    <li>Wizards para procesamiento masivo</li>
                    <li>API REST endpoints</li>
                </ul>
            </div>
            
            <div class="feature">
                <h3>🌍 Soporte Empresarial</h3>
                <ul>
                    <li>Multicompañía</li>
                    <li>Internacionalización completa</li>
                    <li>Grupos de seguridad</li>
                    <li>Reglas de registro</li>
                    <li>Auditoría y trazabilidad</li>
                </ul>
            </div>
            
            <div class="feature">
                <h3>📊 Reportes y Analytics</h3>
                <ul>
                    <li>Vistas Pivot dinámicas</li>
                    <li>Gráficos interactivos</li>
                    <li>Reportes PDF personalizados</li>
                    <li>Exportación a Excel</li>
                    <li>Dashboard de métricas</li>
                </ul>
            </div>
        </div>

        <!-- Instalación -->
        <div class="installation">
            <h2>📦 Instalación Rápida</h2>
            <ol>
                <li><strong>Descargar</strong> el módulo desde el repositorio</li>
                <li><strong>Colocar</strong> en la carpeta addons de Odoo</li>
                <li><strong>Actualizar</strong> la lista de módulos</li>
                <li><strong>Instalar</strong> "$MODULE_TITLE"</li>
                <li><strong>Configurar</strong> permisos de usuario</li>
            </ol>
        </div>

        <!-- Soporte -->
        <div class="support">
            <h2>🤝 Soporte y Contacto</h2>
            <p>¿Necesitas ayuda con la implementación o personalización?</p>
            <a href="mailto:info@erply.do" class="btn">Contactar Soporte</a>
            <a href="https://erply.do" class="btn">Visitar ERPly</a>
            <a href="https://github.com/rob-erply" class="btn">Ver en GitHub</a>
        </div>
    </div>
</body>
</html>
EOF

    echo -e "${GREEN}✅ index.html creado exitosamente${NC}"
}

# Función para crear estructura de tests
create_tests() {
    echo -e "${BLUE}🧪 Creando estructura de tests...${NC}"
    
    mkdir -p "$TESTS_DIR"
    
    # __init__.py
    cat > "$TESTS_DIR/__init__.py" << 'EOF'
# -*- coding: utf-8 -*-
EOF
    
    # test_common.py
    cat > "$TESTS_DIR/test_common.py" << EOF
# -*- coding: utf-8 -*-
from odoo.tests.common import TransactionCase
from odoo.exceptions import ValidationError, UserError


class Test${MODULE_NAME^}Common(TransactionCase):
    """Clase base con utilidades comunes para los tests"""
    
    @classmethod
    def setUpClass(cls):
        super().setUpClass()
        
        # Datos de prueba reutilizables
        cls.partner_1 = cls.env['res.partner'].create({
            'name': 'Cliente Test 1',
            'is_company': True,
            'email': 'test1@ejemplo.com',
        })
        
        cls.partner_2 = cls.env['res.partner'].create({
            'name': 'Cliente Test 2',
            'is_company': True,
            'email': 'test2@ejemplo.com',
        })
        
        # TODO: Crear usuarios de prueba según los grupos del módulo
        # cls.user_employee = cls.env['res.users'].create({...})
        # cls.user_manager = cls.env['res.users'].create({...})
    
    def create_test_record(self, name='Test Record', **kwargs):
        """Método helper para crear registros de prueba"""
        values = {
            'name': name,
            # TODO: Agregar campos específicos del módulo
        }
        values.update(kwargs)
        # TODO: Cambiar por el modelo principal del módulo
        return self.env['${MODULE_NAME}.model'].create(values)
EOF
    
    # test_models.py - plantilla básica
    cat > "$TESTS_DIR/test_models.py" << EOF
# -*- coding: utf-8 -*-
from odoo.tests.common import tagged
from odoo.exceptions import ValidationError, UserError
from .test_common import Test${MODULE_NAME^}Common


@tagged('$MODULE_NAME', 'post_install', '-at_install')
class TestModels(Test${MODULE_NAME^}Common):
    """Tests para los modelos principales"""
    
    def test_create_record(self):
        """Test creación básica de registro"""
        record = self.create_test_record('Registro Test')
        
        self.assertEqual(record.name, 'Registro Test')
        self.assertTrue(record.active)
        # TODO: Agregar validaciones específicas del módulo
    
    def test_validations(self):
        """Test validaciones de modelo"""
        # TODO: Implementar tests de validaciones específicas
        pass
    
    def test_computed_fields(self):
        """Test campos calculados"""
        # TODO: Implementar tests de campos calculados
        pass


@tagged('$MODULE_NAME', 'security')
class TestSecurity(Test${MODULE_NAME^}Common):
    """Tests de seguridad y permisos"""
    
    def test_access_rights(self):
        """Test derechos de acceso"""
        # TODO: Implementar tests de permisos
        pass
    
    def test_record_rules(self):
        """Test reglas de registro"""
        # TODO: Implementar tests de record rules
        pass
EOF
    
    echo -e "${GREEN}✅ Estructura de tests creada exitosamente${NC}"
}

# Función para crear icono por defecto
create_icon() {
    echo -e "${BLUE}🎨 Creando icono por defecto...${NC}"
    
    mkdir -p "$STATIC_DIR"
    
    # Crear un SVG simple como placeholder
    cat > "$STATIC_DIR/icon.svg" << EOF
<svg width="128" height="128" viewBox="0 0 128 128" xmlns="http://www.w3.org/2000/svg">
  <rect width="128" height="128" fill="#875A7B" rx="20"/>
  <text x="64" y="80" text-anchor="middle" fill="white" font-family="Arial, sans-serif" font-size="48" font-weight="bold">
    $(echo ${MODULE_NAME:0:2} | tr '[:lower:]' '[:upper:]')
  </text>
</svg>
EOF
    
    echo -e "${YELLOW}💡 Se creó un icono SVG básico. Para usar en Odoo, convierte a PNG 128x128px${NC}"
    echo -e "${YELLOW}   Herramientas online: https://convertio.co/svg-png/${NC}"
    echo -e "${GREEN}✅ Icono SVG creado exitosamente${NC}"
}

# Ejecutar funciones según opciones
if [ "$CREATE_ALL" = true ] || [ "$CREATE_README" = true ]; then
    create_readme
fi

if [ "$CREATE_ALL" = true ] || [ "$CREATE_LICENSE" = true ]; then
    create_license
fi

if [ "$CREATE_ALL" = true ] || [ "$CREATE_HTML" = true ]; then
    create_html
fi

if [ "$CREATE_ALL" = true ] || [ "$CREATE_TESTS" = true ]; then
    create_tests
fi

if [ "$CREATE_ALL" = true ] || [ "$CREATE_ICON" = true ]; then
    create_icon
fi

echo ""
echo -e "${GREEN}🎉 ¡Documentación creada exitosamente para $MODULE_NAME!${NC}"
echo ""
echo -e "${BLUE}📁 Archivos creados:${NC}"

if [ "$CREATE_ALL" = true ] || [ "$CREATE_README" = true ]; then
    echo "   📄 $MODULE_DIR/README.md"
fi

if [ "$CREATE_ALL" = true ] || [ "$CREATE_LICENSE" = true ]; then
    echo "   📜 $MODULE_DIR/LICENSE"
fi

if [ "$CREATE_ALL" = true ] || [ "$CREATE_HTML" = true ]; then
    echo "   🌐 $MODULE_DIR/static/description/index.html"
fi

if [ "$CREATE_ALL" = true ] || [ "$CREATE_TESTS" = true ]; then
    echo "   🧪 $MODULE_DIR/tests/__init__.py"
    echo "   🧪 $MODULE_DIR/tests/test_common.py"
    echo "   🧪 $MODULE_DIR/tests/test_models.py"
fi

if [ "$CREATE_ALL" = true ] || [ "$CREATE_ICON" = true ]; then
    echo "   🎨 $MODULE_DIR/static/description/icon.svg"
fi

echo ""
echo -e "${YELLOW}📝 Próximos pasos:${NC}"
echo "   1. Personalizar el contenido según tu módulo específico"
echo "   2. Agregar capturas de pantalla en static/description/"
echo "   3. Si usaste --icon, convertir el SVG a PNG 128x128px"
echo "   4. Implementar los tests específicos de tu módulo"
echo "   5. Actualizar información de contacto y empresa"
echo ""
echo -e "${BLUE}💡 Tip: Usa 'git add .' para agregar todos los archivos al control de versiones${NC}"
