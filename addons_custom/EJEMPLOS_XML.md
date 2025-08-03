# Ejemplos de Archivos XML y Configuración

## 5. views/ - Archivos XML para Formularios, Listas, Menús

### views/mi_modelo_views.xml - Vistas del Modelo

```xml
<?xml version="1.0" encoding="utf-8"?>
<odoo>
    <!-- Vista Lista/Tree -->
    <record id="mi_modelo_tree_view" model="ir.ui.view">
        <field name="name">mi.modelo.principal.tree</field>
        <field name="model">mi.modelo.principal</field>
        <field name="arch" type="xml">
            <tree decoration-success="state=='done'" 
                  decoration-warning="state in ('confirmed','approved')" 
                  decoration-muted="state=='cancelled'"
                  multi_edit="1">
                <field name="sequence" widget="handle"/>
                <field name="name"/>
                <field name="code"/>
                <field name="partner_id"/>
                <field name="user_id" widget="many2one_avatar_user"/>
                <field name="state" 
                       decoration-success="state=='done'"
                       decoration-warning="state in ('confirmed','approved')"
                       decoration-danger="state=='cancelled'"
                       widget="badge"/>
                <field name="amount_total" widget="monetary"/>
                <field name="currency_id" groups="base.group_multi_currency"/>
                <field name="date_created"/>
                <field name="activity_ids" widget="list_activity"/>
                <button name="action_confirm" 
                        type="object" 
                        string="Confirmar"
                        class="btn-primary"
                        invisible="state != 'draft'"
                        icon="fa-check"/>
            </tree>
        </field>
    </record>

    <!-- Vista Formulario -->
    <record id="mi_modelo_form_view" model="ir.ui.view">
        <field name="name">mi.modelo.principal.form</field>
        <field name="model">mi.modelo.principal</field>
        <field name="arch" type="xml">
            <form>
                <header>
                    <button name="action_confirm" 
                            type="object" 
                            string="Confirmar" 
                            class="btn-primary"
                            invisible="state != 'draft'"/>
                    <button name="action_approve" 
                            type="object" 
                            string="Aprobar"
                            class="btn-primary"
                            invisible="state != 'confirmed'"
                            groups="mi_modulo.group_manager"/>
                    <button name="action_done" 
                            type="object" 
                            string="Completar"
                            class="btn-success"
                            invisible="state != 'approved'"/>
                    <button name="action_cancel" 
                            type="object" 
                            string="Cancelar"
                            invisible="state in ('done', 'cancelled')"/>
                    <field name="state" widget="statusbar" 
                           statusbar_visible="draft,confirmed,approved,done"/>
                </header>
                
                <sheet>
                    <!-- Título dinámico -->
                    <div class="oe_title">
                        <label for="name" class="oe_edit_only"/>
                        <h1><field name="name" placeholder="Nombre del registro..."/></h1>
                        <label for="code" class="oe_edit_only"/>
                        <h2><field name="code" placeholder="Código automático..."/></h2>
                    </div>
                    
                    <group>
                        <group name="main_info">
                            <field name="partner_id" 
                                   options="{'no_create': True, 'no_open': True}"/>
                            <field name="user_id" widget="many2one_avatar_user"/>
                            <field name="date_deadline"/>
                            <field name="company_id" groups="base.group_multi_company"/>
                        </group>
                        <group name="amounts">
                            <field name="currency_id" groups="base.group_multi_currency"/>
                            <field name="amount"/>
                            <field name="amount_total" readonly="1"/>
                            <field name="line_count" readonly="1"/>
                        </group>
                    </group>
                    
                    <notebook>
                        <page string="Líneas" name="lines">
                            <field name="line_ids">
                                <tree editable="bottom">
                                    <field name="sequence" widget="handle"/>
                                    <field name="name"/>
                                    <field name="quantity"/>
                                    <field name="price_unit" widget="monetary"/>
                                    <field name="amount" widget="monetary" readonly="1"/>
                                    <field name="currency_id" column_invisible="1"/>
                                </tree>
                                <form>
                                    <group>
                                        <field name="name"/>
                                        <field name="quantity"/>
                                        <field name="price_unit"/>
                                        <field name="amount" readonly="1"/>
                                    </group>
                                </form>
                            </field>
                        </page>
                        
                        <page string="Información Adicional" name="additional">
                            <group>
                                <group>
                                    <field name="active"/>
                                    <field name="sequence"/>
                                </group>
                                <group>
                                    <field name="date_created"/>
                                    <field name="attachment" filename="attachment_name"/>
                                    <field name="attachment_name" readonly="1"/>
                                </group>
                            </group>
                            <field name="description"/>
                            <field name="notes"/>
                        </page>
                    </notebook>
                </sheet>
                
                <!-- Chatter (mensajes y actividades) -->
                <div class="oe_chatter">
                    <field name="message_follower_ids"/>
                    <field name="activity_ids"/>
                    <field name="message_ids"/>
                </div>
            </form>
        </field>
    </record>

    <!-- Vista Búsqueda/Filtros -->
    <record id="mi_modelo_search_view" model="ir.ui.view">
        <field name="name">mi.modelo.principal.search</field>
        <field name="model">mi.modelo.principal</field>
        <field name="arch" type="xml">
            <search>
                <!-- Campos de búsqueda -->
                <field name="name" string="Nombre/Código" 
                       filter_domain="['|', ('name', 'ilike', self), ('code', 'ilike', self)]"/>
                <field name="partner_id"/>
                <field name="user_id"/>
                
                <!-- Separador -->
                <separator/>
                
                <!-- Filtros predefinidos -->
                <filter name="my_records" 
                        string="Mis Registros"
                        domain="[('user_id', '=', uid)]"/>
                <filter name="active_records" 
                        string="Activos"
                        domain="[('active', '=', True)]"/>
                <filter name="draft_state" 
                        string="Borradores"
                        domain="[('state', '=', 'draft')]"/>
                <filter name="confirmed_state" 
                        string="Confirmados"
                        domain="[('state', '=', 'confirmed')]"/>
                
                <separator/>
                
                <!-- Filtros de fecha -->
                <filter name="today" 
                        string="Creados Hoy"
                        domain="[('date_created', '>=', datetime.datetime.combine(context_today(), datetime.time(0,0,0)))]"/>
                <filter name="this_week" 
                        string="Esta Semana"
                        domain="[('date_created', '>=', (context_today() - datetime.timedelta(days=context_today().weekday())))]"/>
                <filter name="this_month" 
                        string="Este Mes"
                        domain="[('date_created', '>=', (context_today().replace(day=1)))]"/>
                
                <!-- Agrupaciones -->
                <group expand="0" string="Agrupar Por">
                    <filter name="group_state" 
                            string="Estado" 
                            context="{'group_by': 'state'}"/>
                    <filter name="group_partner" 
                            string="Cliente/Proveedor" 
                            context="{'group_by': 'partner_id'}"/>
                    <filter name="group_user" 
                            string="Responsable" 
                            context="{'group_by': 'user_id'}"/>
                    <filter name="group_date" 
                            string="Fecha de Creación" 
                            context="{'group_by': 'date_created:month'}"/>
                </group>
            </search>
        </field>
    </record>

    <!-- Vista Kanban -->
    <record id="mi_modelo_kanban_view" model="ir.ui.view">
        <field name="name">mi.modelo.principal.kanban</field>
        <field name="model">mi.modelo.principal</field>
        <field name="arch" type="xml">
            <kanban default_group_by="state" class="o_kanban_small_column">
                <field name="id"/>
                <field name="name"/>
                <field name="code"/>
                <field name="partner_id"/>
                <field name="user_id"/>
                <field name="state"/>
                <field name="amount_total"/>
                <field name="currency_id"/>
                <field name="activity_ids"/>
                <field name="activity_state"/>
                
                <templates>
                    <t t-name="kanban-box">
                        <div t-attf-class="oe_kanban_card oe_kanban_global_click">
                            <div class="o_kanban_record_top">
                                <div class="o_kanban_record_headings">
                                    <strong class="o_kanban_record_title">
                                        <field name="name"/>
                                    </strong>
                                    <small class="o_kanban_record_subtitle text-muted">
                                        <field name="code"/>
                                    </small>
                                </div>
                                <div class="o_kanban_manage_button_section">
                                    <a class="o_kanban_manage_toggle_button" href="#">
                                        <i class="fa fa-ellipsis-v" role="img" aria-label="Manage" title="Manage"/>
                                    </a>
                                </div>
                            </div>
                            
                            <div class="o_kanban_record_body">
                                <field name="partner_id"/>
                                <div class="o_kanban_record_bottom">
                                    <div class="oe_kanban_bottom_left">
                                        <field name="activity_ids" widget="kanban_activity"/>
                                    </div>
                                    <div class="oe_kanban_bottom_right">
                                        <field name="user_id" widget="many2one_avatar_user"/>
                                        <span class="o_kanban_record_bottom_right">
                                            <field name="amount_total" widget="monetary"/>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="o_kanban_manage_button_section" style="top: 5px;">
                                <a class="o_kanban_manage_toggle_button" href="#" tabindex="-1">
                                    <i class="fa fa-ellipsis-v" role="img" aria-label="Gestionar" title="Gestionar"/>
                                </a>
                            </div>
                        </div>
                    </t>
                </templates>
            </kanban>
        </field>
    </record>

    <!-- Vista Pivote para Análisis -->
    <record id="mi_modelo_pivot_view" model="ir.ui.view">
        <field name="name">mi.modelo.principal.pivot</field>
        <field name="model">mi.modelo.principal</field>
        <field name="arch" type="xml">
            <pivot>
                <field name="partner_id" type="row"/>
                <field name="state" type="col"/>
                <field name="amount_total" type="measure"/>
            </pivot>
        </field>
    </record>

    <!-- Vista Gráfico -->
    <record id="mi_modelo_graph_view" model="ir.ui.view">
        <field name="name">mi.modelo.principal.graph</field>
        <field name="model">mi.modelo.principal</field>
        <field name="arch" type="xml">
            <graph type="bar">
                <field name="state"/>
                <field name="amount_total" type="measure"/>
            </graph>
        </field>
    </record>
</odoo>
```

### views/mi_modelo_menus.xml - Menús y Acciones

```xml
<?xml version="1.0" encoding="utf-8"?>
<odoo>
    <!-- Acción Principal -->
    <record id="mi_modelo_action" model="ir.actions.act_window">
        <field name="name">Mi Modelo Principal</field>
        <field name="res_model">mi.modelo.principal</field>
        <field name="view_mode">kanban,tree,form,pivot,graph</field>
        <field name="search_view_id" ref="mi_modelo_search_view"/>
        <field name="context">{
            'search_default_my_records': 1,
            'search_default_active_records': 1
        }</field>
        <field name="help" type="html">
            <p class="o_view_nocontent_smiling_face">
                ¡Crea tu primer registro!
            </p>
            <p>
                Gestiona todos tus registros desde aquí.<br/>
                Puedes crear, editar y realizar seguimiento de todos los procesos.
            </p>
        </field>
    </record>

    <!-- Acción para Borradores -->
    <record id="mi_modelo_draft_action" model="ir.actions.act_window">
        <field name="name">Borradores</field>
        <field name="res_model">mi.modelo.principal</field>
        <field name="view_mode">tree,form</field>
        <field name="domain">[('state', '=', 'draft')]</field>
        <field name="context">{'default_state': 'draft'}</field>
    </record>

    <!-- Acción para Reportes -->
    <record id="mi_modelo_report_action" model="ir.actions.act_window">
        <field name="name">Análisis</field>
        <field name="res_model">mi.modelo.principal</field>
        <field name="view_mode">pivot,graph</field>
        <field name="context">{
            'search_default_group_state': 1,
            'search_default_this_month': 1
        }</field>
    </record>

    <!-- Menú Principal -->
    <menuitem id="mi_modulo_menu_root" 
              name="Mi Módulo" 
              sequence="100"
              web_icon="mi_modulo,static/description/icon.png"/>

    <!-- Submenús -->
    <menuitem id="mi_modelo_menu" 
              name="Registros"
              parent="mi_modulo_menu_root"
              action="mi_modelo_action"
              sequence="10"/>

    <menuitem id="mi_modelo_draft_menu" 
              name="Borradores"
              parent="mi_modulo_menu_root"
              action="mi_modelo_draft_action"
              sequence="20"/>

    <!-- Menú de Configuración -->
    <menuitem id="mi_modulo_config_menu" 
              name="Configuración"
              parent="mi_modulo_menu_root"
              sequence="90"/>

    <!-- Menú de Reportes -->
    <menuitem id="mi_modulo_reports_menu" 
              name="Reportes"
              parent="mi_modulo_menu_root"
              sequence="80"/>

    <menuitem id="mi_modelo_report_menu" 
              name="Análisis de Registros"
              parent="mi_modulo_reports_menu"
              action="mi_modelo_report_action"
              sequence="10"/>
</odoo>
```

## 6. security/ - Archivos de Seguridad

### security/security.xml - Grupos de Seguridad

```xml
<?xml version="1.0" encoding="utf-8"?>
<odoo>
    <!-- Categoría de Módulo -->
    <record id="module_category_mi_modulo" model="ir.module.category">
        <field name="name">Mi Módulo</field>
        <field name="description">Permisos para Mi Módulo</field>
        <field name="sequence">20</field>
    </record>

    <!-- Grupo Usuario -->
    <record id="group_user" model="res.groups">
        <field name="name">Usuario</field>
        <field name="category_id" ref="module_category_mi_modulo"/>
        <field name="implied_ids" eval="[(4, ref('base.group_user'))]"/>
        <field name="comment">Acceso básico de usuario al módulo</field>
    </record>

    <!-- Grupo Manager -->
    <record id="group_manager" model="res.groups">
        <field name="name">Manager</field>
        <field name="category_id" ref="module_category_mi_modulo"/>
        <field name="implied_ids" eval="[(4, ref('group_user'))]"/>
        <field name="comment">Acceso completo de gestión del módulo</field>
    </record>

    <!-- Reglas de Registro (Record Rules) -->
    
    <!-- Regla: Los usuarios solo ven sus propios registros -->
    <record id="rule_mi_modelo_user_own" model="ir.rule">
        <field name="name">Usuario ve solo sus registros</field>
        <field name="model_id" ref="model_mi_modelo_principal"/>
        <field name="domain_force">[('user_id', '=', user.id)]</field>
        <field name="groups" eval="[(4, ref('group_user'))]"/>
        <field name="perm_read" eval="True"/>
        <field name="perm_write" eval="True"/>
        <field name="perm_create" eval="True"/>
        <field name="perm_unlink" eval="False"/>
    </record>

    <!-- Regla: Los managers ven todos los registros -->
    <record id="rule_mi_modelo_manager_all" model="ir.rule">
        <field name="name">Manager ve todos los registros</field>
        <field name="model_id" ref="model_mi_modelo_principal"/>
        <field name="domain_force">[(1, '=', 1)]</field>
        <field name="groups" eval="[(4, ref('group_manager'))]"/>
        <field name="perm_read" eval="True"/>
        <field name="perm_write" eval="True"/>
        <field name="perm_create" eval="True"/>
        <field name="perm_unlink" eval="True"/>
    </record>

    <!-- Regla: Solo misma compañía -->
    <record id="rule_mi_modelo_company" model="ir.rule">
        <field name="name">Registros de la misma compañía</field>
        <field name="model_id" ref="model_mi_modelo_principal"/>
        <field name="domain_force">[('company_id', 'in', company_ids)]</field>
        <field name="global" eval="True"/>
    </record>
</odoo>
```

### security/ir.model.access.csv - Permisos de Modelo

```csv
id,name,model_id:id,group_id:id,perm_read,perm_write,perm_create,perm_unlink
access_mi_modelo_user,mi_modelo_user,model_mi_modelo_principal,group_user,1,1,1,0
access_mi_modelo_manager,mi_modelo_manager,model_mi_modelo_principal,group_manager,1,1,1,1
access_mi_modelo_linea_user,mi_modelo_linea_user,model_mi_modelo_linea,group_user,1,1,1,1
access_mi_modelo_linea_manager,mi_modelo_linea_manager,model_mi_modelo_linea,group_manager,1,1,1,1
access_mi_modelo_public,mi_modelo_public,model_mi_modelo_principal,,1,0,0,0
```

## 7. data/ - Datos Precargados

### data/sequences.xml - Secuencias Numéricas

```xml
<?xml version="1.0" encoding="utf-8"?>
<odoo>
    <!-- Secuencia para códigos automáticos -->
    <record id="seq_mi_modelo_principal" model="ir.sequence">
        <field name="name">Mi Modelo Principal</field>
        <field name="code">mi.modelo.principal</field>
        <field name="prefix">MM</field>
        <field name="suffix">%(year)s</field>
        <field name="padding">4</field>
        <field name="number_next">1</field>
        <field name="number_increment">1</field>
        <field name="company_id" eval="False"/>
    </record>
</odoo>
```

### data/data.xml - Datos Base

```xml
<?xml version="1.0" encoding="utf-8"?>
<odoo>
    <!-- Parámetros del Sistema -->
    <record id="config_param_auto_confirm" model="ir.config_parameter">
        <field name="key">mi_modulo.auto_confirm</field>
        <field name="value">False</field>
    </record>

    <record id="config_param_default_sequence" model="ir.config_parameter">
        <field name="key">mi_modulo.default_sequence</field>
        <field name="value">10</field>
    </record>

    <!-- Datos de ejemplo (opcional) -->
    <record id="demo_partner_1" model="res.partner">
        <field name="name">Cliente Demo 1</field>
        <field name="is_company">True</field>
        <field name="email">demo1@ejemplo.com</field>
    </record>

    <record id="demo_record_1" model="mi.modelo.principal">
        <field name="name">Registro Demo 1</field>
        <field name="code">DEMO001</field>
        <field name="partner_id" ref="demo_partner_1"/>
        <field name="amount">1000.0</field>
        <field name="state">draft</field>
    </record>
</odoo>
```

### data/mail_templates.xml - Plantillas de Email

```xml
<?xml version="1.0" encoding="utf-8"?>
<odoo>
    <!-- Plantilla de Confirmación -->
    <record id="mail_template_confirmation" model="mail.template">
        <field name="name">Confirmación de Registro</field>
        <field name="model_id" ref="model_mi_modelo_principal"/>
        <field name="subject">Confirmación de {{ object.name }}</field>
        <field name="email_from">{{ (object.company_id.email or user.email) }}</field>
        <field name="email_to">{{ object.partner_id.email }}</field>
        <field name="body_html" type="html">
<div style="margin: 0px; padding: 0px;">
    <p>Estimado {{ object.partner_id.name }},</p>
    <p>Le confirmamos que su registro <strong>{{ object.name }}</strong> 
       (código: {{ object.code }}) ha sido confirmado exitosamente.</p>
    
    <h3>Detalles del Registro:</h3>
    <ul>
        <li><strong>Nombre:</strong> {{ object.name }}</li>
        <li><strong>Código:</strong> {{ object.code }}</li>
        <li><strong>Responsable:</strong> {{ object.user_id.name }}</li>
        <li><strong>Importe Total:</strong> {{ format_amount(object.amount_total, object.currency_id) }}</li>
        <li><strong>Estado:</strong> {{ dict(object._fields['state'].selection)[object.state] }}</li>
    </ul>
    
    <p>Si tiene alguna consulta, no dude en contactarnos.</p>
    
    <p>Saludos cordiales,<br/>
    {{ object.company_id.name }}</p>
</div>
        </field>
    </record>

    <!-- Plantilla de Recordatorio -->
    <record id="mail_template_reminder" model="mail.template">
        <field name="name">Recordatorio de Fecha Límite</field>
        <field name="model_id" ref="model_mi_modelo_principal"/>
        <field name="subject">Recordatorio: {{ object.name }} - Fecha límite próxima</field>
        <field name="email_to">{{ object.user_id.email }}</field>
        <field name="body_html" type="html">
<div style="margin: 0px; padding: 0px;">
    <p>Hola {{ object.user_id.name }},</p>
    <p>Te recordamos que el registro <strong>{{ object.name }}</strong> 
       tiene fecha límite el {{ format_date(object.date_deadline) }}.</p>
    
    <p>Por favor, revisa y toma las acciones necesarias.</p>
    
    <p>
        <a href="/web#id={{ object.id }}&amp;model=mi.modelo.principal&amp;view_type=form" 
           style="background-color: #875A7B; padding: 8px 16px; text-decoration: none; color: #fff; border-radius: 5px;">
            Ver Registro
        </a>
    </p>
</div>
        </field>
    </record>
</odoo>
```

Esta estructura completa te proporciona todos los componentes necesarios para un módulo profesional en Odoo 18. ¿Te gustaría que continue con los archivos de traducción (i18n), wizards, reportes o algún componente específico?
