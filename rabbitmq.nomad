# There can only be a single job definition per file.
# Create a job with ID and Name 'queue'
job "queue" {

  # Specify the datacenters within the region this job can run in.
  datacenters = ["dc1"]

  # Service type jobs optimize for long-lived services. This is
  # the default but we can change to batch for short-lived tasks.
  type = "service"

  # Configure the job to do rolling updates
  update {
    # Stagger updates every 10 seconds
    stagger = "10s"

    # Update a single task at a time
    max_parallel = 1
  }

  # Create a 'broker' group. Each task in the group will be
  # scheduled onto the same machine.
  group "broker" {
    # Control the number of instances of this group.
    # Defaults to 1
    # count = 1

    # Configure the restart policy for the task group. If not provided, a
    # default is used based on the job type.
    restart {
      # The number of attempts to run the job within the specified interval.
      attempts = 10
      interval = "5m"

      # A delay between a task failing and a restart occurring.
      delay = "25s"

      # Mode controls what happens when a task has restarted "attempts"
      # times within the interval. "delay" mode delays the next restart
      # till the next interval. "fail" mode does not restart the task if
      # "attempts" has been hit within the interval.
      mode = "delay"
    }
    # Define a task to run
    task "rabbitmq" {
      # Use Docker to run the task.
      driver = "docker"

      # Configure Docker driver with the image
      config {
        image = "rabbitmq:management"
        port_map {
          amqp = 5672
          http = 15672
        }
      }

      service {
        name = "rabbitmq"
        tags = ["app", "rabbitmq"]
        port = "amqp"
        check {
	  port = "amqp"
          type = "tcp"
          interval = "10s"
          timeout = "2s"
        }
      }
      service {
        name = "rabbitmq-management"
        tags = ["app", "rabbitmq", "ui"]
        port = "http"
        check {
          port = "http"
          type = "tcp"
          interval = "10s"
          timeout = "2s"
        }
      }
      # We must specify the resources required for
      # this task to ensure it runs on a machine with
      # enough capacity.
      resources {
        cpu = 500 # 500 MHz
        memory = 256 # 256MB
        network {
          mbits = 10
          port "amqp" {}
	  port "http" {}
        }
      }
    }
  }
}
