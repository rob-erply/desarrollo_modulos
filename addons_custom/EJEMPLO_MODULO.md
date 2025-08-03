# Ejemplo: Crear un Módulo Simple

Este es un ejemplo paso a paso para crear tu primer módulo personalizado en Odoo 18.

## 📋 Paso 1: Crear la estructura

```bash
# Crear directorio del módulo
mkdir -p addons_custom/mi_primer_modulo

# Crear estructura básica
mkdir -p addons_custom/mi_primer_modulo/models
mkdir -p addons_custom/mi_primer_modulo/views
mkdir -p addons_custom/mi_primer_modulo/security
mkdir -p addons_custom/mi_primer_modulo/static/description
```

## 📋 Paso 2: __init__.py principal

```python
# addons_custom/mi_primer_modulo/__init__.py
from . import models
```

## 📋 Paso 3: __manifest__.py

```python
# addons_custom/mi_primer_modulo/__manifest__.py
{
    'name': 'Mi Primer Módulo',
    'version': '18.0.1.0.0',
    'category': 'Extra Tools',
    'summary': 'Ejemplo de módulo básico para aprender',
    'description': '''
        Este es mi primer módulo en Odoo 18:
        - Modelo simple de ejemplo
        - Vista básica
        - Menú en la aplicación
    ''',
    'author': 'Mi Nombre',
    'website': 'https://mi-sitio.com',
    'depends': ['base'],
    'data': [
        'security/ir.model.access.csv',
        'views/mi_modelo_views.xml',
        'views/mi_menu.xml',
    ],
    'installable': True,
    'auto_install': False,
    'application': True,  # True si quieres que aparezca como app principal
    'license': 'LGPL-3',
}
```

## 📋 Paso 4: Modelo (models/__init__.py)

```python
# addons_custom/mi_primer_modulo/models/__init__.py
from . import mi_modelo
```

## 📋 Paso 5: Modelo principal

```python
# addons_custom/mi_primer_modulo/models/mi_modelo.py
from odoo import models, fields, api

class MiModelo(models.Model):
    _name = 'mi.modelo'
    _description = 'Mi Modelo de Ejemplo'
    _rec_name = 'nombre'

    nombre = fields.Char(
        string='Nombre', 
        required=True,
        help='Nombre descriptivo del registro'
    )
    
    descripcion = fields.Text(
        string='Descripción',
        help='Descripción detallada'
    )
    
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
