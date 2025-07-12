terraform {
  required_version = ">= 1.0"
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }
}

# Variables for server connection
variable "server_host" {
  description = "Server host"
  type        = string
}

variable "postgresql_username" {
  description = "PostgreSQL username"
  type        = string
}

variable "postgresql_password" {
  description = "PostgreSQL password"
  type        = string
  sensitive   = true
}

variable "postgresql_port" {
  description = "PostgreSQL port"
  type        = string
  default     = "5432"
}

variable "postgresql_database" {
  description = "PostgreSQL database name"
  type        = string
}

variable "postgresql_version" {
  description = "PostgreSQL version to install"
  type        = string
  default     = "17"
}

# Local file for storing state information
resource "null_resource" "postgresql_check" {
  triggers = {
    server_host = var.server_host
    postgresql_version = var.postgresql_version
  }

  provisioner "local-exec" {
    command = <<-EOT
      # Check if PostgreSQL is installed
      if ssh -o StrictHostKeyChecking=no -o ConnectTimeout=10 root@${var.server_host} "which psql > /dev/null 2>&1"; then
        echo "PostgreSQL is installed"
        
        # Check PostgreSQL version
        VERSION=$(ssh -o StrictHostKeyChecking=no root@${var.server_host} "psql --version | grep -oE '[0-9]+\.[0-9]+' | head -1")
        echo "Current PostgreSQL version: $VERSION"
        
        if [ "$VERSION" = "${var.postgresql_version}" ]; then
          echo "PostgreSQL version ${var.postgresql_version} is already installed"
          exit 0
        else
          echo "PostgreSQL version mismatch. Current: $VERSION, Required: ${var.postgresql_version}"
          exit 1
        fi
      else
        echo "PostgreSQL is not installed"
        exit 2
      fi
    EOT
  }
}

# Install PostgreSQL 17
resource "null_resource" "postgresql_install" {
  depends_on = [null_resource.postgresql_check]
  
  triggers = {
    server_host = var.server_host
    postgresql_version = var.postgresql_version
  }

  provisioner "local-exec" {
    command = <<-EOT
      # Install PostgreSQL 17 on Ubuntu/Debian
      ssh -o StrictHostKeyChecking=no root@${var.server_host} << 'SSH_SCRIPT'
        # Update packages
        apt update
        
        # Install PostgreSQL repository
        apt install -y wget ca-certificates
        wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
        echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list
        
        # Update package list
        apt update
        
        # Install PostgreSQL 17
        apt install -y postgresql-${var.postgresql_version} postgresql-contrib-${var.postgresql_version}
        
        # Start and enable autostart
        systemctl start postgresql
        systemctl enable postgresql
        
        # Configure PostgreSQL for external connections
        sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /etc/postgresql/${var.postgresql_version}/main/postgresql.conf
        sed -i "s/#port = 5432/port = ${var.postgresql_port}/" /etc/postgresql/${var.postgresql_version}/main/postgresql.conf
        
        # Configure pg_hba.conf for connections
        echo "host    all             all             0.0.0.0/0               md5" >> /etc/postgresql/${var.postgresql_version}/main/pg_hba.conf
        
        # Restart PostgreSQL
        systemctl restart postgresql
        
        # Create user and database
        sudo -u postgres psql -c "CREATE USER ${var.postgresql_username} WITH PASSWORD '${var.postgresql_password}';"
        sudo -u postgres psql -c "CREATE DATABASE ${var.postgresql_database} OWNER ${var.postgresql_username};"
        sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE ${var.postgresql_database} TO ${var.postgresql_username};"
        
        echo "PostgreSQL ${var.postgresql_version} installed and configured successfully"
      SSH_SCRIPT
    EOT
  }
}

# Upgrade PostgreSQL to version 17
resource "null_resource" "postgresql_upgrade" {
  depends_on = [null_resource.postgresql_check]
  
  triggers = {
    server_host = var.server_host
    postgresql_version = var.postgresql_version
  }

  provisioner "local-exec" {
    command = <<-EOT
      # Upgrade PostgreSQL to version 17
      ssh -o StrictHostKeyChecking=no root@${var.server_host} << 'SSH_SCRIPT'
        # Stop PostgreSQL
        systemctl stop postgresql
        
        # Create data backup
        pg_dumpall > /tmp/postgresql_backup.sql
        
        # Remove old PostgreSQL version
        apt remove -y postgresql*
        apt autoremove -y
        
        # Install PostgreSQL repository
        apt install -y wget ca-certificates
        wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
        echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list
        
        # Update package list
        apt update
        
        # Install PostgreSQL 17
        apt install -y postgresql-${var.postgresql_version} postgresql-contrib-${var.postgresql_version}
        
        # Restore data
        psql -f /tmp/postgresql_backup.sql postgres
        
        # Start and enable autostart
        systemctl start postgresql
        systemctl enable postgresql
        
        # Configure PostgreSQL for external connections
        sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /etc/postgresql/${var.postgresql_version}/main/postgresql.conf
        sed -i "s/#port = 5432/port = ${var.postgresql_port}/" /etc/postgresql/${var.postgresql_version}/main/postgresql.conf
        
        # Configure pg_hba.conf for connections
        echo "host    all             all             0.0.0.0/0               md5" >> /etc/postgresql/${var.postgresql_version}/main/pg_hba.conf
        
        # Restart PostgreSQL
        systemctl restart postgresql
        
        echo "PostgreSQL upgraded to version ${var.postgresql_version} successfully"
      SSH_SCRIPT
    EOT
  }
} 