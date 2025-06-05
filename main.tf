terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.142.0"
    }
  }
}

variable "folder_id" {
  description = "Yandex Cloud folder ID"
  type        = string
  default     = "b1g25o2paqivo7ssujha"
}

variable "vpc_cidr" {}

variable "network_name" {
  description = "VPC network name"
  type        = string
}

variable "subnet_name" {
  description = "VPC subnet name"
  type        = string
}

resource "yandex_vpc_network" "this" {
  name      = var.network_name
  folder_id = var.folder_id
}

resource "yandex_vpc_subnet" "this" {
  name           = var.subnet_name
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.this.id
  v4_cidr_blocks = [var.vpc_cidr]
  folder_id      = var.folder_id
}

output "network_id" {
  value = yandex_vpc_network.this.id
}

output "subnet_id" {
  value = yandex_vpc_subnet.this.id
}
