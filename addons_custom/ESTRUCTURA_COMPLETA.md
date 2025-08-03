# Estructura Completa de Módulo Odoo 18

Esta guía detalla la estructura completa y profesional para desarrollar módulos en Odoo 18.

## 📁 Estructura de Directorio Completa

```
addons_custom/mi_modulo_completo/
├── __manifest__.py              # Descripción técnica, versión, dependencias
├── __init__.py                  # Carga inicial del módulo
├── README.md                    # Guía para el usuario (Markdown)
├── LICENSE                      # Archivo de licencia seleccionada
├── models/                      # Modelos de datos con lógica de negocio
│   ├── __init__.py
│   ├── mi_modelo.py
│   └── res_partner.py          # Extensión de modelos existentes
├── views/                       # Archivos XML para UI
│   ├── mi_modelo_views.xml     # Formularios, listas
│   ├── mi_modelo_menus.xml     # Menús y acciones
│   └── inherited_views.xml     # Vistas heredadas
├── security/                    # Reglas de acceso y seguridad
│   ├── ir.model.access.csv     # Permisos básicos de modelo
│   └── security.xml            # Reglas de registro y grupos
├── i18n/                        # Archivos de traducción
│   ├── es.po                   # Español
│   ├── en.po                   # Inglés
│   └── template.pot            # Plantilla de traducción
├── data/                        # Datos precargados
│   ├── data.xml                # Datos base del módulo
│   ├── sequences.xml           # Secuencias numéricas
│   └── mail_templates.xml      # Plantillas de email
├── static/                      # Archivos estáticos
│   ├── description/
│   │   ├── icon.png            # Icono del módulo (128x128 mínimo)
│   │   ├── index.html          # Descripción visual con imágenes y guía
│   │   ├── banner.png          # Banner promocional (opcional)
│   │   ├── screenshot1.png     # Capturas de pantalla
│   │   └── screenshot2.png     # Capturas adicionales
│   └── src/
│       ├── js/
│       │   └── mi_script.js    # JavaScript personalizado
│       ├── css/
│       │   └── mi_estilo.css   # Estilos CSS
│       └── xml/
│           └── templates.xml   # Plantillas QWeb
├── controllers/                 # Controladores web (opcional)
│   ├── __init__.py
│   └── main.py
├── report/                      # Reportes (opcional)
│   ├── __init__.py
│   ├── mi_reporte.py
│   └── templates.xml
├── tests/                       # Tests unitarios y funcionales
│   ├── __init__.py
│   ├── test_mi_modelo.py       # Tests unitarios
│   ├── test_wizard.py          # Tests de wizards
│   └── test_common.py          # Utilidades comunes para tests
└── wizard/                      # Asistentes/Wizards (opcional)
    ├── __init__.py
    ├── mi_wizard.py
    └── mi_wizard_views.xml
```

## 🚀 Comando para Crear Estructura

```bash
# Script para crear estructura completa
./scripts/create_module.sh mi_modulo_completo
```

En los siguientes archivos te muestro cómo implementar cada componente:

## 📚 Documentación Detallada

- **[EJEMPLOS_ARCHIVOS.md](EJEMPLOS_ARCHIVOS.md)** - Implementación completa de `__manifest__.py`, `__init__.py`, modelos Python con todos los métodos y funcionalidades
- **[EJEMPLOS_XML.md](EJEMPLOS_XML.md)** - Vistas XML completas (formularios, listas, kanban, pivot), menús, acciones, archivos de seguridad y datos precargados
- **[TRADUCCION_WIZARDS.md](TRADUCCION_WIZARDS.md)** - Archivos de traducción (i18n), wizards/asistentes avanzados con procesamiento masivo

## 🚀 Crear Módulo Automáticamente

```bash
# Usar script automatizado para crear estructura completa
./scripts/create_module.sh mi_nuevo_modulo

# Instalar el módulo creado
./scripts/start.sh -db dev -i mi_nuevo_modulo
```

## 📋 Checklist de Desarrollo

### ✅ Estructura Básica
- [ ] `__manifest__.py` con dependencias y metadatos
- [ ] `__init__.py` con importaciones correctas
- [ ] Directorio `models/` con modelos Python
- [ ] Directorio `views/` con archivos XML

### ✅ Seguridad y Permisos
- [ ] `security/ir.model.access.csv` con permisos básicos
- [ ] `security/security.xml` con grupos y reglas de registro
- [ ] Validación de accesos por usuario/grupo

### ✅ Datos y Configuración
- [ ] `data/sequences.xml` para códigos automáticos
- [ ] `data/data.xml` con datos base y parámetros
- [ ] `data/mail_templates.xml` para notificaciones

### ✅ Interfaz de Usuario
- [ ] Vistas lista, formulario, búsqueda
- [ ] Menús y acciones configurados
- [ ] Kanban y gráficos si son necesarios

### ✅ Internacionalización
- [ ] Directorio `i18n/` creado
- [ ] Archivos `.po` para idiomas soportados
- [ ] Campos con `translate=True` cuando corresponda

### ✅ Funcionalidades Avanzadas
- [ ] Wizards para operaciones masivas
- [ ] Reportes PDF personalizados
- [ ] Tests unitarios en `tests/`
- [ ] Controladores web si son necesarios

### ✅ Documentación y Presentación
- [ ] `README.md` con guía de usuario detallada
- [ ] `static/description/icon.png` (128x128 mínimo)
- [ ] `static/description/index.html` con descripción visual
- [ ] `LICENSE` con licencia apropiada
- [ ] Capturas de pantalla y banners promocionales
- [ ] `__manifest__.py` profesional y completo

### 📚 Documentación Técnica Disponible
- [ ] **[MANIFEST_PROFESIONAL.md](MANIFEST_PROFESIONAL.md)** - Guía completa del __manifest__.py
- [ ] **[DOCUMENTACION_TESTS.md](DOCUMENTACION_TESTS.md)** - Ejemplos de README, LICENSE, tests
- [ ] **[EJEMPLOS_ARCHIVOS.md](EJEMPLOS_ARCHIVOS.md)** - Ejemplos de archivos Python
- [ ] **[EJEMPLOS_XML.md](EJEMPLOS_XML.md)** - Ejemplos de vistas y datos XML
- [ ] **[TRADUCCION_WIZARDS.md](TRADUCCION_WIZARDS.md)** - i18n y wizards

### 🔧 Scripts de Validación
- [ ] `./scripts/validate_manifest.sh` - Validar __manifest__.py
- [ ] `./scripts/create_documentation.sh` - Crear documentación completa
- [ ] `./scripts/create_module.sh` - Crear módulo con estructura profesional

## 🔧 Comandos Útiles para Desarrollo

```bash
# Desarrollo con auto-reload
./scripts/start.sh -d -db dev

# Instalar módulo nuevo
./scripts/start.sh -db dev -i mi_modulo

# Actualizar módulo después de cambios
./scripts/start.sh -db dev -u mi_modulo

# Generar traducciones
python3 odoo/odoo-bin -d dev --i18n-export=addons_custom/mi_modulo/i18n/template.pot -m mi_modulo --stop-after-init

# Debug con VS Code
# Usar configuración "Odoo: Debug" en el panel de debug
```

## 🎯 Mejores Prácticas

### Nomenclatura
- **Modelos**: `mi.modelo.nombre` (puntos como separadores)
- **Archivos**: `mi_archivo_nombre.py` (guiones bajos)
- **XML IDs**: `mi_modelo_vista_tipo` (consistente y descriptivo)

### Estructura de Código
- **Campos**: Agrupar por tipo (básicos, relacionales, calculados)
- **Métodos**: Orden lógico (compute, constrains, onchange, actions)
- **Validaciones**: Usar `@api.constrains` para validaciones de datos

### Seguridad
- **Grupos**: Crear grupos específicos por funcionalidad
- **Reglas**: Implementar reglas de registro para multicompañía
- **Permisos**: Principio de menor privilegio

### Performance
- **Campos calculados**: Usar `store=True` cuando sea apropiado
- **Índices**: Agregar `index=True` en campos de búsqueda frecuente
- **Dominios**: Optimizar consultas con dominios eficientes

¡Con esta estructura completa podrás desarrollar módulos profesionales y robustos en Odoo 18! 🎉
