job "install-otel-collector" {
  datacenters = ["dc1"]
  type = "system"  # Questo job viene eseguito su tutti i nodi Windows

  constraint {
    attribute = "${attr.kernel.name}"
    value     = "windows" # vincolato ad essere eseguito solo su nodi Windows
  }
  
  group "otel" {
    count = 1

    task "pwd" {
      driver = "raw_exec" # esecuzione diretta del processo

      config {
        command = "powershell"
        args    = ["pwd"]
      }

      resources {
        cpu    = 200
        memory = 100
      }
    }
    
    task "install-collector" {
      driver = "raw_exec" # esecuzione diretta del processo

      config {
        command = "powershell"
        args = [
          "-ExecutionPolicy", "Bypass",
          "-File", "local/install-otel-collector.ps1"
        ]
      }

      artifact {
        source      = "https://raw.githubusercontent.com/alexkaos87/opentelemetry/refs/heads/main/install-otel-collector.ps1" # sorgente dello script powershell da eseguire localmente
        destination = "local"
      }

      resources {
        cpu    = 500
        memory = 256
      }

      # service {
      #  name = "otel-collector-install"
      # }
    }
  }
}
