job "cadvisor" {
  region = "global"

  datacenters = ["dc1"]

  type = "system"

  group "cadvisor" {
    task "cadvisor" {
      driver = "docker"
      config {
        image = "google/cadvisor"
        port_map {
          cadvisor = 8080
        }
        volumes = [
          "/:/rootfs:ro",
          "/var/run:/var/run:rw",
          "/sys:/sys:ro",
          "/var/lib/docker/:/var/lib/docker:ro"
        ] 
      }
      service {
        name = "cadvisor"
        port = "cadvisor"
        tags = ["mon","urlprefix-cadvisor.service.consul:9999/"]
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
          port "cadvisor" {
          }
        }
      }
    }
  }
}
