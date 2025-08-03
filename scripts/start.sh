#!/bin/bash

# Script simplificado para arrancar Odoo 18
# Uso: ./scripts/start.sh [opciones]

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuración por defecto
ODOO_BIN="/workspaces/proevedor_cardnet/odoo/odoo-bin"
CONFIG_FILE="/workspaces/proevedor_cardnet/config/odoo.conf"
LOG_LEVEL="info"
DEV_MODE=""
DATABASE=""
UPDATE_MODULE=""
INSTALL_MODULE=""

# Función de ayuda
show_help() {
    echo -e "${BLUE}Odoo 18 - Script de arranque simplificado${NC}"
    echo ""
    echo "Uso: $0 [opciones]"
    echo ""
    echo "Opciones:"
    echo "  -h, --help              Mostrar esta ayuda"
    echo "  -d, --dev               Modo desarrollo (auto-reload)"
    echo "  -db, --database NAME    Especificar base de datos"
    echo "  -u, --update MODULE     Actualizar módulo específico"
    echo "  -i, --install MODULE    Instalar módulo específico"
    echo "  -l, --log-level LEVEL   Nivel de log (debug, info, warn, error)"
    echo "  --init-db               Inicializar nueva base de datos"
    echo "  --shell                 Abrir shell de Odoo"
    echo ""
    echo "Ejemplos:"
    echo "  $0                      # Arranque normal"
    echo "  $0 -d                   # Modo desarrollo"
    echo "  $0 -db mydb -u sale     # Actualizar módulo 'sale' en BD 'mydb'"
    echo "  $0 --init-db -db newdb  # Crear nueva base de datos"
}

# Verificar que Odoo esté disponible
check_odoo() {
    if [ ! -f "$ODOO_BIN" ]; then
        echo -e "${RED}Error: Odoo no encontrado en $ODOO_BIN${NC}"
        echo -e "${YELLOW}Ejecuta primero: ./scripts/setup.sh${NC}"
        exit 1
    fi
}

# Verificar PostgreSQL
check_postgres() {
    echo -e "${BLUE}Verificando PostgreSQL...${NC}"
    until pg_isready -h localhost -p 5432 -U odoo >/dev/null 2>&1; do
        echo -e "${YELLOW}Esperando PostgreSQL...${NC}"
        sleep 2
    done
    echo -e "${GREEN}PostgreSQL listo!${NC}"
}

# Parsear argumentos
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        -d|--dev)
            DEV_MODE="--dev=reload,qweb,werkzeug,xml"
            shift
            ;;
        -db|--database)
            DATABASE="$2"
            shift 2
            ;;
        -u|--update)
            UPDATE_MODULE="$2"
            shift 2
            ;;
        -i|--install)
            INSTALL_MODULE="$2"
            shift 2
            ;;
        -l|--log-level)
            LOG_LEVEL="$2"
            shift 2
            ;;
        --init-db)
            INIT_DB="--init=base --stop-after-init"
            shift
            ;;
        --shell)
            SHELL_MODE="shell"
            shift
            ;;
        *)
            echo -e "${RED}Opción desconocida: $1${NC}"
            show_help
            exit 1
            ;;
    esac
done

# Verificaciones previas
check_odoo
check_postgres

# Construir comando
CMD="python3 $ODOO_BIN -c $CONFIG_FILE --log-level=$LOG_LEVEL"

# Agregar opciones según parámetros
if [ ! -z "$DATABASE" ]; then
    CMD="$CMD -d $DATABASE"
fi

if [ ! -z "$DEV_MODE" ]; then
    CMD="$CMD $DEV_MODE"
fi

if [ ! -z "$UPDATE_MODULE" ]; then
    CMD="$CMD -u $UPDATE_MODULE --stop-after-init"
fi

if [ ! -z "$INSTALL_MODULE" ]; then
    CMD="$CMD -i $INSTALL_MODULE --stop-after-init"
fi

if [ ! -z "$INIT_DB" ]; then
    CMD="$CMD $INIT_DB"
fi

if [ ! -z "$SHELL_MODE" ]; then
    CMD="$CMD $SHELL_MODE"
fi

# Mostrar información de arranque
echo -e "${GREEN}=== Desarrollo Módulos Odoo 18 ===${NC}"
echo -e "${BLUE}Configuración:${NC}"
echo -e "  • Archivo config: $CONFIG_FILE"
echo -e "  • Nivel de log: $LOG_LEVEL"
if [ ! -z "$DATABASE" ]; then
    echo -e "  • Base de datos: $DATABASE"
fi
if [ ! -z "$DEV_MODE" ]; then
    echo -e "  • Modo desarrollo: ${GREEN}ACTIVADO${NC}"
fi
echo ""

# Ejecutar comando
echo -e "${BLUE}Ejecutando:${NC} $CMD"
echo ""
exec $CMD
