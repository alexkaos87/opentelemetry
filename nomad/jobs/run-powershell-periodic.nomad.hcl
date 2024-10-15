job "run-powershell-extra" {
  datacenters = ["*"]

  type = "batch"

  constraint {
    attribute = "${attr.kernel.name}"
    value     = "windows"
  }

  periodic {
    crons            = [ "*/30 * * * * *" ]
    prohibit_overlap = true
  }

  group "windows" {
    count = 1

    task "1-gethostinfo" {
      driver = "raw_exec"

      config {
        command = "powershell"
        args    = ["get-host"]
      }
      
      resources {
        memory = 200
        cpu    = 100
      }
    }

    task "2-print now date-time" {
      driver = "raw_exec"

      config {
        command = "C:\\Windows\\System32\\cmd.exe"
        args    = ["/c", "echo", "%date%", "%time%"]
      }
      
      resources {
        memory = 100
        cpu    = 100
      }
    }
    
    task "3-sleepbecauseisnice" {
      driver = "raw_exec"

      config {
        command = "powershell"
        args    = ["start-sleep -seconds 30"]
      }
      
      resources {
        memory = 100
        cpu    = 100
      }
    }
  }
}