package main

deny[msg] {
  input.kind == "Pod"
  some i
  input.spec.volumes[i].hostPath
  msg = "hostPath is disallowed"
}

deny[msg] {
  input.kind == "Deployment"
  not input.spec.template.spec.containers[_].securityContext.runAsNonRoot
  msg = "Containers must set runAsNonRoot"
}
