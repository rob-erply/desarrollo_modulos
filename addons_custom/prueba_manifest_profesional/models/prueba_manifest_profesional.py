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
