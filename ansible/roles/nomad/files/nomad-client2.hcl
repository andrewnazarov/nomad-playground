# ----------- Client Configuration -----------
# Increase log verbosity
log_level = "DEBUG"

# Setup data dir
data_dir = "/var/lib/nomad"

# Datacenter to register the client
datacenter = "dc1"

# Advertise an accessible IP address so the server is reachable by other servers
# and clients. The IPs can be materialized by Terraform or be replaced by an
# init script.
advertise {
    http = "10.100.200.102:4646"
    rpc = "10.100.200.102:4647"
    serf = "10.100.200.102:4648"
}

client {
  # Enable client mode for the local agent
  enabled = true
  options = {
    "driver.raw_exec.enable" = "1"
  }
  # Reserve a portion of the nodes resources
  # from being used by Nomad when placing tasks.
  # For example:
  # reserved {
  #     cpu = 500 # MHz
  #     memory = 512 # MB
  #     disk = 1024 # MB
  #     reserved_ports = "22,80,8500-8600"
  # }
}
