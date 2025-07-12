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
  host     = var.db_host
  username = "postgres"
  password = ""
  sslmode  = "disable"
}

resource "postgresql_role" "app_user" {
  name     = var.app_user
  password = var.app_password
  login    = true
}

resource "postgresql_database" "app_db" {
  name  = var.app_db
  owner = postgresql_role.app_user.name
} 