# -*- coding: utf-8 -*-
from odoo.tests.common import TransactionCase
from odoo.exceptions import ValidationError, UserError


class TestAddons_custom/prueba_manifest_profesionalCommon(TransactionCase):
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
        return self.env['addons_custom/prueba_manifest_profesional.model'].create(values)
