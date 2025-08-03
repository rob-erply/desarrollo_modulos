# Módulos Personalizados - CardNet Provider

Este directorio contiene tus módulos Odoo 18 personalizados para la integración con CardNet.

## 🗂 Rutas de Módulos Disponibles

Tu instancia Odoo tiene acceso a módulos desde:

1. **Módulos Core**: `/workspaces/proevedor_cardnet/odoo/addons` - Funcionalidad base de Odoo
2. **Módulos Enterprise**: `/workspaces/proevedor_cardnet/enterprise` - Características premium
3. **Módulos Personalizados**: `/workspaces/proevedor_cardnet/addons_custom` - Tus desarrollos

## 🚀 Crear Nuevo Módulo

### Usando scaffold de Odoo:
```bash
python3 odoo/odoo-bin scaffold cardnet_provider addons_custom/
```

### Estructura manual recomendada:
```
addons_custom/cardnet_provider/
├── __init__.py
├── __manifest__.py
├── models/
│   ├── __init__.py
│   ├── payment_provider.py
│   └── payment_transaction.py
├── controllers/
│   ├── __init__.py
│   └── main.py
├── views/
│   ├── payment_provider_views.xml
│   └── payment_templates.xml
├── security/
│   └── ir.model.access.csv
├── data/
│   └── payment_provider_data.xml
└── static/
    ├── description/
    │   ├── icon.png
    │   └── index.html
    └── src/
        ├── js/
        └── css/
```

## 📋 Módulos Típicos para CardNet

### 1. **cardnet_base** - Configuración base
- Configuración del proveedor CardNet
- Campos personalizados
- Utilidades comunes

### 2. **cardnet_payment** - Procesamiento de pagos  
- Integración con API CardNet
- Manejo de transacciones
- Webhooks y notificaciones

### 3. **cardnet_reporting** - Reportes
- Dashboards de transacciones
- Reportes de conciliación
- Analytics de pagos

### 4. **cardnet_pos** - Punto de Venta
- Integración con TPV CardNet
- Métodos de pago POS
- Sincronización de datos

## 🔧 Plantilla de __manifest__.py

```python
{
    'name': 'CardNet Payment Provider',
    'version': '18.0.1.0.0',
    'category': 'Accounting/Payment Providers',
    'summary': 'Integración con proveedor de pagos CardNet',
    'description': '''
        Módulo para integración completa con CardNet:
        - Procesamiento de pagos online
        - Webhooks y notificaciones
        - Reportes y conciliación
    ''',
    'author': 'Tu Empresa',
    'website': 'https://tu-sitio.com',
    'depends': [
        'base',
        'payment',
        'account',
        'sale',
    ],
    'data': [
        'security/ir.model.access.csv',
        'data/payment_provider_data.xml',
        'views/payment_provider_views.xml',
        'views/payment_templates.xml',
    ],
    'assets': {
        'web.assets_frontend': [
            'cardnet_provider/static/src/js/payment_form.js',
            'cardnet_provider/static/src/css/payment_form.css',
        ],
    },
    'installable': True,
    'auto_install': False,
    'application': False,
    'license': 'LGPL-3',
}
```

## 🔍 Comandos de Desarrollo

```bash
# Instalar tu módulo
./scripts/start.sh -db dev -i cardnet_provider

# Actualizar después de cambios
./scripts/start.sh -db dev -u cardnet_provider

# Desarrollo con auto-reload
./scripts/start.sh -d -db dev

# Debug con breakpoints
# Usar configuración "Odoo: Debug" en VS Code
```

## 🧪 Testing

```bash
# Instalar dependencias de testing
pip3 install pytest pytest-odoo

# Ejecutar tests (cuando estén creados)
pytest addons_custom/cardnet_provider/tests/
```

¡Comienza a desarrollar tu integración CardNet aquí! 🎯
