#!/bin/bash
set -e

echo "Setting up Odoo 18 development environment..."

# Update system packages
sudo apt-get update
sudo apt-get install -y \
    python3-dev \
    python3-pip \
    python3-venv \
    build-essential \
    libxml2-dev \
    libxslt1-dev \
    libevent-dev \
    libsasl2-dev \
    libldap2-dev \
    libpq-dev \
    libjpeg-dev \
    libpng-dev \
    libfreetype6-dev \
    zlib1g-dev \
    libwebp-dev \
    node-less \
    nodejs \
    npm \
    git \
    wget \
    curl

# Install wkhtmltopdf
echo "Installing wkhtmltopdf..."
wget -q https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-3/wkhtmltox_0.12.6.1-3.jammy_amd64.deb
sudo dpkg -i wkhtmltox_0.12.6.1-3.jammy_amd64.deb || sudo apt-get install -f -y
rm wkhtmltox_0.12.6.1-3.jammy_amd64.deb

# Clone Odoo 18 if it doesn't exist
if [ ! -d "/workspaces/proevedor_cardnet/odoo" ]; then
    echo "Cloning Odoo 18..."
    git clone https://github.com/odoo/odoo.git --depth 1 --branch 18.0 /workspaces/proevedor_cardnet/odoo
fi

# Clone Odoo Enterprise 18 if it doesn't exist
if [ ! -d "/workspaces/proevedor_cardnet/enterprise" ]; then
    echo "Cloning Odoo Enterprise 18..."
    git clone https://github.com/odoo/enterprise.git --depth 1 --branch 18.0 /workspaces/proevedor_cardnet/enterprise
fi

# Install Python dependencies
echo "Installing Python dependencies..."
pip3 install -r /workspaces/proevedor_cardnet/odoo/requirements.txt
pip3 install -r /workspaces/proevedor_cardnet/requirements.txt

# Create necessary directories
mkdir -p /workspaces/proevedor_cardnet/addons_custom
mkdir -p /workspaces/proevedor_cardnet/config
mkdir -p /workspaces/proevedor_cardnet/logs

# Create Odoo configuration file
cat > /workspaces/proevedor_cardnet/config/odoo.conf << EOF
[options]
addons_path = /workspaces/proevedor_cardnet/odoo/addons,/workspaces/proevedor_cardnet/enterprise,/workspaces/proevedor_cardnet/addons_custom
admin_passwd = admin
db_host = localhost
db_port = 5432
db_user = odoo
db_password = odoo
db_name = dev
logfile = /workspaces/proevedor_cardnet/logs/odoo.log
log_level = info
xmlrpc_port = 8069
longpolling_port = 8072
EOF

# Wait for PostgreSQL to be ready
echo "Waiting for PostgreSQL to be ready..."
until pg_isready -h localhost -p 5432 -U odoo; do
    echo "Waiting for PostgreSQL..."
    sleep 2
done

echo "Odoo 18 development environment setup complete!"
echo "You can start Odoo with: ./scripts/start.sh"
