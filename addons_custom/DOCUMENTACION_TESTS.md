# Ejemplos de Documentación y Tests

## 11. README.md - Guía para el Usuario

```markdown
# Mi Módulo Personalizado

[![License: LGPL-3](https://img.shields.io/badge/License-LGPL%20v3-blue.svg)](https://www.gnu.org/licenses/lgpl-3.0)
[![Odoo Version](https://img.shields.io/badge/Odoo-18.0-brightgreen.svg)](https://github.com/odoo/odoo/tree/18.0)

## 📋 Descripción

Este módulo proporciona funcionalidades avanzadas para la gestión de [descripción específica del módulo].

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
- `base` - Funcionalidades básicas
- `mail` - Sistema de mensajería
- `web` - Interfaz web

### Pasos de Instalación

1. **Clonar el repositorio**:
   ```bash
   git clone [url-del-repositorio]
   cd addons_custom/mi_modulo
   ```

2. **Agregar el módulo al path de addons**:
   - Agregar la ruta en el archivo de configuración de Odoo
   - O copiar el módulo a la carpeta de addons existente

3. **Actualizar la lista de módulos**:
   - Ir a Apps > Actualizar Lista de Apps
   - O ejecutar: `./odoo-bin -u all --stop-after-init`

4. **Instalar el módulo**:
   - Buscar "Mi Módulo Personalizado" en Apps
   - Hacer clic en "Instalar"

## 📖 Guía de Uso

### Configuración Initial

1. **Configurar Permisos**:
   - Ir a Configuración > Usuarios y Compañías > Grupos
   - Asignar usuarios a los grupos "Usuario" o "Manager"

2. **Configurar Secuencias**:
   - Las secuencias se crean automáticamente
   - Personalizable en Configuración > Secuencias e Identificadores > Secuencias

### Operaciones Básicas

#### Crear un Nuevo Registro

1. Navegar a **Mi Módulo > Registros**
2. Hacer clic en **Crear**
3. Completar los campos obligatorios:
   - **Nombre**: Identificador del registro
   - **Cliente/Proveedor**: Contacto asociado
   - **Responsable**: Usuario asignado
4. Hacer clic en **Guardar**

#### Gestionar Estados

Los registros siguen un workflow definido:

- **Borrador** → **Confirmado** → **Aprobado** → **Completado**
- Los usuarios pueden **Cancelar** en cualquier momento
- Solo los Managers pueden **Aprobar** registros

#### Operaciones Masivas

1. Seleccionar múltiples registros en la vista lista
2. Ir a **Acción > Procesamiento Masivo**
3. Elegir la operación deseada:
   - Confirmar registros
   - Cancelar registros
   - Actualizar cliente
   - Generar reporte

### Reportes y Análisis

#### Vista Pivot
- Acceder desde **Mi Módulo > Reportes > Análisis**
- Personalizar dimensiones y métricas
- Exportar a Excel

#### Reportes PDF
- Generar desde cualquier registro individual
- O usar procesamiento masivo para múltiples registros

## 🔧 Personalización

### Campos Personalizados

Para agregar campos adicionales:

1. Heredar el modelo en un módulo personalizado:
   ```python
   from odoo import models, fields
   
   class MiModeloPersonalizado(models.Model):
       _inherit = 'mi.modelo.principal'
       
       mi_campo_nuevo = fields.Char('Mi Campo')
   ```

2. Actualizar las vistas correspondientes

### Validaciones Personalizadas

```python
from odoo import api
from odoo.exceptions import ValidationError

@api.constrains('mi_campo')
def _check_mi_campo(self):
    for record in self:
        if record.mi_campo and len(record.mi_campo) < 3:
            raise ValidationError("El campo debe tener al menos 3 caracteres")
```

## 🧪 Testing


### Ejecución de pruebas automáticas en Odoo.sh

Las pruebas automáticas se ejecutan al hacer push al repositorio conectado a Odoo.sh. Los resultados aparecen en la interfaz de Odoo.sh y en los logs de CI/CD.

#### Ejemplo avanzado de test
```python
from odoo.tests.common import TransactionCase, tagged

@tagged('registro', 'workflow')
class TestRegistroProfesional(TransactionCase):
    """
    Pruebas automáticas para el modelo registro.profesional
    """
    def setUp(self):
        super().setUp()
        self.registro = self.env['registro.profesional'].create({
            'name': 'Ejemplo',
            'descripcion': 'Prueba avanzada',
        })

    def test_creacion_registro(self):
        """Verifica la creación de un registro profesional"""
        self.assertEqual(self.registro.name, 'Ejemplo')

    def test_validacion_estado(self):
        """Valida el cambio de estado del registro"""
        self.registro.action_confirmar()
        self.assertEqual(self.registro.state, 'confirmado')

    def test_permisos_manager(self):
        """Verifica que solo el manager puede cancelar registros"""
        # ...aquí iría la lógica de permisos...
```

#### Checklist profesional para pruebas en Odoo.sh
- [x] Pruebas de creación y validación de datos
- [x] Pruebas de workflow y transiciones de estado
- [x] Pruebas de permisos y reglas de acceso
- [x] Pruebas de integración con otros módulos

#### Recomendaciones
- Agrupa las pruebas por funcionalidad y usa decoradores
- Documenta cada método de prueba en español
- Simula escenarios reales de negocio
- Mantén las pruebas actualizadas con cada cambio

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

#### Performance Lenta
- Verificar índices en campos de búsqueda frecuente
- Optimizar dominios de búsqueda
- Revisar campos calculados sin `store=True`

### Logs de Debug

Para activar logs detallados:

```bash
python3 odoo-bin --log-level=debug --log-handler=odoo.addons.mi_modulo:DEBUG
```

## 📞 Soporte

### Reportar Bugs

1. Ir a [Issues del repositorio]
2. Usar la plantilla de bug report
3. Incluir:
   - Versión de Odoo
   - Pasos para reproducir
   - Logs de error
   - Capturas de pantalla

### Solicitar Funcionalidades

1. Crear un nuevo Issue con la etiqueta "enhancement"
2. Describir detalladamente la funcionalidad deseada
3. Incluir casos de uso específicos

## 🤝 Contribuir

### Proceso de Contribución

1. Fork del repositorio
2. Crear rama para la funcionalidad: `git checkout -b feature/nueva-funcionalidad`
3. Realizar cambios y tests
4. Commit con mensaje descriptivo
5. Push y crear Pull Request

### Estándares de Código

- Seguir [OCA Guidelines](https://github.com/OCA/odoo-community.org/blob/master/website/Contribution/CONTRIBUTING.rst)
- Usar `black` para formateo
- Documentar métodos complejos
- Incluir tests para nuevas funcionalidades

## 📄 Licencia

Este módulo está licenciado bajo LGPL-3.0. Ver archivo [LICENSE](LICENSE) para detalles.

## 🙏 Créditos

- **Autor**: Tu Nombre
- **Empresa**: Tu Empresa S.L.
- **Colaboradores**: Lista de colaboradores

## 📚 Recursos Adicionales

- [Documentación Oficial de Odoo](https://www.odoo.com/documentation/18.0/)
- [OCA (Odoo Community Association)](https://github.com/OCA)
- [Odoo Apps Store](https://apps.odoo.com/)

---

**¿Necesitas ayuda?** Contacta a [email@tuempresa.com](mailto:email@tuempresa.com)
```

## 12. LICENSE - Archivo de Licencia

### Ejemplo LGPL-3.0 (Recomendado para Odoo)

```
GNU LESSER GENERAL PUBLIC LICENSE
Version 3, 29 June 2007

Copyright (C) 2024 Tu Empresa S.L.

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
```

### Ejemplo MIT (Más Permisiva)

```
MIT License

Copyright (c) 2024 Tu Empresa S.L.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## 13. static/description/index.html - Descripción Visual

```html
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mi Módulo Personalizado</title>
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
        .screenshots {
            margin: 30px 0;
        }
        .screenshots h2 {
            color: #875A7B;
            text-align: center;
            margin-bottom: 20px;
        }
        .screenshot {
            text-align: center;
            margin: 20px 0;
        }
        .screenshot img {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .screenshot p {
            margin-top: 10px;
            font-style: italic;
            color: #666;
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
            <h1>🚀 Mi Módulo Personalizado</h1>
            <p>Solución completa para la gestión avanzada de procesos de negocio</p>
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

        <!-- Screenshots -->
        <div class="screenshots">
            <h2>📸 Capturas de Pantalla</h2>
            
            <div class="screenshot">
                <img src="screenshot1.png" alt="Vista Lista Principal" />
                <p>Vista lista con filtros avanzados y operaciones masivas</p>
            </div>
            
            <div class="screenshot">
                <img src="screenshot2.png" alt="Formulario de Registro" />
                <p>Formulario completo con workflow de estados y chatter</p>
            </div>
        </div>

        <!-- Instalación -->
        <div class="installation">
            <h2>📦 Instalación Rápida</h2>
            <ol>
                <li><strong>Descargar</strong> el módulo desde el repositorio</li>
                <li><strong>Colocar</strong> en la carpeta addons de Odoo</li>
                <li><strong>Actualizar</strong> la lista de módulos</li>
                <li><strong>Instalar</strong> "Mi Módulo Personalizado"</li>
                <li><strong>Configurar</strong> permisos de usuario</li>
            </ol>
        </div>

        <!-- Soporte -->
        <div class="support">
            <h2>🤝 Soporte y Contacto</h2>
            <p>¿Necesitas ayuda con la implementación o personalización?</p>
            <a href="mailto:soporte@tuempresa.com" class="btn">Contactar Soporte</a>
            <a href="https://github.com/tu-repo" class="btn">Ver en GitHub</a>
            <a href="https://tu-sitio.com/docs" class="btn">Documentación</a>
        </div>
    </div>
</body>
</html>
```

## 14. tests/ - Tests Unitarios y Funcionales

### tests/__init__.py

```python
# -*- coding: utf-8 -*-
```

### tests/test_common.py - Utilidades Comunes

```python
# -*- coding: utf-8 -*-
from odoo.tests.common import TransactionCase
from odoo.exceptions import ValidationError, UserError


class TestMiModuloCommon(TransactionCase):
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
        
        cls.user_employee = cls.env['res.users'].create({
            'name': 'Usuario Empleado Test',
            'login': 'employee_test',
            'email': 'employee@test.com',
            'groups_id': [(6, 0, [cls.env.ref('mi_modulo.group_user').id])],
        })
        
        cls.user_manager = cls.env['res.users'].create({
            'name': 'Usuario Manager Test',
            'login': 'manager_test',
            'email': 'manager@test.com',
            'groups_id': [(6, 0, [cls.env.ref('mi_modulo.group_manager').id])],
        })
    
    def create_test_record(self, name='Test Record', **kwargs):
        """Método helper para crear registros de prueba"""
        values = {
            'name': name,
            'partner_id': self.partner_1.id,
            'user_id': self.env.user.id,
            'amount': 1000.0,
        }
        values.update(kwargs)
        return self.env['mi.modelo.principal'].create(values)
```

### tests/test_mi_modelo.py - Tests del Modelo Principal

```python
# -*- coding: utf-8 -*-
from odoo.tests.common import tagged
from odoo.exceptions import ValidationError, UserError
from datetime import date, timedelta
from .test_common import TestMiModuloCommon


@tagged('mi_modulo', 'post_install', '-at_install')
class TestMiModeloPrincipal(TestMiModuloCommon):
    """Tests para el modelo principal"""
    
    def test_create_record(self):
        """Test creación básica de registro"""
        record = self.create_test_record('Registro Test')
        
        self.assertEqual(record.name, 'Registro Test')
        self.assertEqual(record.state, 'draft')
        self.assertEqual(record.partner_id, self.partner_1)
        self.assertTrue(record.active)
        self.assertTrue(record.code)  # Código automático generado
    
    def test_record_sequence(self):
        """Test generación automática de secuencias"""
        record1 = self.create_test_record('Record 1')
        record2 = self.create_test_record('Record 2')
        
        self.assertTrue(record1.code)
        self.assertTrue(record2.code)
        self.assertNotEqual(record1.code, record2.code)
        self.assertTrue(record1.code.startswith('MM'))
    
    def test_state_transitions(self):
        """Test transiciones de estado"""
        record = self.create_test_record()
        
        # Estado inicial
        self.assertEqual(record.state, 'draft')
        
        # Confirmar
        record.action_confirm()
        self.assertEqual(record.state, 'confirmed')
        
        # Aprobar
        record.action_approve()
        self.assertEqual(record.state, 'approved')
        
        # Completar
        record.action_done()
        self.assertEqual(record.state, 'done')
    
    def test_invalid_state_transition(self):
        """Test transiciones de estado inválidas"""
        record = self.create_test_record()
        record.state = 'done'
        
        # No se puede confirmar un registro completado
        with self.assertRaises(UserError):
            record.action_confirm()
    
    def test_date_deadline_validation(self):
        """Test validación de fecha límite"""
        yesterday = date.today() - timedelta(days=1)
        
        with self.assertRaises(ValidationError):
            self.create_test_record(
                name='Record with past deadline',
                date_deadline=yesterday
            )
    
    def test_amount_validation(self):
        """Test validación de importe positivo"""
        with self.assertRaises(ValidationError):
            self.create_test_record(
                name='Record with negative amount',
                amount=-100.0
            )
    
    def test_unlink_restrictions(self):
        """Test restricciones de eliminación"""
        record = self.create_test_record()
        record.state = 'done'
        
        # No se puede eliminar un registro completado
        with self.assertRaises(UserError):
            record.unlink()
    
    def test_compute_amount_total(self):
        """Test cálculo de importe total"""
        record = self.create_test_record()
        
        # Crear líneas
        line1 = self.env['mi.modelo.linea'].create({
            'parent_id': record.id,
            'name': 'Línea 1',
            'quantity': 2,
            'price_unit': 100.0,
        })
        
        line2 = self.env['mi.modelo.linea'].create({
            'parent_id': record.id,
            'name': 'Línea 2',
            'quantity': 1,
            'price_unit': 50.0,
        })
        
        # Verificar cálculos
        self.assertEqual(line1.amount, 200.0)
        self.assertEqual(line2.amount, 50.0)
        self.assertEqual(record.amount_total, 250.0)
        self.assertEqual(record.line_count, 2)
    
    def test_onchange_partner(self):
        """Test onchange del partner"""
        # Partner con moneda específica
        eur_currency = self.env.ref('base.EUR')
        partner_eur = self.env['res.partner'].create({
            'name': 'Partner EUR',
            'currency_id': eur_currency.id,
        })
        
        record = self.create_test_record()
        
        # Simular onchange
        record.partner_id = partner_eur
        record._onchange_partner_id()
        
        self.assertEqual(record.currency_id, eur_currency)
    
    def test_name_get(self):
        """Test método name_get personalizado"""
        record = self.create_test_record('Test Record')
        
        name_get_result = record.name_get()
        expected_name = f"[{record.code}] Test Record (Borrador)"
        
        self.assertEqual(name_get_result[0][1], expected_name)
    
    def test_name_search(self):
        """Test búsqueda personalizada"""
        record = self.create_test_record('Búsqueda Test')
        
        # Buscar por nombre
        found_by_name = self.env['mi.modelo.principal'].name_search('Búsqueda')
        self.assertIn(record.id, [r[0] for r in found_by_name])
        
        # Buscar por código
        found_by_code = self.env['mi.modelo.principal'].name_search(record.code[:5])
        self.assertIn(record.id, [r[0] for r in found_by_code])


@tagged('mi_modulo', 'post_install', '-at_install')
class TestMiModeloLinea(TestMiModuloCommon):
    """Tests para el modelo de líneas"""
    
    def test_line_amount_computation(self):
        """Test cálculo de importe en líneas"""
        record = self.create_test_record()
        
        line = self.env['mi.modelo.linea'].create({
            'parent_id': record.id,
            'name': 'Test Line',
            'quantity': 3,
            'price_unit': 25.50,
        })
        
        self.assertEqual(line.amount, 76.50)
        self.assertEqual(line.currency_id, record.currency_id)


@tagged('mi_modulo', 'security')
class TestMiModeloSecurity(TestMiModuloCommon):
    """Tests de seguridad y permisos"""
    
    def test_user_permissions(self):
        """Test permisos de usuario básico"""
        # Crear registro como usuario empleado
        record = self.create_test_record().with_user(self.user_employee)
        
        # Debe poder leer y escribir sus propios registros
        self.assertTrue(record.read())
        record.write({'name': 'Modified Name'})
        
        # No debe poder eliminar
        with self.assertRaises(Exception):
            record.unlink()
    
    def test_manager_permissions(self):
        """Test permisos de manager"""
        record = self.create_test_record().with_user(self.user_manager)
        
        # Manager debe tener todos los permisos
        self.assertTrue(record.read())
        record.write({'name': 'Manager Modified'})
        
        # Crear otro registro para eliminar
        test_record = self.create_test_record('To Delete')
        test_record.with_user(self.user_manager).unlink()
    
    def test_multicompany_rules(self):
        """Test reglas multicompañía"""
        # Crear segunda compañía
        company2 = self.env['res.company'].create({
            'name': 'Test Company 2'
        })
        
        # Registro en compañía actual
        record1 = self.create_test_record('Company 1 Record')
        
        # Registro en segunda compañía
        record2 = self.create_test_record(
            'Company 2 Record',
            company_id=company2.id
        )
        
        # Usuario solo debe ver registros de su compañía
        user_company2 = self.user_employee.copy({
            'name': 'User Company 2',
            'login': 'user_company2',
            'company_ids': [(6, 0, [company2.id])],
            'company_id': company2.id,
        })
        
        accessible_records = self.env['mi.modelo.principal'].with_user(user_company2).search([])
        self.assertIn(record2.id, accessible_records.ids)
        self.assertNotIn(record1.id, accessible_records.ids)
```

### tests/test_wizard.py - Tests de Wizards

```python
# -*- coding: utf-8 -*-
from odoo.tests.common import tagged
from odoo.exceptions import UserError
from .test_common import TestMiModuloCommon


@tagged('mi_modulo', 'wizard')
class TestMiWizard(TestMiModuloCommon):
    """Tests para wizards"""
    
    def test_wizard_confirm_records(self):
        """Test confirmación masiva mediante wizard"""
        # Crear registros de prueba
        record1 = self.create_test_record('Record 1')
        record2 = self.create_test_record('Record 2')
        records = record1 + record2
        
        # Crear wizard con contexto
        wizard = self.env['mi.wizard'].with_context(
            active_ids=records.ids,
            active_model='mi.modelo.principal'
        ).create({
            'action_type': 'confirm',
            'notes': 'Confirmación masiva de prueba'
        })
        
        # Verificar valores por defecto
        self.assertEqual(len(wizard.record_ids), 2)
        self.assertEqual(wizard.record_count, 2)
        
        # Ejecutar acción
        wizard.action_confirm()
        
        # Verificar resultados
        self.assertEqual(record1.state, 'confirmed')
        self.assertEqual(record2.state, 'confirmed')
    
    def test_wizard_update_partner(self):
        """Test actualización masiva de cliente"""
        record1 = self.create_test_record('Record 1')
        record2 = self.create_test_record('Record 2')
        
        wizard = self.env['mi.wizard'].with_context(
            active_ids=[record1.id, record2.id]
        ).create({
            'action_type': 'update_partner',
            'partner_id': self.partner_2.id
        })
        
        wizard.action_confirm()
        
        # Verificar cambio de cliente
        self.assertEqual(record1.partner_id, self.partner_2)
        self.assertEqual(record2.partner_id, self.partner_2)
    
    def test_wizard_validation(self):
        """Test validaciones del wizard"""
        # Wizard sin registros seleccionados
        wizard = self.env['mi.wizard'].create({
            'action_type': 'confirm'
        })
        
        with self.assertRaises(UserError):
            wizard.action_confirm()
        
        # Wizard de actualización sin cliente
        record = self.create_test_record()
        wizard = self.env['mi.wizard'].with_context(
            active_ids=[record.id]
        ).create({
            'action_type': 'update_partner'
        })
        
        with self.assertRaises(UserError):
            wizard.action_confirm()


@tagged('mi_modulo', 'performance')
class TestMiModeloPerformance(TestMiModuloCommon):
    """Tests de rendimiento"""
    
    def test_bulk_creation(self):
        """Test creación masiva de registros"""
        # Crear 100 registros
        records_data = [{
            'name': f'Bulk Record {i}',
            'partner_id': self.partner_1.id,
            'amount': 100.0 * i,
        } for i in range(1, 101)]
        
        records = self.env['mi.modelo.principal'].create(records_data)
        
        self.assertEqual(len(records), 100)
        self.assertTrue(all(r.code for r in records))  # Todos tienen código
    
    def test_search_performance(self):
        """Test rendimiento de búsquedas"""
        # Crear registros con datos variados
        for i in range(50):
            self.create_test_record(
                name=f'Search Test {i}',
                partner_id=self.partner_1.id if i % 2 == 0 else self.partner_2.id
            )
        
        # Búsquedas con diferentes filtros
        draft_records = self.env['mi.modelo.principal'].search([('state', '=', 'draft')])
        partner1_records = self.env['mi.modelo.principal'].search([('partner_id', '=', self.partner_1.id)])
        
        self.assertGreaterEqual(len(draft_records), 50)
        self.assertGreaterEqual(len(partner1_records), 25)
```

# Documentación de Pruebas Automáticas

## Objetivo

Este documento describe los casos de prueba implementados para el módulo Prueba Manifest Profesional.

## Casos de prueba incluidos

- **Creación de registros:** Verifica que se puedan crear registros con los campos obligatorios.
- **Validación de fecha límite:** Asegura que no se permita una fecha límite anterior a la actual.
- **Cálculo de importe total:** Comprueba que el importe total se calcule correctamente.
- **Transiciones de estado:** Valida que solo se puedan realizar cambios de estado permitidos.
- **Permisos y reglas de acceso:** Confirma que los usuarios y managers tengan los permisos adecuados.

## Ejecución de pruebas

Para ejecutar las pruebas automáticas, utiliza el siguiente comando en el entorno Odoo:

```bash
python3 odoo-bin -d <nombre_base_datos> --test-enable --stop-after-init -i prueba_manifest_profesional
```

## Resultados esperados

- Todas las pruebas deben pasar sin errores.
- Los mensajes de error y validación estarán en español para facilitar la comprensión.
