# -*- coding: utf-8 -*-
from odoo import models, fields, api, _
from odoo.exceptions import ValidationError
import logging

_logger = logging.getLogger(__name__)

class Pruebamanifestprofesional(models.Model):
    _name = 'prueba_manifest_profesional.prueba_manifest_profesional'
    _description = 'Modelo Principal de prueba manifest profesional'
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

    # Ejemplo de restricción profesional: el nombre debe tener al menos 3 caracteres
    @api.constrains('name')
    def _check_name_length(self):
        for record in self:
            if record.name and len(record.name) < 3:
                raise ValidationError(_('El nombre debe tener al menos 3 caracteres.'))

    # Ejemplo de método on-change profesional
    @api.onchange('partner_id')
    def _onchange_partner_id(self):
        """
        Al seleccionar un contacto, se actualiza la descripción con el nombre del contacto.
        """
        if self.partner_id:
            self.description = f"Registro vinculado a: {self.partner_id.name}"

    # Ejemplo de lógica profesional: confirmar registro
    def action_confirmar(self):
        """
        Método profesional para confirmar el registro y dejar constancia en el chatter.
        """
        for record in self:
            record.state = 'confirmed'
            record.message_post(body=_('Registro confirmado correctamente.'))
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
        """
        Calcula el importe total del registro. Aquí puedes agregar la lógica real de negocio.
        """
        for record in self:
            # Ejemplo: sumar importes de líneas relacionadas (si existieran)
            record.total_amount = 0.0
    
    @api.constrains('date_deadline')
    def _check_date_deadline(self):
        """
        Valida que la fecha límite no sea anterior a la fecha actual.
        """
        for record in self:
            if record.date_deadline and record.date_deadline < fields.Date.today():
                raise ValidationError(_('La fecha límite no puede ser anterior a hoy (%s).') % fields.Date.today())

    @api.constrains('total_amount')
    def _check_total_amount(self):
        """
        Valida que el importe total no sea negativo.
        """
        for record in self:
            if record.total_amount < 0:
                raise ValidationError(_('El importe total no puede ser negativo.'))
    
    def action_confirm(self):
        """
        Cambia el estado a 'confirmado' solo si está en borrador.
        """
        for record in self:
            if record.state != 'draft':
                raise ValidationError(_('Solo se puede confirmar un registro en estado borrador.'))
            record.write({'state': 'confirmed'})
        return True
    
    def action_done(self):
        """
        Cambia el estado a 'completado' solo si está confirmado.
        """
        for record in self:
            if record.state != 'confirmed':
                raise ValidationError(_('Solo se puede completar un registro confirmado.'))
            record.write({'state': 'done'})
        return True
    
    def action_cancel(self):
        """
        Cancela el registro en cualquier estado.
        """
        self.write({'state': 'cancelled'})
        return True
    
    def action_reset_to_draft(self):
        """
        Regresa el registro al estado borrador solo si está cancelado.
        """
        for record in self:
            if record.state != 'cancelled':
                raise ValidationError(_('Solo se puede regresar a borrador desde cancelado.'))
            record.write({'state': 'draft'})
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
