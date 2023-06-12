terraform {
	required_providers {
      	docker = {
        source = "kreuzwerker/docker"
        version = "3.0.1"
}
}
}

provider "docker" {}

resource "docker_image" "webpage" {
        name = "chaitannyaa/webpage:latest"
        keep_locally = false

}

resource "docker_container" "webpage1" {
        image = docker_image.webpage.image_id
        name = "webpage-tf"
        ports {
                internal = 8501
                external = 80
}
}