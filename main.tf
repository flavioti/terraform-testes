provider "google" {
  credentials = file("service-account.json")
  project     = "treinamento-254613"
  region      = "us-central1"
  zone        = "us-central1-c"
}

resource "google_compute_network" "vpc_network" {
  description             = "Nova VPC usada para os testes com Terraform"
  project                 = "treinamento-254613"
  name                    = "terraform-network"
  auto_create_subnetworks = true
}

resource "google_compute_instance" "vm_instance" {
  description  = "VM para testar criação automatica com Terraform"
  project      = "treinamento-254613"
  name         = "terraform_instance"
  machine_type = "f1-micro"

  boot_disk {
    auto_delete = true
    device_name = "boot-disk-terraform-teste"
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "terraform-network"
    access_config {
    }
  }

  scheduling {
    automatic_restart = true
    preemptible       = true
  }

}
