# __manifest__.py - El Corazón del Módulo Odoo

El archivo `__manifest__.py` (anteriormente `__openerp__.py`) es el **corazón técnico del módulo**. Define su estructura, comportamiento, dependencias y compatibilidad con versiones. Para que un módulo sea aceptado en el marketplace y se mantenga correctamente a largo plazo, debe contener un manifest limpio, completo y estandarizado.

## 📑 Campos Clave del Manifest

### Campos Obligatorios

| Campo | Obligatorio | Descripción |
|-------|-------------|-------------|
| `name` | ✅ | Nombre visible del módulo |
| `summary` | ✅ | Descripción corta (1 línea) |
| `version` | ✅ | En formato semántico, indica compatibilidad |
| `license` | ✅ | Licencia: AGPL-3, LGPL-3, OPL |
| `author` | ✅ | Empresa o desarrollador responsable |
| `website` | ✅ | URL del proveedor o documento técnico |
| `category` | ✅ | Categoría funcional (Accounting, Sales...) |
| `depends` | ✅ | Módulos requeridos (visibles o no) |
| `data` | ✅ | Archivos cargados al instalar el módulo |

### Campos Opcionales Importantes

| Campo | Descripción |
|-------|-------------|
| `application` | Define si se trata de una app completa (True) |
| `auto_install` | Si se instala solo si sus dependencias lo están |
| `installable` | Si el módulo está disponible para instalación |
| `description` | Descripción extendida del módulo |
| `demo` | Archivos de datos de demostración |
| `external_dependencies` | Dependencias de Python o binarios |
| `icon` | Ruta al icono del módulo |
| `price` | Precio para módulos de pago |
| `currency` | Moneda del precio |

## 🔗 Dependencias Explícitas y Ocultas

Hay módulos que se deben declarar aunque no se usen directamente en models, como `web`, `mail`, `digest`, `base_setup`, etc., ya que muchos servicios internos dependen de ellos.

### Dependencias Comunes

```python
'depends': [
    'base',           # Siempre requerido
    'web',            # Para funcionalidad web básica
    'mail',           # Para chatter y notificaciones
    'account',        # Para funcionalidad contable
    'sale',           # Para ventas
    'purchase',       # Para compras
    'stock',          # Para inventario
    'hr',             # Para recursos humanos
    'project',        # Para gestión de proyectos
]
```

### ⚠️ Tip Importante
Siempre revise el manifest de los módulos que está heredando o usando vía `@api.model`.

## 🧮 Versionado Semántico

El formato oficial para Odoo Apps es:

```
<odoo_major_version>.<release>.<minor>.<patch>.<hotfix>
```

### Ejemplo: `18.0.1.0.0`

- **18.0**: versión de Odoo
- **1**: primer release estable
- **0**: sin cambios funcionales nuevos
- **0**: sin correcciones menores
- **0**: sin hotfix urgentes

### Reglas de Versionado

| Incremento | Cuándo Usar |
|------------|-------------|
| **hotfix** | Correcciones críticas de seguridad |
| **patch** | Correcciones de bugs menores |
| **minor** | Nuevas funcionalidades sin romper compatibilidad |
| **release** | Cambios mayores, posibles incompatibilidades |
| **odoo_version** | Solo cuando se migra a nueva versión de Odoo |

Esto permite mantener múltiples versiones del mismo módulo en diferentes ramas o repositorios (v15, v16, v17, v18).

## 📄 Plantilla Profesional Comentada

```python
# -*- coding: utf-8 -*-
{
    # === INFORMACIÓN BÁSICA ===
    'name': 'ERPly – Firma Electrónica DGII',
    'summary': 'Firma XML y envío de comprobantes fiscales electrónicos conforme a DGII',
    'description': """
        Este módulo permite firmar electrónicamente facturas y comprobantes fiscales (e-CF)
        según las normativas de la DGII en República Dominicana.
        
        Características principales:
        • Firma digital de documentos XML
        • Validación de códigos QR
        • Generación de códigos de seguridad
        • Gestión de TrackId para seguimiento
        • Integración completa con facturación
        
        Cumple con:
        • Norma General 06-2018 DGII
        • Resolución 09-2019 sobre e-CF
        • Estándares de seguridad fiscal
    """,
    
    # === VERSIONADO Y LICENCIA ===
    'version': '18.0.1.0.0',  # Odoo 18, release 1, estable
    'license': 'AGPL-3',      # Compatible con Odoo Apps Store y desarrollo comunitario
    
    # === INFORMACIÓN DEL AUTOR ===
    'author': 'ERPly',
    'maintainer': 'ERPly Development Team',
    'website': 'https://www.erply.do',
    'support': 'soporte@erply.do',
    
    # === CATEGORIZACIÓN ===
    'category': 'Accounting/Localization',
    'tags': ['accounting', 'dominican republic', 'dgii', 'electronic invoice'],
    
    # === DEPENDENCIAS ===
    'depends': [
        'base',           # Funcionalidades básicas de Odoo
        'account',        # Módulo de contabilidad
        'web',            # Interfaz web y funcionalidades AJAX
        'mail',           # Sistema de mensajería y chatter
        'digest',         # Para evitar warnings en logs
    ],
    
    # === ARCHIVOS DE DATOS ===
    'data': [
        # Seguridad
        'security/ir.model.access.csv',
        'security/security.xml',
        
        # Datos maestros
        'data/sequence.xml',
        'data/mail_template.xml',
        'data/cron_jobs.xml',
        
        # Vistas
        'views/account_move_view.xml',
        'views/res_config_settings_view.xml',
        'views/dgii_certificate_view.xml',
        
        # Menús
        'views/menu.xml',
        
        # Reportes
        'reports/invoice_report.xml',
        'reports/templates.xml',
        
        # Wizards
        'wizards/mass_sign_wizard.xml',
    ],
    
    # === DATOS DE DEMOSTRACIÓN ===
    'demo': [
        'demo/demo_certificates.xml',
        'demo/demo_invoices.xml',
    ],
    
    # === DEPENDENCIAS EXTERNAS ===
    'external_dependencies': {
        'python': [
            'cryptography',    # Para firma digital
            'lxml',           # Para procesamiento XML
            'requests',       # Para comunicación HTTP
            'qrcode',         # Para generación de códigos QR
            'pillow',         # Para procesamiento de imágenes
        ],
        'bin': [
            # 'wkhtmltopdf',  # Solo si necesita PDF específico
        ],
    },
    
    # === CONFIGURACIÓN DEL MÓDULO ===
    'application': False,     # No es una app con menú raíz, sino un módulo técnico
    'auto_install': False,    # Instalación manual requerida
    'installable': True,      # Visible y disponible para producción
    
    # === RECURSOS ADICIONALES ===
    'images': [
        'static/description/banner.png',
        'static/description/screenshot1.png',
        'static/description/screenshot2.png',
    ],
    'icon': 'static/description/icon.png',  # Requerido en Odoo Apps (128x128px mín.)
    
    # === INFORMACIÓN COMERCIAL (si aplica) ===
    'price': 120.00,         # Precio para módulos de pago
    'currency': 'USD',       # Moneda del precio
    'live_test_url': 'https://demo.erply.do',  # URL de demostración
    
    # === METADATOS TÉCNICOS ===
    'sequence': 10,          # Orden de instalación
    'complexity': 'expert',   # Nivel de complejidad: easy, normal, expert
    
    # === COMPATIBILIDAD Y MIGRACIÓN ===
    'migration_version': '18.0.1.0.0',  # Última versión migrada
    'odoo_version': '18.0',              # Versión específica de Odoo
    
    # === INFORMACIÓN DE DESARROLLO ===
    'development_status': 'Production/Stable',  # Alpha, Beta, Production/Stable, Mature
    'technical_name': 'erply_dgii_electronic_signature',  # Nombre técnico del módulo
    
    # === HOOKS DE INSTALACIÓN ===
    'pre_init_hook': 'pre_init_hook',      # Función ejecutada antes de instalar
    'post_init_hook': 'post_init_hook',    # Función ejecutada después de instalar
    'uninstall_hook': 'uninstall_hook',    # Función ejecutada al desinstalar
    'post_load': 'post_load_hook',         # Función ejecutada al cargar el módulo
    
    # === CONFIGURACIÓN DE ASSETS ===
    'assets': {
        'web.assets_backend': [
            'erply_dgii/static/src/js/signature_widget.js',
            'erply_dgii/static/src/css/signature_styles.css',
        ],
        'web.assets_frontend': [
            'erply_dgii/static/src/js/public_validation.js',
        ],
    },
}
```

## 🏷️ Categorías Estándar de Odoo

### Categorías Principales

| Categoría | Descripción |
|-----------|-------------|
| `Accounting` | Contabilidad y finanzas |
| `Sales` | Ventas y CRM |
| `Purchase` | Compras y proveedores |
| `Inventory` | Gestión de inventario |
| `Manufacturing` | Producción y MRP |
| `Human Resources` | Recursos humanos |
| `Marketing` | Marketing y comunicación |
| `Website` | Sitio web y eCommerce |
| `Point of Sale` | Punto de venta |
| `Productivity` | Productividad |
| `Services` | Servicios |
| `Extra Tools` | Herramientas adicionales |
| `Theme` | Temas de sitio web |
| `Industries` | Soluciones por industria |
| `Localization` | Localización por país |

### Subcategorías Comunes

```python
# Ejemplos de subcategorías
'category': 'Accounting/Localizations',
'category': 'Sales/Point of Sale',
'category': 'Human Resources/Payroll',
'category': 'Website/eCommerce',
'category': 'Manufacturing/Shop Floor',
```

## 📋 Checklist de Validación

### ✅ Antes de Publicar

- [ ] **Nombre descriptivo** sin caracteres especiales
- [ ] **Summary de máximo 60 caracteres**
- [ ] **Versión en formato semántico** correcto
- [ ] **Licencia compatible** con Odoo Apps
- [ ] **Autor y website** válidos
- [ ] **Categoría apropiada** seleccionada
- [ ] **Dependencias completas** declaradas
- [ ] **Archivos data** en orden correcto
- [ ] **Icono 128x128px** incluido
- [ ] **Description detallada** con características
- [ ] **External dependencies** especificadas

### ✅ Para Odoo Apps Store

- [ ] **Precio y moneda** si es de pago
- [ ] **Screenshots** en static/description/
- [ ] **Banner promocional** incluido
- [ ] **Demo data** funcional
- [ ] **Live test URL** si disponible
- [ ] **Documentación** completa
- [ ] **Tests unitarios** implementados

## 🔧 Manifest para Diferentes Tipos de Módulos

### 1. Módulo Técnico/Biblioteca

```python
{
    'name': 'API Connector Base',
    'summary': 'Base library for external API integrations',
    'version': '18.0.1.0.0',
    'license': 'LGPL-3',
    'author': 'Tu Empresa',
    'website': 'https://tuempresa.com',
    'category': 'Extra Tools',
    'depends': ['base', 'web'],
    'data': ['security/ir.model.access.csv'],
    'application': False,    # Módulo técnico, no app
    'auto_install': False,
    'installable': True,
}
```

### 2. Aplicación Completa

```python
{
    'name': 'Restaurant Management',
    'summary': 'Complete restaurant management solution',
    'version': '18.0.1.0.0',
    'license': 'OPL-1',
    'author': 'Restaurant Solutions Inc.',
    'website': 'https://restaurantsolutions.com',
    'category': 'Industries',
    'depends': ['base', 'sale', 'point_of_sale', 'stock'],
    'data': [
        'security/security.xml',
        'security/ir.model.access.csv',
        'views/menu.xml',
        'views/restaurant_views.xml',
    ],
    'application': True,     # Es una aplicación completa
    'auto_install': False,
    'installable': True,
    'price': 299.00,
    'currency': 'EUR',
}
```

### 3. Módulo de Localización

```python
{
    'name': 'Dominican Republic - Accounting',
    'summary': 'DGII compliance and fiscal requirements',
    'version': '18.0.1.0.0',
    'license': 'AGPL-3',
    'author': 'Localización DO Team',
    'website': 'https://github.com/odoo-dominicana',
    'category': 'Accounting/Localizations',
    'depends': ['account', 'base', 'web'],
    'data': [
        'data/account_chart_template.xml',
        'data/account_tax_template.xml',
        'views/account_views.xml',
    ],
    'application': False,
    'auto_install': False,
    'installable': True,
    'post_init_hook': 'load_translations',
}
```

### 4. Módulo Auto-instalable

```python
{
    'name': 'Sale Stock Integration',
    'summary': 'Automatic integration between Sales and Inventory',
    'version': '18.0.1.0.0',
    'license': 'AGPL-3',
    'author': 'Odoo SA',
    'website': 'https://www.odoo.com',
    'category': 'Sales',
    'depends': ['sale', 'stock'],
    'data': ['views/sale_order_views.xml'],
    'application': False,
    'auto_install': True,    # Se instala automáticamente si sale y stock están instalados
    'installable': True,
}
```

## 🚨 Errores Comunes y Soluciones

### Error: "Dependencia no encontrada"

**Problema**: Módulo declarado en `depends` no existe
```python
'depends': ['base', 'account', 'non_existent_module'],  # ❌
```

**Solución**: Verificar nombres exactos
```python
'depends': ['base', 'account', 'sale_management'],      # ✅
```

### Error: "Versión inválida"

**Problema**: Formato de versión incorrecto
```python
'version': '1.0',           # ❌
'version': '18.0.1',        # ❌
```

**Solución**: Usar formato semántico completo
```python
'version': '18.0.1.0.0',    # ✅
```

### Error: "Categoría no válida"

**Problema**: Categoría inexistente
```python
'category': 'My Custom Category',  # ❌
```

**Solución**: Usar categorías estándar
```python
'category': 'Extra Tools',         # ✅
```

### Error: "Archivos en orden incorrecto"

**Problema**: security.xml antes que ir.model.access.csv
```python
'data': [
    'security/security.xml',           # ❌ Orden incorrecto
    'security/ir.model.access.csv',
    'views/views.xml',
],
```

**Solución**: Respetar orden de carga
```python
'data': [
    'security/ir.model.access.csv',    # ✅ Primero access rights
    'security/security.xml',           # ✅ Luego grupos y reglas
    'views/views.xml',
],
```

## 📈 Mejores Prácticas

### 1. **Documentación Clara**
- Summary conciso pero descriptivo
- Description con características principales
- Casos de uso explicados

### 2. **Dependencias Mínimas**
- Solo incluir dependencias realmente necesarias
- Evitar dependencias circulares
- Documentar dependencias opcionales

### 3. **Versionado Consistente**
- Seguir versionado semántico estrictamente
- Documentar cambios en cada versión
- Mantener compatibilidad hacia atrás cuando sea posible

### 4. **Metadata Completa**
- Incluir toda la información comercial
- Screenshots de calidad
- Documentación de instalación

### 5. **Testing y Validación**
- Usar herramientas de validación de Odoo
- Probar instalación/desinstalación
- Verificar en múltiples databases

## ✅ Resultado Esperado

Al completar esta guía, podrás:

- ✅ **Redactar un `__manifest__.py` completo, válido y limpio**
- ✅ **Declarar dependencias correctas** para evitar fallos de instalación
- ✅ **Versionar profesionalmente** tu módulo con estándar semántico
- ✅ **Cumplir con las reglas** del validador de Odoo Apps Store
- ✅ **Preparar tu módulo** para publicación y despliegue automatizado
- ✅ **Evitar errores comunes** en la estructura del manifest
- ✅ **Optimizar el módulo** para diferentes tipos de implementación

---

**💡 Consejo Final**: El `__manifest__.py` es la primera impresión de tu módulo. Una buena estructura aquí facilita el mantenimiento, la distribución y la adopción por parte de otros desarrolladores.
