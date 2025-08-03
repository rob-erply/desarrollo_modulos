# Ejemplos de Archivos por Componente

## 1. __manifest__.py - Descripción Técnica Completa

```python
# -*- coding: utf-8 -*-
{
    'name': 'Mi Módulo Profesional',
    'version': '18.0.1.0.0',
    'category': 'Extra Tools',
    'sequence': 100,
    'summary': 'Gestión completa de procesos de negocio',
    'description': '''
        Módulo completo que incluye:
        =================================
        
        Funcionalidades Principales:
        • Gestión de registros personalizados
        • Workflow de estados automatizado
        • Integration con partners y usuarios
        • Reportes PDF personalizados
        • Dashboard con métricas
        
        Características Técnicas:
        • Modelos con herencia de mail.thread
        • Validaciones personalizadas
        • Campos calculados y dependientes
        • Acciones de servidor personalizadas
        • API REST endpoints
        
        Integraciones:
        • Sistema de notificaciones
        • Plantillas de email
        • Exportación de datos
        • Logs de auditoría
    ''',
    'author': 'Tu Empresa S.L.',
    'website': 'https://tu-empresa.com',
    'license': 'LGPL-3',
    'depends': [
        'base',
        'mail',
        'web',
        'sale',            # Si necesitas ventas
        'account',         # Si necesitas contabilidad
        'stock',           # Si necesitas inventario
        'hr',              # Si necesitas RRHH
    ],
    'external_dependencies': {
        'python': ['requests', 'pandas'],  # Dependencias Python externas
        'bin': ['wkhtmltopdf'],            # Binarios necesarios
    },
    'data': [
        # Seguridad (siempre primero)
        'security/security.xml',
        'security/ir.model.access.csv',
        
        # Datos maestros
        'data/sequences.xml',
        'data/data.xml',
        'data/mail_templates.xml',
        'data/cron_jobs.xml',
        
        # Vistas (orden lógico)
        'views/mi_modelo_views.xml',
        'views/mi_modelo_menus.xml',
        'views/inherited_views.xml',
        
        # Reportes
        'report/report_actions.xml',
        'report/templates.xml',
        
        # Wizards
        'wizard/mi_wizard_views.xml',
    ],
    'demo': [
        'demo/demo_data.xml',  # Datos de demostración
    ],
    'assets': {
        'web.assets_backend': [
            'mi_modulo/static/src/css/backend.css',
            'mi_modulo/static/src/js/backend.js',
        ],
        'web.assets_frontend': [
            'mi_modulo/static/src/css/frontend.css',
            'mi_modulo/static/src/js/frontend.js',
        ],
        'web.assets_qweb': [
            'mi_modulo/static/src/xml/templates.xml',
        ],
    },
    'images': [
        'static/description/banner.png',
        'static/description/screenshot1.png',
        'static/description/screenshot2.png',
    ],
    'installable': True,
    'auto_install': False,
    'application': True,        # True = App principal, False = módulo técnico
    'post_init_hook': 'post_init_hook',  # Función después de instalar
    'uninstall_hook': 'uninstall_hook',  # Función antes de desinstalar
}
```

## 2. __init__.py - Carga Inicial del Módulo

```python
# -*- coding: utf-8 -*-

# Importar modelos
from . import models

# Importar controladores (si existen)
from . import controllers

# Importar reportes (si existen)
from . import report

# Importar wizards (si existen)
from . import wizard


def post_init_hook(env):
    """
    Hook ejecutado después de la instalación del módulo.
    Útil para configuraciones iniciales, migraciones de datos, etc.
    """
    # Ejemplo: Crear datos iniciales
    company = env['res.company'].search([], limit=1)
    if company:
        # Configurar parámetros específicos del módulo
        env['ir.config_parameter'].sudo().set_param(
            'mi_modulo.empresa_principal', 
            company.id
        )


def uninstall_hook(env):
    """
    Hook ejecutado antes de la desinstalación del módulo.
    Útil para limpiar datos, configuraciones, etc.
    """
    # Ejemplo: Limpiar parámetros del sistema
    env['ir.config_parameter'].sudo().search([
        ('key', 'like', 'mi_modulo.%')
    ]).unlink()
```

## 3. models/__init__.py - Importación de Modelos

```python
# -*- coding: utf-8 -*-

# Modelos principales del módulo
from . import mi_modelo_principal
from . import mi_modelo_secundario

# Extensiones de modelos existentes
from . import res_partner
from . import res_users
from . import sale_order

# Modelos de configuración (si existen)
from . import mi_configuracion
```

## 4. Ejemplo de Modelo Completo

```python
# models/mi_modelo_principal.py
# -*- coding: utf-8 -*-
from odoo import models, fields, api, _
from odoo.exceptions import UserError, ValidationError
from datetime import datetime, timedelta
import logging

_logger = logging.getLogger(__name__)


class MiModeloPrincipal(models.Model):
    _name = 'mi.modelo.principal'
    _description = 'Modelo Principal del Sistema'
    _inherit = ['mail.thread', 'mail.activity.mixin']
    _rec_name = 'name'
    _order = 'sequence, name'
    _sql_constraints = [
        ('name_unique', 'UNIQUE(name)', 'El nombre debe ser único'),
        ('amount_positive', 'CHECK(amount >= 0)', 'El importe debe ser positivo'),
    ]

    # === CAMPOS BÁSICOS ===
    name = fields.Char(
        'Nombre',
        required=True,
        tracking=True,
        translate=True,  # Permite traducción
        help='Nombre identificativo del registro'
    )
    
    code = fields.Char(
        'Código',
        size=20,
        index=True,  # Crear índice en BD
        help='Código único del registro'
    )
    
    sequence = fields.Integer(
        'Secuencia',
        default=10,
        help='Orden de visualización'
    )
    
    # === CAMPOS DE ESTADO ===
    state = fields.Selection([
        ('draft', 'Borrador'),
        ('confirmed', 'Confirmado'),
        ('approved', 'Aprobado'),
        ('done', 'Completado'),
        ('cancelled', 'Cancelado'),
    ], string='Estado', default='draft', tracking=True, copy=False)
    
    active = fields.Boolean('Activo', default=True)
    
    # === CAMPOS RELACIONALES ===
    partner_id = fields.Many2one(
        'res.partner',
        'Cliente/Proveedor',
        required=True,
        domain="[('is_company', '=', True)]",
        context="{'default_is_company': True}",
        help='Contacto asociado al registro'
    )
    
    user_id = fields.Many2one(
        'res.users',
        'Responsable',
        default=lambda self: self.env.user,
        tracking=True
    )
    
    company_id = fields.Many2one(
        'res.company',
        'Compañía',
        default=lambda self: self.env.company,
        required=True
    )
    
    # === CAMPOS MONETARIOS ===
    currency_id = fields.Many2one(
        'res.currency',
        'Moneda',
        default=lambda self: self.env.company.currency_id
    )
    
    amount = fields.Monetary(
        'Importe',
        currency_field='currency_id',
        tracking=True
    )
    
    # === CAMPOS CALCULADOS ===
    amount_total = fields.Monetary(
        'Total',
        compute='_compute_amount_total',
        store=True,
        currency_field='currency_id'
    )
    
    line_count = fields.Integer(
        'Número de Líneas',
        compute='_compute_line_count'
    )
    
    # === CAMPOS DE FECHA ===
    date_created = fields.Datetime(
        'Fecha Creación',
        default=fields.Datetime.now,
        readonly=True
    )
    
    date_deadline = fields.Date('Fecha Límite')
    
    # === RELACIONES ONE2MANY ===
    line_ids = fields.One2many(
        'mi.modelo.linea',
        'parent_id',
        'Líneas',
        copy=True
    )
    
    # === CAMPOS DE TEXTO ===
    description = fields.Html('Descripción')
    notes = fields.Text('Notas Internas')
    
    # === CAMPOS BINARIOS ===
    attachment = fields.Binary('Archivo Adjunto')
    attachment_name = fields.Char('Nombre del Archivo')
    
    # === MÉTODOS COMPUTE ===
    @api.depends('line_ids.amount')
    def _compute_amount_total(self):
        for record in self:
            record.amount_total = sum(record.line_ids.mapped('amount'))
    
    @api.depends('line_ids')
    def _compute_line_count(self):
        for record in self:
            record.line_count = len(record.line_ids)
    
    # === VALIDACIONES ===
    @api.constrains('date_deadline')
    def _check_date_deadline(self):
        for record in self:
            if record.date_deadline and record.date_deadline < fields.Date.today():
                raise ValidationError(_('La fecha límite no puede ser anterior a hoy'))
    
    @api.constrains('amount')
    def _check_amount_positive(self):
        for record in self:
            if record.amount < 0:
                raise ValidationError(_('El importe debe ser positivo'))
    
    # === ONCHANGE ===
    @api.onchange('partner_id')
    def _onchange_partner_id(self):
        if self.partner_id:
            self.currency_id = self.partner_id.currency_id or self.env.company.currency_id
    
    # === MÉTODOS DE ACCIÓN ===
    def action_confirm(self):
        """Confirmar registro"""
        for record in self:
            if record.state != 'draft':
                raise UserError(_('Solo se pueden confirmar registros en borrador'))
            record.write({
                'state': 'confirmed'
            })
            # Enviar notificación
            record.message_post(
                body=_('Registro confirmado por %s') % self.env.user.name,
                message_type='notification'
            )
        return True
    
    def action_approve(self):
        """Aprobar registro"""
        self.ensure_one()
        if self.state != 'confirmed':
            raise UserError(_('Solo se pueden aprobar registros confirmados'))
        
        self.write({'state': 'approved'})
        
        # Crear actividad para el responsable
        self.activity_schedule(
            'mail.mail_activity_data_todo',
            summary=_('Registro aprobado - Proceder con siguiente paso'),
            user_id=self.user_id.id
        )
        return True
    
    # === MÉTODOS CRON ===
    @api.model
    def cron_check_deadlines(self):
        """Método ejecutado por cron para verificar fechas límite"""
        tomorrow = fields.Date.today() + timedelta(days=1)
        records = self.search([
            ('date_deadline', '=', tomorrow),
            ('state', 'in', ['confirmed', 'approved'])
        ])
        
        for record in records:
            record.activity_schedule(
                'mail.mail_activity_data_warning',
                summary=_('Fecha límite mañana: %s') % record.name,
                user_id=record.user_id.id
            )
    
    # === SOBRESCRITURA DE MÉTODOS ===
    @api.model
    def create(self, vals):
        # Generar código automático si no se proporciona
        if not vals.get('code'):
            vals['code'] = self.env['ir.sequence'].next_by_code('mi.modelo.principal') or '/'
        
        result = super().create(vals)
        
        # Log de creación
        _logger.info('Creado registro %s (%s)', result.name, result.code)
        
        return result
    
    def write(self, vals):
        # Validar cambios en estado
        if 'state' in vals and vals['state'] == 'done':
            for record in self:
                if not record.line_ids:
                    raise UserError(_('No se puede completar un registro sin líneas'))
        
        result = super().write(vals)
        
        # Log de modificación
        if 'state' in vals:
            _logger.info('Cambiado estado de %s a %s', self.mapped('name'), vals['state'])
        
        return result
    
    def unlink(self):
        # Validar eliminación
        for record in self:
            if record.state == 'done':
                raise UserError(_('No se pueden eliminar registros completados'))
        
        return super().unlink()
    
    # === MÉTODOS DE UTILIDAD ===
    def name_get(self):
        """Personalizar nombre mostrado"""
        result = []
        for record in self:
            name = f"[{record.code}] {record.name}"
            if record.state != 'draft':
                name += f" ({dict(record._fields['state'].selection)[record.state]})"
            result.append((record.id, name))
        return result
    
    @api.model
    def name_search(self, name='', args=None, operator='ilike', limit=100):
        """Búsqueda personalizada por nombre y código"""
        args = args or []
        if name:
            args = ['|', ('name', operator, name), ('code', operator, name)] + args
        return self.search(args, limit=limit).name_get()


# === MODELO DE LÍNEAS ===
class MiModeloLinea(models.Model):
    _name = 'mi.modelo.linea'
    _description = 'Líneas del Modelo Principal'
    _order = 'sequence, id'

    parent_id = fields.Many2one(
        'mi.modelo.principal',
        'Registro Principal',
        required=True,
        ondelete='cascade'
    )
    
    sequence = fields.Integer('Secuencia', default=10)
    
    name = fields.Char('Descripción', required=True)
    
    quantity = fields.Float('Cantidad', default=1.0)
    
    price_unit = fields.Monetary(
        'Precio Unitario',
        currency_field='currency_id'
    )
    
    amount = fields.Monetary(
        'Importe',
        compute='_compute_amount',
        store=True,
        currency_field='currency_id'
    )
    
    currency_id = fields.Many2one(
        related='parent_id.currency_id',
        store=True
    )
    
    @api.depends('quantity', 'price_unit')
    def _compute_amount(self):
        for line in self:
            line.amount = line.quantity * line.price_unit
```

Esta estructura proporciona un ejemplo completo y profesional de cómo organizar un módulo Odoo 18 con todos los componentes que mencionaste. ¿Te gustaría que continue con ejemplos de los archivos XML de vistas, seguridad, datos, etc.?
