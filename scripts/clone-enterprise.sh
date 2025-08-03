#!/bin/bash
set -e

echo "Cloning Odoo Enterprise 18..."

# Check if Enterprise is already cloned
if [ -d "/opt/odoo-enterprise" ]; then
    echo "Odoo Enterprise already exists at /opt/odoo-enterprise"
    echo "To update, run: cd /opt/odoo-enterprise && git pull"
    exit 0
fi

# Clone Odoo Enterprise 18
echo "Cloning Odoo Enterprise from GitHub..."
sudo git clone https://github.com/odoo/enterprise.git --depth 1 --branch 18.0 /opt/odoo-enterprise

# Set proper ownership
sudo chown -R $(whoami):$(whoami) /opt/odoo-enterprise

echo "✅ Odoo Enterprise 18 cloned successfully!"
echo "Enterprise modules are now available in your Odoo instance."
echo ""
echo "Note: You'll need a valid Odoo Enterprise license to use these modules in production."
echo "For development purposes, you can use them without a license."
echo ""
echo "Restart Odoo to see the Enterprise modules in your Apps list."
