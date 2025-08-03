# -*- coding: utf-8 -*-
{
    # === INFORMACIÓN BÁSICA ===
    'name': 'Prueba Manifest Profesional',
    'summary': 'Módulo personalizado para [DESCRIBIR FUNCIONALIDAD ESPECÍFICA]',
    'description': """
        Prueba Manifest Profesional
        
        Este módulo proporciona funcionalidades avanzadas para:
        • Gestión completa de registros específicos
        • Workflow automatizado con estados controlados
        • Sistema de notificaciones y seguimiento
        • Reportes y análisis personalizados
        • Integración con módulos core de Odoo
        
        Características técnicas:
        • Herencia de mail.thread para seguimiento
        • Campos calculados con optimización
        • Validaciones personalizadas robustas
        • Wizards para operaciones masivas
        • API endpoints para integraciones
        
        Beneficios empresariales:
        • Mejora la eficiencia operativa
        • Automatiza procesos manuales
        • Proporciona trazabilidad completa
        • Facilita la toma de decisiones
        • Cumple con estándares de calidad
    """,
    
    # === VERSIONADO Y LICENCIA ===
    'version': '18.0.1.0.0',        # Odoo 18, release 1, stable
    'license': 'AGPL-3',            # Compatible con Odoo Community
    
    # === INFORMACIÓN DEL AUTOR ===
    'author': 'ERPly S.R.L.',
    'maintainer': 'ERPly S.R.L. Development Team',
    'website': 'https://erply.do',
    'support': 'info@erply.do',
    
    # === CATEGORIZACIÓN ===
    'category': 'Extra Tools',       # Cambiar según corresponda
    'tags': ['productivity', 'management', 'automation'],
    
    # === DEPENDENCIAS ===
    'depends': [
        'base',                      # Funcionalidades básicas de Odoo
        'mail',                      # Sistema de mensajería y chatter
        'web',                       # Interfaz web y funcionalidades AJAX
        # Agregar otras dependencias según necesidades:
        # 'account',                 # Para funcionalidad contable
        # 'sale',                    # Para integración con ventas
        # 'purchase',                # Para integración con compras
        # 'stock',                   # Para gestión de inventario
        # 'hr',                      # Para recursos humanos
        # 'project',                 # Para gestión de proyectos
    ],
    
    # === ARCHIVOS DE DATOS ===
    'data': [
        # Seguridad (ORDEN IMPORTANTE)
        'security/ir.model.access.csv',    # Primero: derechos de acceso
        'security/security.xml',           # Segundo: grupos y reglas
        
        # Datos maestros
        'data/sequences.xml',              # Secuencias numericas
        'data/data.xml',                   # Datos iniciales
        'data/mail_templates.xml',         # Plantillas de email
        'data/cron_jobs.xml',              # Tareas programadas (si las hay)
        
        # Vistas (en orden lógico)
        'views/prueba_manifest_profesional_views.xml',   # Vistas principales
        'views/prueba_manifest_profesional_menus.xml',   # Menús y acciones
        'views/inherited_views.xml',        # Herencias de vistas existentes
        
        # Reportes
        'reports/report_templates.xml',     # Templates de reportes
        'reports/paperformat.xml',          # Formatos de papel (si es necesario)
        
        # Wizards
        'wizards/prueba_manifest_profesional_wizard_views.xml',  # Vistas de wizards
    ],
    
    # === DATOS DE DEMOSTRACIÓN ===
    'demo': [
        'demo/demo_data.xml',              # Datos de prueba
        'demo/demo_users.xml',             # Usuarios de demo
    ],
    
    # === DEPENDENCIAS EXTERNAS ===
    'external_dependencies': {
        'python': [
            # Agregar librerías Python necesarias:
            # 'requests',              # Para llamadas HTTP
            # 'lxml',                  # Para procesamiento XML
            # 'pillow',                # Para procesamiento imágenes  
            # 'openpyxl',              # Para archivos Excel
            # 'reportlab',             # Para generación PDF
        ],
        'bin': [
            # Agregar binarios del sistema necesarios:
            # 'wkhtmltopdf',           # Para reportes PDF avanzados
        ],
    },
    
    # === CONFIGURACIÓN DEL MÓDULO ===
    'application': False,               # True si es app principal con menú raíz
    'auto_install': False,              # True para instalación automática
    'installable': True,                # True para disponibilidad de instalación
    
    # === ASSETS WEB ===
    'assets': {
        'web.assets_backend': [
            # JavaScript para backend
            'prueba_manifest_profesional/static/src/js/widget.js',
            'prueba_manifest_profesional/static/src/js/views.js',
            # CSS para backend  
            'prueba_manifest_profesional/static/src/css/styles.css',
        ],
        'web.assets_frontend': [
            # JavaScript para frontend (si aplica)
            'prueba_manifest_profesional/static/src/js/public.js',
            # CSS para frontend
            'prueba_manifest_profesional/static/src/css/public.css',
        ],
        'web.qunit_suite_tests': [
            # Tests JavaScript (si los hay)
            'prueba_manifest_profesional/static/src/js/tests/*.js',
        ],
    },
    
    # === RECURSOS ADICIONALES ===
    'images': [
        'static/description/banner.png',        # Banner promocional
        'static/description/screenshot1.png',   # Capturas de pantalla
        'static/description/screenshot2.png',
    ],
    'icon': 'static/description/icon.png',      # Icono 128x128px mínimo
    
    # === METADATOS TÉCNICOS ===
    'sequence': 100,                           # Orden de instalación
    'complexity': 'normal',                    # easy, normal, expert
    'development_status': 'Beta',              # Alpha, Beta, Production/Stable, Mature
    'technical_name': 'prueba_manifest_profesional',        # Nombre técnico
    
    # === COMPATIBILIDAD ===
    'odoo_version': '18.0',                    # Versión específica de Odoo
    'python_requires': '>=3.10',              # Versión mínima de Python
    
    # === HOOKS DE INSTALACIÓN (si son necesarios) ===
    # 'pre_init_hook': 'pre_init_hook',        # Función antes de instalar
    # 'post_init_hook': 'post_init_hook',      # Función después de instalar  
    # 'uninstall_hook': 'uninstall_hook',      # Función al desinstalar
    # 'post_load': 'post_load_hook',           # Función al cargar módulo
    
    # === INFORMACIÓN COMERCIAL (si aplica) ===
    # 'price': 0.00,                           # Precio del módulo
    # 'currency': 'EUR',                       # Moneda del precio
    # 'live_test_url': 'https://demo.tu-empresa.com',  # URL de demostración
}
