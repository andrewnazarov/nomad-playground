job "tomcat" {
  
  region = "global"
  datacenters = ["dc1"]

  update {
    stagger = "30s"
    max_parallel = 1
  }

  group "app" {
  
    count = 1
    
    task "tomcat" {
      driver = "docker"
      config {
        image = "tomcat:8.0"
        volumes = [
          "/vagrant/app/:/usr/local/tomcat/webapps/"
        ]
        port_map = {
          http = 8080
        }
      }
     
      service {
        name = "tomcat"
        tags = ["app","urlprefix-tomcat.service.consul:9999/sample"]
        port = "http"
        check {
          type = "tcp"
          interval = "10s"
          timeout = "2s"
          }
      }
     
      resources {
        cpu = 500
        memory = 200
        network {
          mbits = 100
          port "http" {}
        }
      }
    }
  }
}
