package kubernetes.admission

deny[msg] {
  input.kind.kind == "Pod"
  some i
  vol := input.request.object.spec.volumes[i]
  vol.hostPath
  msg = sprintf("hostPath volume '%v' is not allowed", [vol])
}
