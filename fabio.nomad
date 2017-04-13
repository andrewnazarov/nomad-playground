job "fabio" {  
  datacenters = ["dc1"]

  # run on every nomad node
  type = "system"

  update {
    stagger = "5s"
    max_parallel = 1
  }

  group "fabio" {
    task "fabio" {
      driver = "raw_exec"

      config {
        command = "fabio-1.4.2-go1.8.1-linux_amd64"
#        args = ["-proxy.addr=:80", "-ui.addr=:9999"]
      }

      artifact {
        source = "https://github.com/eBay/fabio/releases/download/v1.4.2/fabio-1.4.2-go1.8.1-linux_amd64"

        options {
          checksum = "sha256:d13e503d4f570d1c834dcbe8febd1fcffc474fe1f046dfe1e8bb04914187dabc"
        }
      }

      resources {
        cpu = 20
        memory = 64
        network {
          mbits = 1

          port "lb" {
            static = 9998
          }
          port "ui" {
            static = 9999
          }
        }
      }
    }
  }
}
