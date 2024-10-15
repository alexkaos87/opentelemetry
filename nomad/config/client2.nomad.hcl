data_dir  = "C:\\ProgramData\\Nomad\\Client2"
log_level    = "DEBUG"
enable_debug = true

name = "old-boy"

ports {
  http = 4666
  rpc  = 4667
  serf = 4668
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