########################################
# Module: minikube
# Purpose: start/stop minikube locally via local-exec (cross-platform)
########################################

resource "null_resource" "start_minikube" {
  # Use local-exec to start minikube. We pick the appropriate interpreter per OS.
  provisioner "local-exec" {
    command     = var.start_command
    interpreter = var.interpreter
  }

  # Simple trigger to allow re-run if config changes
  triggers = {
    minikube_args_hash = sha256(join("", [tostring(var.cpus), tostring(var.memory), tostring(var.disk_size)]))
  }
}

resource "null_resource" "stop_minikube" {
  provisioner "local-exec" {
    when        = destroy
    command     = var.stop_command
    interpreter = var.interpreter
  }
}

output "minikube_started" {
  value = true
  depends_on = [null_resource.start_minikube]
}
