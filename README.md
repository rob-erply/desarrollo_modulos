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