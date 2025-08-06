#!/bin/bash
# Script para instalar y validar el módulo Prueba Manifest Profesional en Odoo

echo "Copiando módulo al directorio de addons..."
cp -r ./addons_custom/prueba_manifest_profesional /opt/odoo/addons/

echo "Reiniciando el servidor Odoo..."
sudo systemctl restart odoo

echo "Actualizando lista de aplicaciones..."
# Puedes hacerlo desde la interfaz web o con el siguiente comando si tienes acceso:
# python3 odoo-bin -c /etc/odoo/odoo.conf -u all

echo "Instalando módulo desde la interfaz de Odoo..."
echo "Por favor, accede a Odoo y busca 'Prueba Manifest Profesional' para instalarlo."

echo "Ejecutando pruebas automáticas..."
python3 odoo-bin -d <nombre_base_datos> --test-enable --stop-after-init -i prueba_manifest_profesional

echo "Despliegue y validación completados."
