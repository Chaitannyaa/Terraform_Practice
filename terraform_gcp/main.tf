provider "google" {
     credentials = file("account_key.json")
     project     = "terraform-gcp-379210"
     region      = "europe-west4"
     zone        = "europe-west4-a"
}

resource "google_compute_instance" "default" {
  name         = "debian"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "debian-10-buster-v20221206"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
}
