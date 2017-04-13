# ----------- Server Configuration -----------
# Increase log verbosity
log_level = "DEBUG"

# Setup data dir
data_dir = "/var/lib/nomad"

datacenter = "dc1"

# Advertise an accessible IP address so the server is reachable by other servers
# and clients. The IPs can be materialized by Terraform or be replaced by an
# init script.
advertise {
    http = "10.100.200.11:4646"
    rpc = "10.100.200.11:4647"
    serf = "10.100.200.11:4648"
}

server {
  # Enable server mode for the local agent
  enabled = true

  # Number of server nodes to wait for before
  # bootstrapping, depending on cluster size
  bootstrap_expect = 1
}
