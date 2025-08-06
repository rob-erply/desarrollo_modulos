# -*- coding: utf-8 -*-
from odoo import models, fields

class ResPartner(models.Model):
    _inherit = 'res.partner'

    # Campo personalizado: código interno del cliente/proveedor
    codigo_interno = fields.Char(
        string='Código Interno',
        help='Código único interno para identificar al contacto',
        tracking=True
    )

    def obtener_codigo_interno(self):
        """
        Devuelve el código interno del contacto. Si no existe, retorna un mensaje informativo.
        """
        if self.codigo_interno:
            return self.codigo_interno
        return 'Sin código asignado'
