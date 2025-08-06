# Ejemplo: Crear un Módulo Simple

Este es un ejemplo paso a paso para crear tu primer módulo personalizado en Odoo 18.


# Ejemplo profesional de módulo Odoo para Odoo.sh

## Estructura recomendada
```
mi_modulo/
├── __init__.py
├── __manifest__.py
├── models/
│   └── mi_modelo.py
├── views/
│   └── mi_modelo_views.xml
├── security/
│   └── ir.model.access.csv
├── tests/
│   └── test_mi_modelo.py
└── README.md
```

## Ejemplo de manifest profesional
```python
{
    'name': 'Mi Módulo Profesional',
    'version': '1.0.0',
    'author': 'ERPly S.R.L.',
    'category': 'Herramientas',
    'summary': 'Gestión profesional de registros con workflow y permisos',
    'description': 'Módulo profesional para Odoo.sh con pruebas automáticas y documentación en español.',
    'depends': ['base', 'mail'],
    'data': [
        'security/ir.model.access.csv',
        'views/mi_modelo_views.xml',
    ],
    'installable': True,
    'application': True,
}
```

## Ejemplo de modelo profesional
```python
from odoo import models, fields, api

class MiModelo(models.Model):
    _name = 'mi.modelo'
    _description = 'Mi Modelo Profesional'

    name = fields.Char('Nombre', required=True)
    descripcion = fields.Text('Descripción')
    state = fields.Selection([
        ('borrador', 'Borrador'),
        ('confirmado', 'Confirmado'),
        ('aprobado', 'Aprobado'),
        ('completado', 'Completado'),
    ], string='Estado', default='borrador')

    def action_confirmar(self):
        self.state = 'confirmado'
```

## Ejemplo de vista profesional
```xml
<record id="view_form_mi_modelo" model="ir.ui.view">
    <field name="name">mi.modelo.form</field>
    <field name="model">mi.modelo</field>
    <field name="arch" type="xml">
        <form string="Mi Modelo Profesional">
            <sheet>
                <group>
                    <field name="name"/>
                    <field name="descripcion"/>
                    <field name="state"/>
                </group>
                <footer>
                    <button name="action_confirmar" type="object" string="Confirmar" attrs="{'invisible': [('state','!=','borrador')]}" class="btn-primary"/>
                </footer>
            </sheet>
        </form>
    </field>
</record>
```

## Ejemplo de test profesional
```python
from odoo.tests.common import TransactionCase, tagged

@tagged('modelo', 'workflow')
class TestMiModelo(TransactionCase):
    def setUp(self):
        super().setUp()
        self.modelo = self.env['mi.modelo'].create({'name': 'Test', 'descripcion': 'Prueba'})

    def test_creacion(self):
        self.assertEqual(self.modelo.name, 'Test')

    def test_workflow(self):
        self.modelo.action_confirmar()
        self.assertEqual(self.modelo.state, 'confirmado')
```
    fecha_creacion = fields.Datetime(
        string='Fecha de Creación',
        default=fields.Datetime.now,
        readonly=True
    )
    
    activo = fields.Boolean(
        string='Activo',
        default=True
    )
    
    @api.model
    def create(self, vals):
        # Lógica personalizada al crear
        return super().create(vals)
```

## 📋 Paso 6: Permisos de acceso

```csv
# addons_custom/mi_primer_modulo/security/ir.model.access.csv
id,name,model_id:id,group_id:id,perm_read,perm_write,perm_create,perm_unlink
access_mi_modelo,access_mi_modelo,model_mi_modelo,base.group_user,1,1,1,1
```

## 📋 Paso 7: Vista del modelo

```xml
<!-- addons_custom/mi_primer_modulo/views/mi_modelo_views.xml -->
<?xml version="1.0" encoding="utf-8"?>
<odoo>
    <!-- Vista Lista -->
    <record id="mi_modelo_tree_view" model="ir.ui.view">
        <field name="name">mi.modelo.tree</field>
        <field name="model">mi.modelo</field>
        <field name="arch" type="xml">
            <tree>
                <field name="nombre"/>
                <field name="descripcion"/>
                <field name="fecha_creacion"/>
                <field name="activo"/>
            </tree>
        </field>
    </record>

    <!-- Vista Formulario -->
    <record id="mi_modelo_form_view" model="ir.ui.view">
        <field name="name">mi.modelo.form</field>
        <field name="model">mi.modelo</field>
        <field name="arch" type="xml">
            <form>
                <sheet>
                    <group>
                        <field name="nombre"/>
                        <field name="activo"/>
                    </group>
                    <group>
                        <field name="descripcion"/>
                        <field name="fecha_creacion"/>
                    </group>
                </sheet>
            </form>
        </field>
    </record>

    <!-- Acción de Ventana -->
    <record id="mi_modelo_action" model="ir.actions.act_window">
        <field name="name">Mi Modelo</field>
        <field name="res_model">mi.modelo</field>
        <field name="view_mode">tree,form</field>
        <field name="help" type="html">
            <p class="o_view_nocontent_smiling_face">
                ¡Crea tu primer registro!
            </p>
        </field>
    </record>
</odoo>
```

## 📋 Paso 8: Menú

```xml
<!-- addons_custom/mi_primer_modulo/views/mi_menu.xml -->
<?xml version="1.0" encoding="utf-8"?>
<odoo>
    <!-- Menú Principal -->
    <menuitem id="mi_modulo_menu_root" 
              name="Mi Primer Módulo" 
              sequence="100"/>
    
    <!-- Submenú -->
    <menuitem id="mi_modelo_menu" 
              name="Mi Modelo"
              parent="mi_modulo_menu_root"
              action="mi_modelo_action"
              sequence="10"/>
</odoo>
```

## 🚀 Paso 9: Instalar el módulo

```bash
# Instalar el módulo
./scripts/start.sh -db dev -i mi_primer_modulo

# O en modo desarrollo
./scripts/start.sh -d -db dev -i mi_primer_modulo
```

## ✅ ¡Listo!

Ya tienes tu primer módulo funcionando. Deberías ver:
1. **Nueva aplicación** en el menú principal de Odoo
2. **Modelo funcional** con operaciones CRUD
3. **Vistas personalizadas** para lista y formulario

¡Felicidades por tu primer módulo Odoo! 🎉
