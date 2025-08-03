# 🚀 Framework Profesional de Desarrollo Odoo 18

Entorno de desarrollo completo para Odoo 18 con módulos Enterprise y configuración optimizada para crear módulos profesionales.

**Desarrollado por ERPly S.R.L.** - Especialistas en implementación Odoo

## 🏢 Contacto ERPly S.R.L.
- 📧 **Email**: info@erply.do
- 📞 **Teléfono**: +1 (849) 517-5363
- 📍 **Dirección**: Calle Dr. Jacinto Ignacio Mañón #7, República Dominicana

## 🚀 Inicio Rápido

1. **Abrir en CodeSpaces** - Click en "Code" → "Codespaces" → "Create codespace"
2. **Reconstruir devcontainer** - VS Code te pedirá reconstruir automáticamente
3. **Esperar setup automático** - El script configurará Odoo 18 + Enterprise
4. **Empezar a desarrollar** - Usa `./scripts/start.sh` para arrancar

## 📁 Estructura del Proyecto

```
proevedor_cardnet/
├── .devcontainer/           # Configuración devcontainer
├── addons_custom/          # 🎯 TUS MÓDULOS PERSONALIZADOS
├── scripts/                # Scripts de desarrollo automatizados
├── logs/                   # Logs de Odoo
├── config/                 # Configuraciones de Odoo
└── odoo/                   # Core de Odoo 18 + Enterprise
```

## 🛠️ Scripts Automatizados Incluidos

### 📝 Crear Módulo Profesional
```bash
# Crear módulo completo con estructura profesional
./scripts/create_module.sh mi_nuevo_modulo

# Con parámetros avanzados
./scripts/create_module.sh mi_modulo "Mi Módulo Increíble" "ERPly S.R.L." "info@erply.do"
```

### 📚 Generar Documentación
```bash
# Crear documentación completa para módulo existente
./scripts/create_documentation.sh addons_custom/mi_modulo

# Regenerar documentación
./scripts/create_documentation.sh addons_custom/mi_modulo --force
```

### ✅ Validar Manifesto
```bash
# Validar __manifest__.py de un módulo
python3 scripts/validate_manifest.py addons_custom/mi_modulo/__manifest__.py
```

## 🎯 Framework de Desarrollo Completo

### Scripts de Automatización
- **[create_module.sh](scripts/create_module.sh)** - 🔧 Creación automática de módulos profesionales
- **[create_documentation.sh](scripts/create_documentation.sh)** - 📖 Generación de documentación completa
- **[validate_manifest.py](scripts/validate_manifest.py)** - ✅ Validación de manifiestos

### Guías de Desarrollo
- **[ESTRUCTURA_COMPLETA.md](addons_custom/ESTRUCTURA_COMPLETA.md)** - Estructura completa de módulos
- **[MANIFEST_PROFESIONAL.md](addons_custom/MANIFEST_PROFESIONAL.md)** - El corazón técnico del módulo
- **[EJEMPLOS_ARCHIVOS.md](addons_custom/EJEMPLOS_ARCHIVOS.md)** - Ejemplos de archivos Python
- **[EJEMPLOS_XML.md](addons_custom/EJEMPLOS_XML.md)** - Ejemplos de vistas y datos XML
- **[TRADUCCION_WIZARDS.md](addons_custom/TRADUCCION_WIZARDS.md)** - i18n y wizards
- **[DOCUMENTACION_TESTS.md](addons_custom/DOCUMENTACION_TESTS.md)** - README, LICENSE y tests
- **[RESUMEN_FRAMEWORK_COMPLETO.md](addons_custom/RESUMEN_FRAMEWORK_COMPLETO.md)** - 🎉 **Resumen completo del framework**
- **[SOBRE_ERPLY.md](addons_custom/SOBRE_ERPLY.md)** - 🏢 **Información sobre ERPly S.R.L.**

---

## 🤝 Contribuir

### Proceso de Contribución

1. Fork del repositorio
2. Crear rama para la funcionalidad: `git checkout -b feature/nueva-funcionalidad`
3. Realizar cambios y tests
4. Commit con mensaje descriptivo
5. Push y crear Pull Request

### Automatización
- **Scripts automatizados** para crear estructura completa
- **Templates profesionales** listos para usar
- **Ejemplos exhaustivos** de cada componente

### Componentes Profesionales Incluidos
- � **README.md** - Documentación completa del módulo
- 📜 **LICENSE** - Archivos de licencia (LGPL-3, MIT)
- 🌐 **index.html** - Descripción visual profesional
- 🧪 **Tests** - Tests unitarios y funcionales completos
- 🎨 **Iconos** - Templates para iconos de módulo

---

## 📞 Contacto y Soporte ERPly S.R.L.

**ERPly S.R.L.** - Tu socio estratégico en implementación Odoo
- 📧 **Email**: info@erply.do
- 📞 **Teléfono**: +1 (849) 517-5363
- 📍 **Dirección**: Calle Dr. Jacinto Ignacio Mañón #7, República Dominicana

### 🎯 Nuestros Servicios
- **Consultoría Odoo**: Análisis y planificación estratégica
- **Desarrollo Custom**: Módulos personalizados y integraciones
- **Implementación**: Migración y puesta en marcha
- **Soporte**: Mantenimiento y actualizaciones
- **Capacitación**: Formación técnica y funcional

---
*Framework desarrollado con ❤️ por el equipo de ERPly S.R.L.*

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
