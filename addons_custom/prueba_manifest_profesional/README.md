# Addons Custom/Prueba Manifest Profesional

[![License: LGPL-3](https://img.shields.io/badge/License-LGPL%20v3-blue.svg)](https## 🙏 Créditos

- **Autor**: ERPly S.R.L.
- **Empresa**: ERPly S.R.L. - Especialistas en Odoo
- **Contacto**: info@erply.do | +1 (849) 517-5363
- **Dirección**: Calle Dr. Jacinto Ignacio Mañón #7, República Dominicana

## 📚 Recursos Adicionales

- [Documentación Oficial de Odoo](https://www.odoo.com/documentation/18.0/)
- [OCA (Odoo Community Association)](https://github.com/OCA)
- [Odoo Apps Store](https://apps.odoo.com/)

---

**¿Necesitas ayuda?** Contacta a [info@erply.do](mailto:info@erply.do) | Tel: +1 (849) 517-5363licenses/lgpl-3.0)
[![Odoo Version](https://img.shields.io/badge/Odoo-18.0-brightgreen.svg)](https://github.com/odoo/odoo/tree/18.0)

## 📋 Descripción

Este módulo proporciona funcionalidades avanzadas para [DESCRIBIR LA FUNCIONALIDAD ESPECÍFICA].

### Características Principales

- ✅ **Gestión Completa**: Interfaz intuitiva para administrar registros
- ✅ **Workflow Automatizado**: Estados y transiciones controladas
- ✅ **Notificaciones**: Sistema de alertas y recordatorios
- ✅ **Reportes**: Análisis y exportación de datos
- ✅ **Multicompañía**: Soporte completo para múltiples compañías
- ✅ **Internacionalización**: Disponible en múltiples idiomas

## 🚀 Instalación

### Requisitos Previos

- Odoo 18.0 Community o Enterprise
- Python 3.10+
- PostgreSQL 14+

### Dependencias

Este módulo depende de los siguientes módulos base de Odoo:
- `base` - Funcionalidades básicas
- `mail` - Sistema de mensajería
- `web` - Interfaz web

### Pasos de Instalación

1. **Clonar el repositorio**:
   ```bash
   git clone [url-del-repositorio]
   cd addons_custom/addons_custom/prueba_manifest_profesional
   ```

2. **Agregar el módulo al path de addons**:
   - Agregar la ruta en el archivo de configuración de Odoo
   - O copiar el módulo a la carpeta de addons existente

3. **Actualizar la lista de módulos**:
   - Ir a Apps > Actualizar Lista de Apps
   - O ejecutar: `./odoo-bin -u all --stop-after-init`

4. **Instalar el módulo**:
   - Buscar "Addons Custom/Prueba Manifest Profesional" en Apps
   - Hacer clic en "Instalar"

## 📖 Guía de Uso

### Configuración Inicial

1. **Configurar Permisos**:
   - Ir a Configuración > Usuarios y Compañías > Grupos
   - Asignar usuarios a los grupos "Usuario" o "Manager"

2. **Configurar Secuencias**:
   - Las secuencias se crean automáticamente
   - Personalizable en Configuración > Secuencias e Identificadores > Secuencias

### Operaciones Básicas

[AGREGAR DOCUMENTACIÓN ESPECÍFICA DE USO]

## 🧪 Testing

### Ejecutar Tests

```bash
# Tests unitarios del módulo
python3 odoo-bin -d test_db --test-enable --stop-after-init -i addons_custom/prueba_manifest_profesional

# Tests específicos
python3 odoo-bin -d test_db --test-enable --test-tags addons_custom/prueba_manifest_profesional --stop-after-init
```

### Tests Disponibles

- `test_model_creation` - Creación de registros
- `test_state_transitions` - Transiciones de estado
- `test_validations` - Validaciones de campos
- `test_permissions` - Permisos de usuario

## 🐛 Solución de Problemas

### Problemas Comunes

#### Error: "Módulo no encontrado"
- Verificar que el módulo esté en el path de addons
- Actualizar la lista de módulos
- Verificar dependencias

#### Error: "Permiso denegado"
- Verificar que el usuario tenga los grupos correctos
- Revisar reglas de registro (record rules)
- Verificar permisos del modelo

## 📞 Soporte

### Reportar Bugs

1. Ir a [Issues del repositorio]
2. Usar la plantilla de bug report
3. Incluir:
   - Versión de Odoo
   - Pasos para reproducir
   - Logs de error
   - Capturas de pantalla

# Soporte y Mantenimiento

Para cualquier problema, consulta la documentación incluida en el módulo.
Si encuentras errores, revisa los logs de Odoo y los resultados de las pruebas automáticas.
Contacta al equipo de desarrollo de ERPly S.R.L. para soporte avanzado.

## Actualización del módulo

- Realiza una copia de seguridad antes de actualizar.
- Sustituye la carpeta del módulo por la nueva versión y repite el proceso de instalación.
- Ejecuta las pruebas automáticas tras la actualización.

## 🤝 Contribuir

### Proceso de Contribución

1. Fork del repositorio
2. Crear rama para la funcionalidad: `git checkout -b feature/nueva-funcionalidad`
3. Realizar cambios y tests
4. Commit con mensaje descriptivo
5. Push y crear Pull Request

## 📄 Licencia

Este módulo está licenciado bajo LGPL-3.0. Ver archivo [LICENSE](LICENSE) para detalles.


# Guía profesional para desarrollo en Odoo.sh

## Estructura recomendada

```
addons_custom/
└── prueba_manifest_profesional/
    ├── __init__.py
    ├── __manifest__.py
    ├── models/
    ├── views/
    ├── security/
    ├── tests/
    ├── static/
    └── README.md
```

## Instalación en Odoo.sh

1. Conecta tu repositorio de GitHub a Odoo.sh.
2. Haz push a la rama principal o de desarrollo.
3. Odoo.sh instalará dependencias, ejecutará pruebas y desplegará el módulo automáticamente.

## Uso

- Accede al menú "Registros Profesionales" en Odoo.
- Crea y gestiona registros con workflow automatizado.
- Utiliza los botones de acción para cambiar el estado del registro.
- Los permisos y reglas se gestionan por grupos definidos en el módulo.

## Pruebas automáticas

- Las pruebas se ejecutan automáticamente en Odoo.sh al hacer push.
- Incluye casos para creación, validaciones, workflow y permisos.

## Buenas prácticas

- Mantén la documentación y los tests actualizados.
- Usa ramas para desarrollo, staging y producción.
- Configura variables y secretos desde la interfaz de Odoo.sh.

## Soporte y mantenimiento

Para cualquier problema, consulta la documentación incluida en el módulo.
Contacta al equipo de desarrollo de ERPly S.R.L. para soporte avanzado.

## 📚 Recursos Adicionales

- [Documentación Oficial de Odoo](https://www.odoo.com/documentation/18.0/)
- [OCA (Odoo Community Association)](https://github.com/OCA)
- [Odoo Apps Store](https://apps.odoo.com/)

---

**¿Necesitas ayuda?** Contacta a [email@tuempresa.com](mailto:email@tuempresa.com)
