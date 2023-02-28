terraform {
	required_providers {
      	docker = {
        source = "kreuzwerker/docker"
        version = "~> 2.21.0"
}
}
}

provider "docker" {}

resource "docker_image" "webpage" {
        name = "chaitannyaa/webpage:latest"
        keep_locally = false

}

resource "docker_container" "webpage1" {
        image = docker_image.webpage.latest
        name = "webpage-tf"
        ports {
                internal = 8501
                external = 80
}
}