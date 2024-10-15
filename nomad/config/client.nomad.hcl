data_dir  = "C:\\ProgramData\\Nomad\\Client"
log_level    = "DEBUG"
enable_debug = true

name = "little-boy"

ports {
  http = 4656
  rpc  = 4657
  serf = 4658
}

client {
  enabled = true
  client_max_port = 15000

  servers = ["127.0.0.1:4647"]
    
  options = {
    "driver.raw_exec.enable" = "1"
    "driver.denylist" = "docker"
  }
}