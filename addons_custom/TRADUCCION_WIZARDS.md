# Archivos de Traducción y Otros Componentes

## 8. i18n/ - Archivos de Traducción

### i18n/es.po - Traducción al Español

```po
# Translation of Odoo Server.
# This file contains the translation of the following modules:
#	* mi_modulo
#
msgid ""
msgstr ""
"Project-Id-Version: Odoo Server 18.0\n"
"Report-Msgid-Bugs-To: \n"
"POT-Creation-Date: 2024-01-01 12:00+0000\n"
"PO-Revision-Date: 2024-01-01 12:00+0000\n"
"Last-Translator: \n"
"Language-Team: \n"
"MIME-Version: 1.0\n"
"Content-Type: text/plain; charset=UTF-8\n"
"Content-Transfer-Encoding: \n"
"Plural-Forms: \n"

#. module: mi_modulo
#: model:ir.model.fields,field_description:mi_modulo.field_mi_modelo_principal__name
msgid "Nombre"
msgstr "Nombre"

#. module: mi_modulo
#: model:ir.model.fields,field_description:mi_modulo.field_mi_modelo_principal__description
msgid "Descripción"
msgstr "Descripción"

#. module: mi_modulo
#: model:ir.model.fields,field_description:mi_modulo.field_mi_modelo_principal__state
msgid "Estado"
msgstr "Estado"

#. module: mi_modulo
#: model:ir.model.fields,help:mi_modulo.field_mi_modelo_principal__name
msgid "Nombre identificativo del registro"
msgstr "Nombre identificativo del registro"

#. module: mi_modulo
#: selection:mi.modelo.principal,state:0
msgid "Borrador"
msgstr "Borrador"

#. module: mi_modulo
#: selection:mi.modelo.principal,state:0
msgid "Confirmado"
msgstr "Confirmado"

#. module: mi_modulo
#: selection:mi.modelo.principal,state:0
msgid "Completado"
msgstr "Completado"

#. module: mi_modulo
#: selection:mi.modelo.principal,state:0
msgid "Cancelado"
msgstr "Cancelado"

#. module: mi_modulo
#: code:addons/mi_modulo/models/mi_modelo.py:0
#, python-format
msgid "La fecha límite no puede ser anterior a hoy"
msgstr "La fecha límite no puede ser anterior a hoy"

#. module: mi_modulo
#: code:addons/mi_modulo/models/mi_modelo.py:0
#, python-format
msgid "Solo se pueden confirmar registros en borrador"
msgstr "Solo se pueden confirmar registros en borrador"

#. module: mi_modulo
#: model:ir.ui.menu,name:mi_modulo.mi_modulo_menu_root
msgid "Mi Módulo"
msgstr "Mi Módulo"

#. module: mi_modulo
#: model:ir.actions.act_window,name:mi_modulo.mi_modelo_action
msgid "Mi Modelo Principal"
msgstr "Mi Modelo Principal"
```

### i18n/en.po - Traducción al Inglés

```po
# Translation of Odoo Server.
# This file contains the translation of the following modules:
#	* mi_modulo
#
msgid ""
msgstr ""
"Project-Id-Version: Odoo Server 18.0\n"
"Report-Msgid-Bugs-To: \n"
"POT-Creation-Date: 2024-01-01 12:00+0000\n"
"PO-Revision-Date: 2024-01-01 12:00+0000\n"
"Last-Translator: \n"
"Language-Team: \n"
"Language: en\n"
"MIME-Version: 1.0\n"
"Content-Type: text/plain; charset=UTF-8\n"
"Content-Transfer-Encoding: \n"
"Plural-Forms: \n"

#. module: mi_modulo
#: model:ir.model.fields,field_description:mi_modulo.field_mi_modelo_principal__name
msgid "Nombre"
msgstr "Name"

#. module: mi_modulo
#: model:ir.model.fields,field_description:mi_modulo.field_mi_modelo_principal__description
msgid "Descripción"
msgstr "Description"

#. module: mi_modulo
#: model:ir.model.fields,field_description:mi_modulo.field_mi_modelo_principal__state
msgid "Estado"
msgstr "State"

#. module: mi_modulo
#: model:ir.model.fields,help:mi_modulo.field_mi_modelo_principal__name
msgid "Nombre identificativo del registro"
msgstr "Identifying name of the record"

#. module: mi_modulo
#: selection:mi.modelo.principal,state:0
msgid "Borrador"
msgstr "Draft"

#. module: mi_modulo
#: selection:mi.modelo.principal,state:0
msgid "Confirmado"
msgstr "Confirmed"

#. module: mi_modulo
#: selection:mi.modelo.principal,state:0
msgid "Completado"
msgstr "Done"

#. module: mi_modulo
#: selection:mi.modelo.principal,state:0
msgid "Cancelado"
msgstr "Cancelled"

#. module: mi_modulo
#: code:addons/mi_modulo/models/mi_modelo.py:0
#, python-format
msgid "La fecha límite no puede ser anterior a hoy"
msgstr "The deadline cannot be before today"

#. module: mi_modulo
#: code:addons/mi_modulo/models/mi_modelo.py:0
#, python-format
msgid "Solo se pueden confirmar registros en borrador"
msgstr "Only draft records can be confirmed"

#. module: mi_modulo
#: model:ir.ui.menu,name:mi_modulo.mi_modulo_menu_root
msgid "Mi Módulo"
msgstr "My Module"

#. module: mi_modulo
#: model:ir.actions.act_window,name:mi_modulo.mi_modelo_action
msgid "Mi Modelo Principal"
msgstr "My Main Model"
```

## 9. wizard/ - Asistentes/Wizards

### wizard/__init__.py

```python
# -*- coding: utf-8 -*-
from . import mi_wizard
```

### wizard/mi_wizard.py - Wizard Python

```python
# -*- coding: utf-8 -*-
from odoo import models, fields, api, _
from odoo.exceptions import UserError


class MiWizard(models.TransientModel):
    _name = 'mi.wizard'
    _description = 'Mi Asistente de Procesamiento'

    # Campos del wizard
    action_type = fields.Selection([
        ('confirm', 'Confirmar Registros'),
        ('cancel', 'Cancelar Registros'),
        ('update_partner', 'Actualizar Cliente'),
        ('generate_report', 'Generar Reporte'),
    ], string='Acción a Realizar', required=True, default='confirm')
    
    partner_id = fields.Many2one(
        'res.partner',
        string='Nuevo Cliente',
        help='Cliente para actualización masiva'
    )
    
    date_from = fields.Date(
        string='Fecha Desde',
        help='Fecha inicial para filtros'
    )
    
    date_to = fields.Date(
        string='Fecha Hasta',
        help='Fecha final para filtros'
    )
    
    notes = fields.Text(
        string='Notas',
        help='Comentarios adicionales para la acción'
    )
    
    record_ids = fields.Many2many(
        'mi.modelo.principal',
        string='Registros Seleccionados',
        help='Registros sobre los que se aplicará la acción'
    )
    
    record_count = fields.Integer(
        string='Número de Registros',
        compute='_compute_record_count'
    )

    @api.depends('record_ids')
    def _compute_record_count(self):
        for wizard in self:
            wizard.record_count = len(wizard.record_ids)

    @api.model
    def default_get(self, fields_list):
        """Valores por defecto del wizard"""
        res = super().default_get(fields_list)
        
        # Obtener registros seleccionados del contexto
        active_ids = self.env.context.get('active_ids', [])
        if active_ids and 'record_ids' in fields_list:
            res['record_ids'] = [(6, 0, active_ids)]
        
        return res

    def action_confirm(self):
        """Ejecutar acción principal del wizard"""
        self.ensure_one()
        
        if not self.record_ids:
            raise UserError(_('Debe seleccionar al menos un registro'))
        
        if self.action_type == 'confirm':
            return self._action_confirm_records()
        elif self.action_type == 'cancel':
            return self._action_cancel_records()
        elif self.action_type == 'update_partner':
            return self._action_update_partner()
        elif self.action_type == 'generate_report':
            return self._action_generate_report()
    
    def _action_confirm_records(self):
        """Confirmar registros seleccionados"""
        confirmed_count = 0
        errors = []
        
        for record in self.record_ids:
            try:
                if record.state == 'draft':
                    record.action_confirm()
                    confirmed_count += 1
                    
                    # Agregar nota si se proporcionó
                    if self.notes:
                        record.message_post(
                            body=_('Confirmado masivamente: %s') % self.notes,
                            message_type='comment'
                        )
                else:
                    errors.append(_('Registro %s no está en borrador') % record.name)
            except Exception as e:
                errors.append(_('Error en %s: %s') % (record.name, str(e)))
        
        # Mostrar resultado
        message = _('Se confirmaron %d registros exitosamente.') % confirmed_count
        if errors:
            message += '\n' + _('Errores encontrados:') + '\n' + '\n'.join(errors)
        
        return self._show_result_message(message, 'success' if not errors else 'warning')
    
    def _action_cancel_records(self):
        """Cancelar registros seleccionados"""
        cancelled_count = 0
        
        for record in self.record_ids.filtered(lambda r: r.state != 'cancelled'):
            record.action_cancel()
            cancelled_count += 1
            
            if self.notes:
                record.message_post(
                    body=_('Cancelado masivamente: %s') % self.notes,
                    message_type='comment'
                )
        
        message = _('Se cancelaron %d registros exitosamente.') % cancelled_count
        return self._show_result_message(message, 'success')
    
    def _action_update_partner(self):
        """Actualizar cliente en registros seleccionados"""
        if not self.partner_id:
            raise UserError(_('Debe seleccionar un cliente'))
        
        updated_count = 0
        for record in self.record_ids:
            old_partner = record.partner_id.name
            record.partner_id = self.partner_id
            updated_count += 1
            
            record.message_post(
                body=_('Cliente cambiado de %s a %s') % (old_partner, self.partner_id.name),
                message_type='comment'
            )
        
        message = _('Se actualizó el cliente en %d registros.') % updated_count
        return self._show_result_message(message, 'success')
    
    def _action_generate_report(self):
        """Generar reporte de registros seleccionados"""
        # Crear reporte PDF
        return self.env.ref('mi_modulo.action_report_mi_modelo').report_action(self.record_ids)
    
    def _show_result_message(self, message, msg_type='info'):
        """Mostrar mensaje de resultado"""
        return {
            'type': 'ir.actions.client',
            'tag': 'display_notification',
            'params': {
                'title': _('Resultado de la Operación'),
                'message': message,
                'type': msg_type,
                'sticky': True,
            }
        }


class MiWizardMasivo(models.TransientModel):
    _name = 'mi.wizard.masivo'
    _description = 'Procesamiento Masivo Avanzado'

    # Configuración de filtros
    filter_by_state = fields.Boolean('Filtrar por Estado', default=True)
    state_filter = fields.Selection([
        ('draft', 'Borrador'),
        ('confirmed', 'Confirmado'),
    ], string='Estado a Filtrar')
    
    filter_by_date = fields.Boolean('Filtrar por Fecha')
    date_from = fields.Date('Fecha Desde')
    date_to = fields.Date('Fecha Hasta')
    
    filter_by_partner = fields.Boolean('Filtrar por Cliente')
    partner_ids = fields.Many2many('res.partner', string='Clientes')
    
    # Acción a ejecutar
    mass_action = fields.Selection([
        ('delete', 'Eliminar'),
        ('archive', 'Archivar'),
        ('export', 'Exportar'),
    ], string='Acción Masiva', required=True)
    
    def action_execute(self):
        """Ejecutar procesamiento masivo"""
        domain = self._build_domain()
        records = self.env['mi.modelo.principal'].search(domain)
        
        if not records:
            raise UserError(_('No se encontraron registros con los filtros especificados'))
        
        if self.mass_action == 'delete':
            return self._mass_delete(records)
        elif self.mass_action == 'archive':
            return self._mass_archive(records)
        elif self.mass_action == 'export':
            return self._mass_export(records)
    
    def _build_domain(self):
        """Construir dominio de búsqueda"""
        domain = []
        
        if self.filter_by_state and self.state_filter:
            domain.append(('state', '=', self.state_filter))
        
        if self.filter_by_date:
            if self.date_from:
                domain.append(('date_created', '>=', self.date_from))
            if self.date_to:
                domain.append(('date_created', '<=', self.date_to))
        
        if self.filter_by_partner and self.partner_ids:
            domain.append(('partner_id', 'in', self.partner_ids.ids))
        
        return domain
    
    def _mass_delete(self, records):
        """Eliminación masiva"""
        count = len(records)
        records.unlink()
        
        return {
            'type': 'ir.actions.client',
            'tag': 'display_notification',
            'params': {
                'title': _('Eliminación Completada'),
                'message': _('Se eliminaron %d registros exitosamente.') % count,
                'type': 'success',
            }
        }
    
    def _mass_archive(self, records):
        """Archivado masivo"""
        count = len(records)
        records.write({'active': False})
        
        return {
            'type': 'ir.actions.client',
            'tag': 'display_notification',
            'params': {
                'title': _('Archivado Completado'),
                'message': _('Se archivaron %d registros exitosamente.') % count,
                'type': 'success',
            }
        }
    
    def _mass_export(self, records):
        """Exportación masiva"""
        # Generar archivo Excel/CSV
        return {
            'type': 'ir.actions.act_url',
            'url': f'/web/export/xlsx?model=mi.modelo.principal&ids={",".join(map(str, records.ids))}',
            'target': 'new',
        }
```

### wizard/mi_wizard_views.xml - Vistas del Wizard

```xml
<?xml version="1.0" encoding="utf-8"?>
<odoo>
    <!-- Vista Formulario del Wizard Principal -->
    <record id="mi_wizard_form_view" model="ir.ui.view">
        <field name="name">mi.wizard.form</field>
        <field name="model">mi.wizard</field>
        <field name="arch" type="xml">
            <form>
                <sheet>
                    <div class="oe_title">
                        <h1>Procesamiento Masivo de Registros</h1>
                        <p>Seleccione la acción a realizar sobre los registros seleccionados</p>
                    </div>
                    
                    <group>
                        <group>
                            <field name="action_type" widget="radio"/>
                            <field name="record_count" readonly="1"/>
                        </group>
                        <group>
                            <field name="partner_id" 
                                   invisible="action_type != 'update_partner'"
                                   required="action_type == 'update_partner'"/>
                            <field name="date_from" 
                                   invisible="action_type != 'generate_report'"/>
                            <field name="date_to" 
                                   invisible="action_type != 'generate_report'"/>
                        </group>
                    </group>
                    
                    <notebook>
                        <page string="Registros Seleccionados" name="records">
                            <field name="record_ids" readonly="1">
                                <tree>
                                    <field name="name"/>
                                    <field name="code"/>
                                    <field name="partner_id"/>
                                    <field name="state" widget="badge"/>
                                    <field name="amount_total" widget="monetary"/>
                                </tree>
                            </field>
                        </page>
                        <page string="Notas" name="notes">
                            <field name="notes" placeholder="Comentarios adicionales sobre la acción..."/>
                        </page>
                    </notebook>
                </sheet>
                
                <footer>
                    <button name="action_confirm" 
                            type="object" 
                            string="Ejecutar Acción" 
                            class="btn-primary"/>
                    <button string="Cancelar" 
                            class="btn-secondary" 
                            special="cancel"/>
                </footer>
            </form>
        </field>
    </record>

    <!-- Vista del Wizard Masivo -->
    <record id="mi_wizard_masivo_form_view" model="ir.ui.view">
        <field name="name">mi.wizard.masivo.form</field>
        <field name="model">mi.wizard.masivo</field>
        <field name="arch" type="xml">
            <form>
                <sheet>
                    <div class="oe_title">
                        <h1>Procesamiento Masivo Avanzado</h1>
                        <p>Configure los filtros y la acción a ejecutar</p>
                    </div>
                    
                    <group string="Filtros de Selección">
                        <group>
                            <field name="filter_by_state"/>
                            <field name="state_filter" 
                                   invisible="not filter_by_state"
                                   required="filter_by_state"/>
                            
                            <field name="filter_by_date"/>
                            <field name="date_from" 
                                   invisible="not filter_by_date"/>
                            <field name="date_to" 
                                   invisible="not filter_by_date"/>
                        </group>
                        <group>
                            <field name="filter_by_partner"/>
                            <field name="partner_ids" 
                                   invisible="not filter_by_partner"
                                   widget="many2many_tags"/>
                        </group>
                    </group>
                    
                    <group string="Acción a Ejecutar">
                        <field name="mass_action" widget="radio"/>
                    </group>
                </sheet>
                
                <footer>
                    <button name="action_execute" 
                            type="object" 
                            string="Ejecutar Procesamiento" 
                            class="btn-primary"
                            confirm="¿Está seguro de que desea ejecutar esta acción masiva?"/>
                    <button string="Cancelar" 
                            class="btn-secondary" 
                            special="cancel"/>
                </footer>
            </form>
        </field>
    </record>

    <!-- Acciones del Wizard -->
    <record id="action_mi_wizard" model="ir.actions.act_window">
        <field name="name">Procesamiento Masivo</field>
        <field name="res_model">mi.wizard</field>
        <field name="view_mode">form</field>
        <field name="target">new</field>
        <field name="binding_model_id" ref="model_mi_modelo_principal"/>
        <field name="binding_view_types">list</field>
    </record>

    <record id="action_mi_wizard_masivo" model="ir.actions.act_window">
        <field name="name">Procesamiento Masivo Avanzado</field>
        <field name="res_model">mi.wizard.masivo</field>
        <field name="view_mode">form</field>
        <field name="target">new</field>
    </record>

    <!-- Menú del Wizard -->
    <menuitem id="mi_wizard_masivo_menu" 
              name="Procesamiento Masivo"
              parent="mi_modulo_config_menu"
              action="action_mi_wizard_masivo"
              sequence="10"/>
</odoo>
```

## 10. Comando para Generar Traducciones

```bash
# Generar archivo .pot (plantilla de traducción)
python3 odoo/odoo-bin -d mi_db --i18n-export=addons_custom/mi_modulo/i18n/template.pot -m mi_modulo --stop-after-init

# Actualizar traducciones existentes
python3 odoo/odoo-bin -d mi_db --i18n-overwrite --i18n-import=addons_custom/mi_modulo/i18n/es.po -l es_ES --stop-after-init
```

Esta documentación completa te proporciona todos los componentes necesarios para crear módulos profesionales en Odoo 18, incluyendo wizards avanzados, traducciones y manejo de datos precargados.
