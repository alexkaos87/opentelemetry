job "otel-collector-windows" {
  datacenters = ["dc1"]
  type = "system" # Questo job viene eseguito su tutti i nodi 

  constraint {
    attribute = "${attr.kernel.name}"
    value     = "windows" # vincolato ad essere eseguito solo su nodi Windows
  }

  group "otel" {
    count = 1

    task "collector" {
      driver = "raw_exec" # esecuzione diretta del processo

      config {
        command = "C:/opentelemetry/otelcol.exe"
        args = ["--config=C:/opentelemetry/config.yaml"]
      }

      resources {
        cpu    = 500
        memory = 512
      }

      service {
        name = "otel-collector-windows"
        port = "otel_http"
        check {
          type     = "http"
          path     = "/healthz"
          interval = "10s"
          timeout  = "2s"
        }
      }

      env {
        OTEL_CONFIG_FILE = "C:/opentelemetry/config.yaml"
      }

      template {
        data = <<-EOF
        receivers:
          otlp:
            protocols:
              http:
              grpc:

        exporters:
          logging:

        service:
          pipelines:
            traces:
              receivers: [otlp]
              exporters: [logging]
        EOF
        destination = "C:/opentelemetry/config.yaml"
      }
    }

    network {
      port "otel_http" {
        static = 55681
      }
    }
  }
}
