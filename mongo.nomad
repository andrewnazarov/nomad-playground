job "mongo" {
        datacenters = ["dc1"]
        type = "service"


        update {
           stagger = "10s" 
           max_parallel = 1
        }
 

        group "db_m" {
           count = 1
           restart {
             attempts = 10
             interval = "5m"
             delay = "25s"
             mode = "delay"
           }

         ephemeral_disk {
             size = 300
          }

         task "mongo" {
             driver = "docker"

             config {
               image = "mongo"
               port_map {
                    db = 27017
             }
         }

          resources {
                  cpu = 500 # 500 MHz
                  memory = 256 # 256MB
         network {
                  mbits = 10
                  port "db_m" {}
           }
    }

            service {
                 name = "mongodb"
                 tags = ["db_m"]
                 port = "db_m"
                 check {
                      type = "tcp"
                      interval = "10s"
                      timeout = "4s"
             }
       }


    }
  }
}
