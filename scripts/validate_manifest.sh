#!/bin/bash

# Script para validar __manifest__.py de módulos Odoo
# Uso: ./validate_manifest.sh [path_to_module]

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Contadores
ERRORS=0
WARNINGS=0
SUGGESTIONS=0

# Función para mostrar ayuda
show_help() {
    echo -e "${BLUE}=== Validador de __manifest__.py para Módulos Odoo ===${NC}"
    echo ""
    echo "Uso: $0 [OPCIONES] [PATH_TO_MODULE]"
    echo ""
    echo "Opciones:"
    echo "  -h, --help      Mostrar esta ayuda"  
    echo "  -v, --verbose   Mostrar información detallada"
    echo "  -s, --strict    Validación estricta para Odoo Apps Store"
    echo "  --fix           Intentar reparar problemas automáticamente"
    echo ""
    echo "Ejemplos:"
    echo "  $0 addons_custom/mi_modulo"
    echo "  $0 --strict addons_custom/mi_modulo"
    echo "  $0 --verbose --fix mi_modulo"
}

# Función para logging
log_error() {
    echo -e "${RED}❌ ERROR: $1${NC}"
    ((ERRORS++))
}

log_warning() {
    echo -e "${YELLOW}⚠️  WARNING: $1${NC}"
    ((WARNINGS++))
}

log_suggestion() {
    echo -e "${PURPLE}💡 SUGGESTION: $1${NC}"
    ((SUGGESTIONS++))
}

log_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

log_info() {
    if [ "$VERBOSE" = true ]; then
        echo -e "${BLUE}ℹ️  $1${NC}"
    fi
}

# Función para validar campo obligatorio
validate_required_field() {
    local field=$1
    local value=$2
    local field_name=$3
    
    if [ -z "$value" ] || [ "$value" = "None" ] || [ "$value" = "''" ]; then
        log_error "Campo obligatorio '$field_name' faltante o vacío"
        return 1
    else
        log_info "$field_name: $value"
        return 0
    fi
}

# Función para validar versión semántica
validate_version() {
    local version=$1
    
    if [[ ! $version =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        log_error "Versión '$version' no sigue formato semántico: X.Y.Z.W.V"
        return 1
    fi
    
    # Verificar que empiece con versión de Odoo válida
    local odoo_version=$(echo $version | cut -d. -f1-2)
    case $odoo_version in
        "15.0"|"16.0"|"17.0"|"18.0"|"19.0")
            log_success "Versión de Odoo válida: $odoo_version"
            ;;
        *)
            log_warning "Versión de Odoo '$odoo_version' puede no ser válida"
            ;;
    esac
    
    return 0
}

# Función para validar licencia
validate_license() {
    local license=$1
    
    case $license in
        "AGPL-3"|"LGPL-3"|"GPL-3"|"MIT"|"BSD"|"OPL-1")
            log_success "Licencia válida: $license"
            ;;
        *)
            log_warning "Licencia '$license' puede no ser compatible con Odoo Apps Store"
            log_suggestion "Usar: AGPL-3, LGPL-3, GPL-3, MIT, BSD, o OPL-1"
            ;;
    esac
}

# Función para validar categoría
validate_category() {
    local category=$1
    
    local valid_categories=(
        "Accounting" "Sales" "Purchase" "Inventory" "Manufacturing"
        "Human Resources" "Marketing" "Website" "Point of Sale"
        "Productivity" "Services" "Extra Tools" "Theme" "Industries"
        "Localization"
    )
    
    local main_category=$(echo $category | cut -d'/' -f1)
    local is_valid=false
    
    for valid_cat in "${valid_categories[@]}"; do
        if [ "$main_category" = "$valid_cat" ]; then
            is_valid=true
            break
        fi
    done
    
    if [ "$is_valid" = true ]; then
        log_success "Categoría válida: $category"
    else
        log_warning "Categoría '$category' puede no ser válida"
        log_suggestion "Usar categorías estándar: ${valid_categories[*]}"
    fi
}

# Función para validar dependencias
validate_depends() {
    local depends=$1
    
    # Verificar que base esté incluido
    if [[ $depends != *"'base'"* ]]; then
        log_error "Dependencia 'base' es obligatoria"
    fi
    
    # Sugerir dependencias comunes que podrían faltar
    if [[ $depends == *"mail"* ]] && [[ $depends != *"'web'"* ]]; then
        log_suggestion "Si usa 'mail', considere incluir 'web' para funcionalidad completa"
    fi
}

# Función para validar estructura de archivos data
validate_data_files() {
    local data_files=$1
    local module_path=$2
    
    # Verificar orden recomendado
    local correct_order=(
        "security/ir.model.access.csv"
        "security/security.xml"
        "data/"
        "views/"
        "reports/"
        "wizards/"
    )
    
    # Verificar que archivos existen
    echo "$data_files" | grep -o "'[^']*'" | while read -r file; do
        file_path=$(echo $file | sed "s/'//g")
        full_path="$module_path/$file_path"
        
        if [ ! -f "$full_path" ]; then
            log_warning "Archivo declarado no existe: $file_path"
        fi
    done
}

# Función para validar assets
validate_assets() {
    local assets=$1
    local module_path=$2
    
    if [ -n "$assets" ]; then
        log_info "Assets definidos - verificando archivos..."
        
        # Extraer rutas de archivos de assets
        echo "$assets" | grep -o "'[^']*\\.js'" | while read -r js_file; do
            js_path=$(echo $js_file | sed "s/'//g" | sed "s|^[^/]*/||")
            full_path="$module_path/static/src/$js_path"
            
            if [ ! -f "$full_path" ]; then
                log_warning "Archivo JS declarado no existe: $js_path"
            fi
        done
        
        echo "$assets" | grep -o "'[^']*\\.css'" | while read -r css_file; do
            css_path=$(echo $css_file | sed "s/'//g" | sed "s|^[^/]*/||")
            full_path="$module_path/static/src/$css_path"
            
            if [ ! -f "$full_path" ]; then
                log_warning "Archivo CSS declarado no existe: $css_path"
            fi
        done
    fi
}

# Función principal de validación
validate_manifest() {
    local module_path=$1
    local manifest_file="$module_path/__manifest__.py"
    
    echo -e "${BLUE}🔍 Validando: $manifest_file${NC}"
    echo ""
    
    if [ ! -f "$manifest_file" ]; then
        log_error "Archivo __manifest__.py no encontrado en $module_path"
        return 1
    fi
    
    # Leer el manifest usando un método más robusto
    local manifest_content=$(python3 << EOF
import sys
import ast
import os

manifest_file = '$manifest_file'

try:
    # Leer archivo
    with open(manifest_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Compilar el código para verificar sintaxis
    try:
        compiled = compile(content, manifest_file, 'exec')
    except SyntaxError as e:
        print(f"SYNTAX_ERROR:{e}")
        sys.exit(1)
    
    # Ejecutar el código para obtener el diccionario
    namespace = {}
    exec(compiled, namespace)
    
    # El manifest debe ser el último valor asignado o el único valor del diccionario
    manifest_dict = None
    for key, value in namespace.items():
        if isinstance(value, dict) and 'name' in value:
            manifest_dict = value
            break
    
    if manifest_dict is None:
        # Intentar evaluar directamente el contenido
        # Buscar el diccionario principal
        lines = content.split('\n')
        dict_start = -1
        for i, line in enumerate(lines):
            if line.strip() == '{':
                dict_start = i
                break
        
        if dict_start >= 0:
            # Extraer solo el diccionario
            dict_content = '\n'.join(lines[dict_start:])
            # Encontrar el cierre del diccionario
            brace_count = 0
            dict_end = -1
            for i, char in enumerate(dict_content):
                if char == '{':
                    brace_count += 1
                elif char == '}':
                    brace_count -= 1
                    if brace_count == 0:
                        dict_end = i
                        break
            
            if dict_end > 0:
                dict_only = dict_content[:dict_end + 1]
                manifest_dict = eval(dict_only)
    
    if manifest_dict is None:
        print("ERROR_NO_DICT:No se pudo encontrar el diccionario del manifest")
        sys.exit(1)
    
    # Imprimir campos clave con formato especial para evitar problemas de parsing
    def safe_print(key, value):
        if isinstance(value, str):
            # Escapar caracteres problemáticos
            value = value.replace('\n', '\\n').replace('\r', '\\r')
        elif isinstance(value, list):
            value = str(value).replace('\n', '\\n')
        elif isinstance(value, dict):
            value = str(value).replace('\n', '\\n')
        print(f"{key}:{value}")
    
    safe_print("NAME", manifest_dict.get('name', ''))
    safe_print("VERSION", manifest_dict.get('version', ''))
    safe_print("SUMMARY", manifest_dict.get('summary', ''))
    safe_print("LICENSE", manifest_dict.get('license', ''))
    safe_print("AUTHOR", manifest_dict.get('author', ''))
    safe_print("WEBSITE", manifest_dict.get('website', ''))
    safe_print("CATEGORY", manifest_dict.get('category', ''))
    safe_print("DEPENDS", manifest_dict.get('depends', []))
    safe_print("DATA", manifest_dict.get('data', []))
    safe_print("ASSETS", manifest_dict.get('assets', {}))
    safe_print("APPLICATION", manifest_dict.get('application', False))
    safe_print("INSTALLABLE", manifest_dict.get('installable', True))
    safe_print("AUTO_INSTALL", manifest_dict.get('auto_install', False))
    safe_print("PRICE", manifest_dict.get('price', ''))
    safe_print("ICON", manifest_dict.get('icon', ''))
    safe_print("DESCRIPTION", manifest_dict.get('description', ''))
    
except Exception as e:
    print(f"ERROR_PARSING:{e}")
    import traceback
    traceback.print_exc()
EOF
)
    
    if [[ $manifest_content == *"ERROR_PARSING"* ]]; then
        log_error "Error al parsear __manifest__.py: $(echo $manifest_content | cut -d: -f2-)"
        return 1
    fi
    
    # Extraer valores
    local name=$(echo "$manifest_content" | grep "^NAME:" | cut -d: -f2-)
    local version=$(echo "$manifest_content" | grep "^VERSION:" | cut -d: -f2-)
    local summary=$(echo "$manifest_content" | grep "^SUMMARY:" | cut -d: -f2-)
    local license=$(echo "$manifest_content" | grep "^LICENSE:" | cut -d: -f2-)
    local author=$(echo "$manifest_content" | grep "^AUTHOR:" | cut -d: -f2-)
    local website=$(echo "$manifest_content" | grep "^WEBSITE:" | cut -d: -f2-)
    local category=$(echo "$manifest_content" | grep "^CATEGORY:" | cut -d: -f2-)
    local depends=$(echo "$manifest_content" | grep "^DEPENDS:" | cut -d: -f2-)
    local data=$(echo "$manifest_content" | grep "^DATA:" | cut -d: -f2-)
    local assets=$(echo "$manifest_content" | grep "^ASSETS:" | cut -d: -f2-)
    local application=$(echo "$manifest_content" | grep "^APPLICATION:" | cut -d: -f2-)
    local installable=$(echo "$manifest_content" | grep "^INSTALLABLE:" | cut -d: -f2-)
    local price=$(echo "$manifest_content" | grep "^PRICE:" | cut -d: -f2-)
    local icon=$(echo "$manifest_content" | grep "^ICON:" | cut -d: -f2-)
    
    echo -e "${BLUE}📋 Validando campos obligatorios...${NC}"
    
    # Validar campos obligatorios
    validate_required_field "name" "$name" "Nombre"
    validate_required_field "version" "$version" "Versión"
    validate_required_field "license" "$license" "Licencia"
    validate_required_field "author" "$author" "Autor"
    validate_required_field "category" "$category" "Categoría"
    
    # Validaciones específicas
    if [ -n "$version" ]; then
        echo -e "\n${BLUE}📊 Validando versión...${NC}"
        validate_version "$version"
    fi
    
    if [ -n "$license" ]; then
        echo -e "\n${BLUE}📜 Validando licencia...${NC}"
        validate_license "$license"
    fi
    
    if [ -n "$category" ]; then
        echo -e "\n${BLUE}🏷️  Validando categoría...${NC}"
        validate_category "$category"
    fi
    
    if [ -n "$depends" ]; then
        echo -e "\n${BLUE}🔗 Validando dependencias...${NC}"
        validate_depends "$depends"
    fi
    
    if [ -n "$data" ]; then
        echo -e "\n${BLUE}📁 Validando archivos de datos...${NC}"
        validate_data_files "$data" "$module_path"
    fi
    
    if [ -n "$assets" ]; then
        echo -e "\n${BLUE}🎨 Validando assets...${NC}"
        validate_assets "$assets" "$module_path"
    fi
    
    # Validaciones para Odoo Apps Store (modo estricto)
    if [ "$STRICT" = true ]; then
        echo -e "\n${BLUE}🏪 Validando para Odoo Apps Store...${NC}"
        
        if [ -z "$summary" ]; then
            log_error "Campo 'summary' es obligatorio para Odoo Apps Store"
        elif [ ${#summary} -gt 60 ]; then
            log_warning "Summary muy largo (${#summary} chars). Máximo recomendado: 60"
        fi
        
        if [ -z "$website" ]; then
            log_error "Campo 'website' es obligatorio para Odoo Apps Store"
        fi
        
        if [ -z "$icon" ]; then
            log_error "Campo 'icon' es obligatorio para Odoo Apps Store"
        else
            icon_path="$module_path/$(echo $icon | sed "s/'//g")"
            if [ ! -f "$icon_path" ]; then
                log_error "Archivo de icono no encontrado: $icon"
            fi
        fi
        
        # Verificar archivos de descripción
        local desc_dir="$module_path/static/description"
        if [ ! -d "$desc_dir" ]; then
            log_error "Directorio static/description/ faltante (requerido para Apps Store)"
        else
            if [ ! -f "$desc_dir/index.html" ]; then
                log_suggestion "Considere agregar index.html para mejor presentación"
            fi
            
            local screenshots=$(find "$desc_dir" -name "screenshot*.png" 2>/dev/null | wc -l)
            if [ $screenshots -eq 0 ]; then
                log_suggestion "Agregar screenshots para mejorar presentación en Apps Store"
            fi
        fi
    fi
    
    # Verificar estructura de archivos del módulo
    echo -e "\n${BLUE}📂 Validando estructura del módulo...${NC}"
    
    local required_files=("__init__.py")
    for req_file in "${required_files[@]}"; do
        if [ ! -f "$module_path/$req_file" ]; then
            log_error "Archivo requerido faltante: $req_file"
        fi
    done
    
    # Verificar directorios estándar
    local std_dirs=("models" "views" "security")
    for std_dir in "${std_dirs[@]}"; do
        if [ -d "$module_path/$std_dir" ]; then
            local file_count=$(find "$module_path/$std_dir" -name "*.py" -o -name "*.xml" -o -name "*.csv" | wc -l)
            if [ $file_count -eq 0 ]; then
                log_warning "Directorio '$std_dir' existe pero está vacío"
            fi
        fi
    done
}

# Procesamiento de argumentos
VERBOSE=false
STRICT=false
FIX=false
MODULE_PATH=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -s|--strict)
            STRICT=true
            shift
            ;;
        --fix)
            FIX=true
            shift
            ;;
        *)
            if [ -z "$MODULE_PATH" ]; then
                MODULE_PATH=$1
            fi
            shift
            ;;
    esac
done

# Validar parámetros
if [ -z "$MODULE_PATH" ]; then
    echo -e "${RED}Error: Debe especificar la ruta del módulo${NC}"
    show_help
    exit 1
fi

# Convertir a ruta absoluta si es necesaria
if [[ ! "$MODULE_PATH" = /* ]]; then
    MODULE_PATH="$(pwd)/$MODULE_PATH"
fi

# Verificar que el directorio existe
if [ ! -d "$MODULE_PATH" ]; then
    echo -e "${RED}Error: Directorio '$MODULE_PATH' no encontrado${NC}"
    exit 1
fi

# Ejecutar validación
echo -e "${BLUE}=== Validador de Manifest Odoo ===${NC}"
echo ""

validate_manifest "$MODULE_PATH"

# Mostrar resumen
echo ""
echo -e "${BLUE}📊 Resumen de validación:${NC}"
echo -e "   Errores: ${RED}$ERRORS${NC}"
echo -e "   Warnings: ${YELLOW}$WARNINGS${NC}"
echo -e "   Sugerencias: ${PURPLE}$SUGGESTIONS${NC}"

if [ $ERRORS -eq 0 ]; then
    if [ $WARNINGS -eq 0 ]; then
        echo -e "\n${GREEN}🎉 ¡Manifest válido! Sin errores ni warnings.${NC}"
        exit 0
    else
        echo -e "\n${YELLOW}⚠️  Manifest válido con warnings. Revise las sugerencias.${NC}"
        exit 0
    fi
else
    echo -e "\n${RED}❌ Manifest tiene errores críticos. Corrija antes de continuar.${NC}"
    exit 1
fi
