job "install-otel-collector" {
  datacenters = ["dc1"]
  type = "system"  # Questo job viene eseguito su tutti i nodi Windows

  constraint {
    attribute = "${attr.kernel.name}"
    value     = "windows" # vincolato ad essere eseguito solo su nodi Windows
  }
  
  group "otel" {
    count = 1

    task "install-collector" {
      driver = "raw_exec" # esecuzione diretta del processo

      config {
        command = "powershell"
        args = [
          "-ExecutionPolicy", "Bypass",
          "-File", "C:/ProgramData/Nomad/alloc/install-otel-collector.ps1"
        ]
      }

      artifact {
        source      = "https://github.com/alexkaos87/opentelemetry/blob/main/install-otel-collector.ps1" # sorgente dello script powershell da eseguire localmente
        destination = "C:/ProgramData/Nomad/alloc/"
      }

      resources {
        cpu    = 500
        memory = 256
      }

      service {
        name = "otel-collector-install"
      }
    }
  }
}
