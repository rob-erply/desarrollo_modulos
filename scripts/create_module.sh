#!/bin/bash
# Script para crear estructura completa de módulo Odoo 18
# Uso: ./scripts/create_module.sh nombre_modulo [--company "Mi Empresa"]

set -e

# Función para mostrar ayuda
show_help() {
    echo "Uso: $0 [OPCIONES] nombre_modulo"
    echo ""
    echo "Opciones:"
    echo "  -c, --company    Nombre de la empresa/autor (default: 'Tu Empresa')"
    echo "  -h, --help       Mostrar esta ayuda"
    echo ""
    echo "Ejemplos:"
    echo "  $0 mi_modulo"
    echo "  $0 mi_modulo --company 'Mi Empresa S.L.'"
}

# Valores por defecto
COMPANY_NAME="Tu Empresa"
MODULE_NAME=""

# Procesar argumentos
while [[ $# -gt 0 ]]; do
    case $1 in
        -c|--company)
            COMPANY_NAME="$2"
            shift 2
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            if [ -z "$MODULE_NAME" ]; then
                MODULE_NAME="$1"
            fi
            shift
            ;;
    esac
done

if [ -z "$MODULE_NAME" ]; then
    echo "Error: Especifica el nombre del módulo"
    show_help
    exit 1
fi

MODULE_DIR="addons_custom/$MODULE_NAME"

echo "Creando estructura completa para módulo: $MODULE_NAME"
echo "Empresa/Autor: $COMPANY_NAME"

# Crear directorios
mkdir -p "$MODULE_DIR"/{models,views,security,i18n,data,static/{description,src/{js,css,xml}},controllers,report,tests,wizard}

# Crear archivos básicos
echo "Creando archivos básicos..."

# __init__.py principal
cat > "$MODULE_DIR/__init__.py" << 'EOF'
# -*- coding: utf-8 -*-
from . import models
from . import controllers
from . import report
from . import wizard
EOF

# __manifest__.py - Manifest Profesional
MODULE_TITLE=$(echo "$MODULE_NAME" | sed 's/_/ /g' | sed 's/\b\w/\U&/g')
cat > "$MODULE_DIR/__manifest__.py" << EOF
# -*- coding: utf-8 -*-
{
    # === INFORMACIÓN BÁSICA ===
    'name': '$MODULE_TITLE',
    'summary': 'Módulo personalizado para [DESCRIBIR FUNCIONALIDAD ESPECÍFICA]',
    'description': """
        $MODULE_TITLE
        
        Este módulo proporciona funcionalidades avanzadas para:
        • Gestión completa de registros específicos
        • Workflow automatizado con estados controlados
        • Sistema de notificaciones y seguimiento
        • Reportes y análisis personalizados
        • Integración con módulos core de Odoo
        
        Características técnicas:
        • Herencia de mail.thread para seguimiento
        • Campos calculados con optimización
        • Validaciones personalizadas robustas
        • Wizards para operaciones masivas
        • API endpoints para integraciones
        
        Beneficios empresariales:
        • Mejora la eficiencia operativa
        • Automatiza procesos manuales
        • Proporciona trazabilidad completa
        • Facilita la toma de decisiones
        • Cumple con estándares de calidad
    """,
    
    # === VERSIONADO Y LICENCIA ===
    'version': '18.0.1.0.0',        # Odoo 18, release 1, stable
    'license': 'AGPL-3',            # Compatible con Odoo Community
    
    # === INFORMACIÓN DEL AUTOR ===
    'author': '$COMPANY_NAME',
    'maintainer': '$COMPANY_NAME Development Team',
    'website': 'https://tu-empresa.com',
    'support': 'soporte@tu-empresa.com',
    
    # === CATEGORIZACIÓN ===
    'category': 'Extra Tools',       # Cambiar según corresponda
    'tags': ['productivity', 'management', 'automation'],
    
    # === DEPENDENCIAS ===
    'depends': [
        'base',                      # Funcionalidades básicas de Odoo
        'mail',                      # Sistema de mensajería y chatter
        'web',                       # Interfaz web y funcionalidades AJAX
        # Agregar otras dependencias según necesidades:
        # 'account',                 # Para funcionalidad contable
        # 'sale',                    # Para integración con ventas
        # 'purchase',                # Para integración con compras
        # 'stock',                   # Para gestión de inventario
        # 'hr',                      # Para recursos humanos
        # 'project',                 # Para gestión de proyectos
    ],
    
    # === ARCHIVOS DE DATOS ===
    'data': [
        # Seguridad (ORDEN IMPORTANTE)
        'security/ir.model.access.csv',    # Primero: derechos de acceso
        'security/security.xml',           # Segundo: grupos y reglas
        
        # Datos maestros
        'data/sequences.xml',              # Secuencias numericas
        'data/data.xml',                   # Datos iniciales
        'data/mail_templates.xml',         # Plantillas de email
        'data/cron_jobs.xml',              # Tareas programadas (si las hay)
        
        # Vistas (en orden lógico)
        'views/${MODULE_NAME}_views.xml',   # Vistas principales
        'views/${MODULE_NAME}_menus.xml',   # Menús y acciones
        'views/inherited_views.xml',        # Herencias de vistas existentes
        
        # Reportes
        'reports/report_templates.xml',     # Templates de reportes
        'reports/paperformat.xml',          # Formatos de papel (si es necesario)
        
        # Wizards
        'wizards/${MODULE_NAME}_wizard_views.xml',  # Vistas de wizards
    ],
    
    # === DATOS DE DEMOSTRACIÓN ===
    'demo': [
        'demo/demo_data.xml',              # Datos de prueba
        'demo/demo_users.xml',             # Usuarios de demo
    ],
    
    # === DEPENDENCIAS EXTERNAS ===
    'external_dependencies': {
        'python': [
            # Agregar librerías Python necesarias:
            # 'requests',              # Para llamadas HTTP
            # 'lxml',                  # Para procesamiento XML
            # 'pillow',                # Para procesamiento imágenes  
            # 'openpyxl',              # Para archivos Excel
            # 'reportlab',             # Para generación PDF
        ],
        'bin': [
            # Agregar binarios del sistema necesarios:
            # 'wkhtmltopdf',           # Para reportes PDF avanzados
        ],
    },
    
    # === CONFIGURACIÓN DEL MÓDULO ===
    'application': False,               # True si es app principal con menú raíz
    'auto_install': False,              # True para instalación automática
    'installable': True,                # True para disponibilidad de instalación
    
    # === ASSETS WEB ===
    'assets': {
        'web.assets_backend': [
            # JavaScript para backend
            '${MODULE_NAME}/static/src/js/widget.js',
            '${MODULE_NAME}/static/src/js/views.js',
            # CSS para backend  
            '${MODULE_NAME}/static/src/css/styles.css',
        ],
        'web.assets_frontend': [
            # JavaScript para frontend (si aplica)
            '${MODULE_NAME}/static/src/js/public.js',
            # CSS para frontend
            '${MODULE_NAME}/static/src/css/public.css',
        ],
        'web.qunit_suite_tests': [
            # Tests JavaScript (si los hay)
            '${MODULE_NAME}/static/src/js/tests/*.js',
        ],
    },
    
    # === RECURSOS ADICIONALES ===
    'images': [
        'static/description/banner.png',        # Banner promocional
        'static/description/screenshot1.png',   # Capturas de pantalla
        'static/description/screenshot2.png',
    ],
    'icon': 'static/description/icon.png',      # Icono 128x128px mínimo
    
    # === METADATOS TÉCNICOS ===
    'sequence': 100,                           # Orden de instalación
    'complexity': 'normal',                    # easy, normal, expert
    'development_status': 'Beta',              # Alpha, Beta, Production/Stable, Mature
    'technical_name': '${MODULE_NAME}',        # Nombre técnico
    
    # === COMPATIBILIDAD ===
    'odoo_version': '18.0',                    # Versión específica de Odoo
    'python_requires': '>=3.10',              # Versión mínima de Python
    
    # === HOOKS DE INSTALACIÓN (si son necesarios) ===
    # 'pre_init_hook': 'pre_init_hook',        # Función antes de instalar
    # 'post_init_hook': 'post_init_hook',      # Función después de instalar  
    # 'uninstall_hook': 'uninstall_hook',      # Función al desinstalar
    # 'post_load': 'post_load_hook',           # Función al cargar módulo
    
    # === INFORMACIÓN COMERCIAL (si aplica) ===
    # 'price': 0.00,                           # Precio del módulo
    # 'currency': 'EUR',                       # Moneda del precio
    # 'live_test_url': 'https://demo.tu-empresa.com',  # URL de demostración
}
EOF

# models/__init__.py
cat > "$MODULE_DIR/models/__init__.py" << EOF
# -*- coding: utf-8 -*-
from . import ${MODULE_NAME}
from . import res_partner
EOF

# Modelo principal
cat > "$MODULE_DIR/models/${MODULE_NAME}.py" << EOF
# -*- coding: utf-8 -*-
from odoo import models, fields, api, _
from odoo.exceptions import ValidationError
import logging

_logger = logging.getLogger(__name__)

class $(echo "$MODULE_NAME" | sed 's/_//g' | sed 's/\b\(.\)/\u\1/g')(models.Model):
    _name = '${MODULE_NAME}.${MODULE_NAME}'
    _description = 'Modelo Principal de $(echo "$MODULE_NAME" | sed 's/_/ /g')'
    _inherit = ['mail.thread', 'mail.activity.mixin']
    _rec_name = 'name'
    _order = 'create_date desc'

    # Campos básicos
    name = fields.Char(
        string='Nombre',
        required=True,
        tracking=True,
        help='Nombre identificativo del registro'
    )
    
    description = fields.Text(
        string='Descripción',
        help='Descripción detallada'
    )
    
    state = fields.Selection([
        ('draft', 'Borrador'),
        ('confirmed', 'Confirmado'),
        ('done', 'Completado'),
        ('cancelled', 'Cancelado'),
    ], string='Estado', default='draft', tracking=True)
    
    active = fields.Boolean(
        string='Activo',
        default=True,
        help='Si está desmarcado, oculta el registro sin eliminarlo'
    )
    
    # Campos relacionales
    partner_id = fields.Many2one(
        'res.partner',
        string='Cliente/Proveedor',
        required=True,
        help='Contacto asociado'
    )
    
    user_id = fields.Many2one(
        'res.users',
        string='Usuario Responsable',
        default=lambda self: self.env.user,
        required=True
    )
    
    company_id = fields.Many2one(
        'res.company',
        string='Compañía',
        default=lambda self: self.env.company,
        required=True
    )
    
    # Campos calculados
    total_amount = fields.Float(
        string='Importe Total',
        compute='_compute_total_amount',
        store=True,
        help='Importe total calculado'
    )
    
    # Campos de fechas
    date_created = fields.Datetime(
        string='Fecha de Creación',
        default=fields.Datetime.now,
        readonly=True
    )
    
    date_deadline = fields.Date(
        string='Fecha Límite',
        help='Fecha límite para completar'
    )
    
    @api.depends('partner_id')
    def _compute_total_amount(self):
        for record in self:
            # Lógica de cálculo personalizada
            record.total_amount = 0.0
    
    @api.constrains('date_deadline')
    def _check_date_deadline(self):
        for record in self:
            if record.date_deadline and record.date_deadline < fields.Date.today():
                raise ValidationError(_('La fecha límite no puede ser anterior a hoy.'))
    
    def action_confirm(self):
        self.write({'state': 'confirmed'})
        return True
    
    def action_done(self):
        self.write({'state': 'done'})
        return True
    
    def action_cancel(self):
        self.write({'state': 'cancelled'})
        return True
    
    def action_reset_to_draft(self):
        self.write({'state': 'draft'})
        return True
    
    @api.model
    def create(self, vals):
        # Lógica personalizada en creación
        result = super().create(vals)
        _logger.info(f'Creado registro {result.name}')
        return result
    
    def write(self, vals):
        # Lógica personalizada en escritura
        result = super().write(vals)
        return result
    
    def unlink(self):
        # Validaciones antes de eliminar
        for record in self:
            if record.state == 'done':
                raise ValidationError(_('No se puede eliminar un registro completado.'))
        return super().unlink()
EOF

echo "✅ Estructura del módulo '$MODULE_NAME' creada exitosamente en $MODULE_DIR"
echo "📝 Siguiente paso: Personalizar los archivos según tus necesidades"
echo "🚀 Instalar con: ./scripts/start.sh -db dev -i $MODULE_NAME"
