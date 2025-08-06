@tagged('addons_custom/prueba_manifest_profesional', 'post_install', '-at_install')
class TestModels(TestPruebaManifestProfesionalCommon):
    def test_estado_done(self):
        """Prueba que el registro solo puede ser completado desde estado confirmado."""
        registro = self.create_test_record(state='confirmed')

# -*- coding: utf-8 -*-
from odoo.tests.common import tagged
from .test_common import TestPruebaManifestProfesionalCommon

@tagged('addons_custom/prueba_manifest_profesional', 'post_install', '-at_install')
class TestModels(TestPruebaManifestProfesionalCommon):
    """
    Pruebas automáticas para el módulo Prueba Manifest Profesional.
    Estas pruebas se ejecutan automáticamente en Odoo.sh.
    """

    def test_creacion_registro(self):
        """Debe crear un registro profesional correctamente."""
        registro = self.create_test_record('Registro de Prueba')
        self.assertEqual(registro.name, 'Registro de Prueba')
        self.assertTrue(registro.active)
        self.assertEqual(registro.state, 'draft')
        self.assertIsNotNone(registro.partner_id)
        self.assertIsNotNone(registro.user_id)
        self.assertIsNotNone(registro.company_id)

    def test_validacion_fecha_limite(self):
        """No debe permitir una fecha límite anterior a hoy."""
        from odoo.exceptions import ValidationError
        registro = self.create_test_record(date_deadline='2000-01-01')
        with self.assertRaises(ValidationError):
            registro._check_date_deadline()

    def test_importe_total_calculado(self):
        """El importe total debe calcularse correctamente."""
        registro = self.create_test_record()
        registro._compute_total_amount()
        self.assertEqual(registro.total_amount, 0.0)

    def test_estado_confirmado(self):
        """Solo se puede confirmar desde estado borrador."""
        registro = self.create_test_record(state='draft')
        registro.action_confirm()
        self.assertEqual(registro.state, 'confirmed')
        registro.state = 'done'
        with self.assertRaises(Exception):
            registro.action_confirm()

    def test_estado_done(self):
        """Solo se puede completar desde estado confirmado."""
        registro = self.create_test_record(state='confirmed')
        registro.action_done()
        self.assertEqual(registro.state, 'done')
        registro.state = 'draft'
        with self.assertRaises(Exception):
            registro.action_done()

@tagged('addons_custom/prueba_manifest_profesional', 'security')
class TestSecurity(TestPruebaManifestProfesionalCommon):
    """
    Pruebas de seguridad y permisos para el módulo.
    """

    def test_permisos_acceso(self):
        """Verifica los permisos de acceso definidos en el modelo."""
        self.assertTrue(True)  # Ejemplo básico

    def test_reglas_registro(self):
        """Verifica las reglas de registro del modelo."""
        self.assertTrue(True)  # Ejemplo básico
    
    def test_campo_calculado_importe(self):
        """Prueba el cálculo del importe total"""
        registro = self.create_test_record()
        registro._compute_total_amount()
        self.assertEqual(registro.total_amount, 0.0)


@tagged('addons_custom/prueba_manifest_profesional', 'security')
class TestSecurity(TestPruebaManifestProfesionalCommon):
    """Tests de seguridad y permisos"""
    
    def test_permisos_acceso(self):
        """Prueba los permisos de acceso para el modelo"""
        # Aquí se pueden agregar pruebas de acceso según los grupos definidos
        self.assertTrue(True)  # Ejemplo básico
    
    def test_reglas_registro(self):
        """Prueba las reglas de registro del modelo"""
        # Aquí se pueden agregar pruebas de reglas de registro
        self.assertTrue(True)  # Ejemplo básico
