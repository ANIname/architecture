terraform {
  required_version = ">= 1.0"
  
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }
}

# Variables
variable "server_host" {
  description = "Server hostname or IP address"
  type        = string
}

variable "server_username" {
  description = "SSH username"
  type        = string
}

variable "server_password" {
  description = "SSH password"
  type        = string
  sensitive   = true
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

variable "postgresql_database" {
  description = "PostgreSQL database name"
  type        = string
}

# Data source to get current timestamp
data "null_data_source" "timestamp" {
  inputs = {
    timestamp = timestamp()
  }
}

# Resource to install PostgreSQL 17
resource "null_resource" "install_postgresql" {
  triggers = {
    timestamp = data.null_data_source.timestamp.outputs.timestamp
  }

  connection {
    type     = "ssh"
    host     = var.server_host
    user     = var.server_username
    password = var.server_password
    port     = 22
  }

  provisioner "remote-exec" {
    inline = [
      "echo '📦 Installing PostgreSQL 17...'",
      "sudo apt update",
      "sudo apt install -y wget gnupg2 lsb-release",
      "wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -",
      "echo 'deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main' | sudo tee /etc/apt/sources.list.d/pgdg.list",
      "sudo apt update",
      "sudo apt install -y postgresql-17 postgresql-contrib-17",
      "sudo systemctl start postgresql",
      "sudo systemctl enable postgresql",
      "echo '✅ PostgreSQL 17 installation completed'"
    ]
  }
}

# Resource to configure PostgreSQL
resource "null_resource" "configure_postgresql" {
  depends_on = [null_resource.install_postgresql]

  triggers = {
    timestamp = data.null_data_source.timestamp.outputs.timestamp
  }

  connection {
    type     = "ssh"
    host     = var.server_host
    user     = var.server_username
    password = var.server_password
    port     = 22
  }

  provisioner "remote-exec" {
    inline = [
      "echo '🔧 Configuring PostgreSQL...'",
      "sudo -u postgres psql -c \"CREATE USER ${var.postgresql_username} WITH PASSWORD '${var.postgresql_password}' SUPERUSER;\" 2>/dev/null || true",
      "sudo -u postgres psql -c \"CREATE DATABASE ${var.postgresql_database};\" 2>/dev/null || true",
      "sudo -u postgres psql -c \"GRANT ALL PRIVILEGES ON DATABASE ${var.postgresql_database} TO ${var.postgresql_username};\"",
      "echo 'local   all             postgres                                peer' | sudo tee /etc/postgresql/17/main/pg_hba.conf",
      "echo 'local   all             all                                     md5' | sudo tee -a /etc/postgresql/17/main/pg_hba.conf",
      "echo 'host    all             all             127.0.0.1/32            md5' | sudo tee -a /etc/postgresql/17/main/pg_hba.conf",
      "echo 'host    all             all             ::1/128                 md5' | sudo tee -a /etc/postgresql/17/main/pg_hba.conf",
      "echo 'host    all             all             0.0.0.0/0               md5' | sudo tee -a /etc/postgresql/17/main/pg_hba.conf",
      "sudo sed -i \"s/#listen_addresses = 'localhost'/listen_addresses = '*'/\" /etc/postgresql/17/main/postgresql.conf",
      "sudo systemctl restart postgresql",
      "echo '✅ PostgreSQL configuration completed'"
    ]
  }
}

# Resource to test PostgreSQL connection
resource "null_resource" "test_postgresql" {
  depends_on = [null_resource.configure_postgresql]

  triggers = {
    timestamp = data.null_data_source.timestamp.outputs.timestamp
  }

  connection {
    type     = "ssh"
    host     = var.server_host
    user     = var.server_username
    password = var.server_password
    port     = 22
  }

  provisioner "remote-exec" {
    inline = [
      "echo '🔍 Testing PostgreSQL connection...'",
      "sleep 5",
      "export PGPASSWORD='${var.postgresql_password}'",
      "psql -h localhost -U ${var.postgresql_username} -d ${var.postgresql_database} -c 'SELECT version();'",
      "echo '✅ PostgreSQL connection test successful'"
    ]
  }
} 