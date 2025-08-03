# Módulos Personalizados - Desarrollo Odoo

Este directorio contiene tus módulos Odoo 18 personalizados para cualquier tipo de desarrollo.

## 🗂 Rutas de Módulos Disponibles

Tu instancia Odoo tiene acceso a módulos desde:

1. **Módulos Core**: `/workspaces/proevedor_cardnet/odoo/addons` - Funcionalidad base de Odoo
2. **Módulos Enterprise**: `/workspaces/proevedor_cardnet/enterprise` - Características premium
3. **Módulos Personalizados**: `/workspaces/proevedor_cardnet/addons_custom` - Tus desarrollos

## 🚀 Crear Nuevo Módulo

### Usando scaffold de Odoo:
```bash
python3 odoo/odoo-bin scaffold mi_modulo addons_custom/
```

### Estructura manual recomendada:
```
addons_custom/mi_modulo/
├── __init__.py
├── __manifest__.py
├── models/
│   ├── __init__.py
│   └── mi_model.py
├── controllers/
│   ├── __init__.py
│   └── main.py
├── views/
│   ├── mi_views.xml
│   └── mi_templates.xml
├── security/
│   └── ir.model.access.csv
├── data/
│   └── mi_data.xml
└── static/
    ├── description/
    │   ├── icon.png
    │   └── index.html
    └── src/
        ├── js/
        └── css/
```

## 📋 Tipos de Módulos Comunes

### 1. **Módulos de Negocio**
- Gestión de procesos específicos
- Workflows personalizados
- Automatizaciones

### 2. **Integraciones con APIs**  
- Conectores con servicios externos
- Sincronización de datos
- Webhooks y notificaciones

### 3. **Reportes y Dashboards**
- Reportes personalizados
- Análisis de datos
- Métricas de negocio

### 4. **Personalización de UI/UX**
- Vistas personalizadas
- Componentes web
- Temas y estilos

### 5. **Extensiones de Funcionalidad**
- Nuevos campos en modelos existentes
- Métodos adicionales
- Validaciones personalizadas

## 🔧 Plantilla de __manifest__.py

```python
{
    'name': 'Mi Módulo Personalizado',
    'version': '18.0.1.0.0',
    'category': 'Extra Tools',
    'summary': 'Descripción breve del módulo',
    'description': '''
        Descripción detallada del módulo:
        - Funcionalidad principal
        - Características específicas
        - Casos de uso
    ''',
    'author': 'Tu Empresa',
    'website': 'https://tu-sitio.com',
    'depends': [
        'base',
        'sale',
        'account',
        # Agrega las dependencias necesarias
    ],
    'data': [
        'security/ir.model.access.csv',
        'data/mi_data.xml',
        'views/mi_views.xml',
        'views/mi_templates.xml',
    ],
    'assets': {
        'web.assets_frontend': [
            'mi_modulo/static/src/js/mi_script.js',
            'mi_modulo/static/src/css/mi_estilo.css',
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
./scripts/start.sh -db dev -i mi_modulo

# Actualizar después de cambios
./scripts/start.sh -db dev -u mi_modulo

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
pytest addons_custom/mi_modulo/tests/
```

¡Comienza a desarrollar tus módulos personalizados aquí! 🎯
