job "microbot" {
  region = "global"

  datacenters = ["dc1"]

  # Rolling updates
  update {
    stagger = "10s"
    max_parallel = 5
  }

  group "web" {
    count = 2

    task "microbot" {
      driver = "docker"
      config {
        image = "dontrebootme/microbot:v1"
        port_map {
          http = 80
        }
      }
      service {
        port = "http"
        name = "microbot"
        tags = ["urlprefix-/","urlprefix-microbot.service.consul/"]
        check {
          type = "http"
          path = "/"
          interval = "10s"
          timeout = "2s"
        }
      }
      resources {
        cpu = 100
        memory = 32
        network {
          mbits = 100
          port "http" {}
        }
      }
    }
  }
}
