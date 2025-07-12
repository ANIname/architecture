terraform {
  required_version = ">= 1.0"
  required_providers {
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = ">=1.13.0"
    }
  }
}

provider "postgresql" {
  host            = var.db_host
  port            = 5432
  database        = "postgres"
  username        = var.db_admin_user
  password        = var.db_admin_password
  sslmode         = "require"
  connect_timeout = 15
}

resource "postgresql_role" "app_user" {
  name     = var.app_user
  password = var.app_password
  login    = true
}

resource "postgresql_database" "app_db" {
  name   = var.app_db
  owner  = postgresql_role.app_user.name
  encoding = "UTF8"
  lc_collate = "en_US.UTF-8"
  lc_ctype   = "en_US.UTF-8"
  template   = "template0"
  allow_connections = true
} 