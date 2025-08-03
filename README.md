# Desarrollo Módulos Odoo 18

Entorno de desarrollo completo para Odoo 18 con módulos Enterprise y configuración optimizada para CodeSpaces.

## 🚀 Inicio Rápido

1. **Abrir en CodeSpaces** - Click en "Code" → "Codespaces" → "Create codespace"
2. **Reconstruir devcontainer** - VS Code te pedirá reconstruir automáticamente
3. **Esperar setup automático** - El script configurará Odoo 18 + Enterprise
4. **Empezar a desarrollar** - Usa `./scripts/start.sh` para arrancar

## 📁 Estructura del Proyecto

```
├── .devcontainer/          # Configuración CodeSpaces/DevContainer
├── odoo/                   # Core Odoo 18 (clonado desde GitHub oficial)
├── enterprise/             # Módulos Enterprise Odoo 18
├── addons_custom/          # Tus módulos personalizados
├── config/                 # Archivos de configuración Odoo
├── logs/                   # Logs de la aplicación
├── scripts/                # Scripts de utilidad
│   ├── setup.sh           # Setup automático del entorno
│   └── start.sh           # Script simplificado de arranque
├── requirements.txt        # Dependencias Python adicionales
└── README.md              # Esta documentación
```

## 🔧 Scripts Disponibles

### Arranque Simplificado
```bash
# Arranque normal
./scripts/start.sh

# Modo desarrollo (auto-reload)
./scripts/start.sh -d

# Con base de datos específica
./scripts/start.sh -db mi_db

# Instalar módulo
./scripts/start.sh -db mi_db -i mi_modulo  

# Actualizar módulo
./scripts/start.sh -db mi_db -u mi_modulo

# Ver todas las opciones
./scripts/start.sh --help
```

### Creación de Módulos
```bash
# Crear módulo completo
./scripts/create_module.sh mi_nuevo_modulo

# Crear módulo con Company específica
./scripts/create_module.sh mi_modulo_ventas --company "Mi Empresa S.L."

# Ver opciones disponibles
./scripts/create_module.sh --help
```

### Documentación Profesional
```bash
# Crear toda la documentación para un módulo
./scripts/create_documentation.sh mi_modulo

# Crear solo README.md
./scripts/create_documentation.sh --readme mi_modulo

# Crear solo tests
./scripts/create_documentation.sh --tests mi_modulo

# Ver todas las opciones
./scripts/create_documentation.sh --help
```

### Validación de Módulos
```bash
# Validar __manifest__.py de un módulo
./scripts/validate_manifest.sh addons_custom/mi_modulo

# Validación estricta para Odoo Apps Store
./scripts/validate_manifest.sh --strict addons_custom/mi_modulo

# Validación con información detallada
./scripts/validate_manifest.sh --verbose addons_custom/mi_modulo

# Ver opciones de validación
./scripts/validate_manifest.sh --help
```

## 🛠 Configuración del Entorno

### Rutas de Módulos
- **Core Odoo**: `/workspaces/proevedor_cardnet/odoo/addons`
- **Enterprise**: `/workspaces/proevedor_cardnet/enterprise`  
- **Personalizados**: `/workspaces/proevedor_cardnet/addons_custom`

### Base de Datos
- **Host**: localhost
- **Puerto**: 5432
- **Usuario**: odoo
- **Contraseña**: odoo
- **BD por defecto**: dev

### Puertos
- **8069**: Servidor Web Odoo
- **8072**: Longpolling Odoo

## 🚀 Acceso a la Aplicación

Una vez iniciado, accede a Odoo en: **http://localhost:8069**

**Contraseña maestra por defecto**: `admin`

## 📚 Documentación Completa

Este workspace incluye documentación exhaustiva para el desarrollo de módulos Odoo:

### Guías de Desarrollo
- **[ESTRUCTURA_COMPLETA.md](addons_custom/ESTRUCTURA_COMPLETA.md)** - Estructura completa de módulos
- **[MANIFEST_PROFESIONAL.md](addons_custom/MANIFEST_PROFESIONAL.md)** - El corazón técnico del módulo
- **[EJEMPLOS_ARCHIVOS.md](addons_custom/EJEMPLOS_ARCHIVOS.md)** - Ejemplos de archivos Python
- **[EJEMPLOS_XML.md](addons_custom/EJEMPLOS_XML.md)** - Ejemplos de vistas y datos XML
- **[TRADUCCION_WIZARDS.md](addons_custom/TRADUCCION_WIZARDS.md)** - i18n y wizards
- **[DOCUMENTACION_TESTS.md](addons_custom/DOCUMENTACION_TESTS.md)** - README, LICENSE y tests
- **[RESUMEN_FRAMEWORK_COMPLETO.md](addons_custom/RESUMEN_FRAMEWORK_COMPLETO.md)** - 🎉 **Resumen completo del framework**

### Componentes Profesionales Incluidos
- 📄 **README.md** - Documentación completa del módulo
- 📜 **LICENSE** - Archivos de licencia (LGPL-3, MIT)
- 🌐 **index.html** - Descripción visual profesional
- 🧪 **Tests** - Tests unitarios y funcionales completos
- 🎨 **Iconos** - Templates para iconos de módulo

### Automatización
- **Scripts automatizados** para crear estructura completa
- **Templates profesionales** listos para usar
- **Ejemplos exhaustivos** de cada componente

## 📦 Crear Módulos Personalizados

```bash
# Usando scaffold de Odoo
python3 odoo/odoo-bin scaffold mi_modulo addons_custom/

# O crear manualmente en addons_custom/
mkdir -p addons_custom/mi_modulo
```

### Estructura típica de módulo:
```
addons_custom/mi_modulo/
├── __init__.py
├── __manifest__.py
├── models/
├── views/
├── security/
├── data/
└── static/
```

## 🔍 Comandos Útiles para Desarrollo

```bash
# Desarrollo con auto-reload
./scripts/start.sh -d

# Testing con base de datos temporal  
./scripts/start.sh -db test_modulos -i base,account,sale

# Shell interactivo
./scripts/start.sh --shell -db mi_db

# Logs en tiempo real
tail -f logs/odoo.log
```

## 🐛 Debug y Desarrollo

### VS Code Tasks Disponibles:
- **Start Odoo**: Arranque normal
- **Start Odoo (Development Mode)**: Con auto-reload
- **Install Module**: Instalar módulo específico
- **Update Module**: Actualizar módulo existente

### Configuraciones de Debug:
- **Odoo: Debug**: Debug completo con breakpoints
- **Odoo: Install Module**: Debug instalación de módulos
- **Odoo: Update Module**: Debug actualización de módulos

## 📚 Extensiones VS Code Incluidas

- **Python**: Soporte completo para Python
- **Owl Debugger**: Debug para framework OWL de Odoo
- **Jupyter**: Para análisis de datos y prototipado

## 🔒 Consideraciones Enterprise

- ✅ **Desarrollo**: Módulos Enterprise funcionan sin licencia
- ⚠️ **Producción**: Requiere suscripción válida de Odoo Enterprise
- 📋 **Módulos incluidos**: Contabilidad avanzada, Manufactura, Inventario, eCommerce, etc.

## 📋 Próximos Pasos

1. **Configura tus módulos personalizados** en `addons_custom/`
2. **Desarrolla funcionalidades específicas** para tu negocio
3. **Integra con APIs externas** usando las utilidades incluidas
4. **Testa exhaustivamente** usando el entorno de desarrollo

¡Tu entorno Odoo 18 está listo para el desarrollo de módulos! 🎉