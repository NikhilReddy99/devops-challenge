package kubernetes.admission

deny[msg] {
  input.kind.kind == "Pod"
  c := input.spec.containers[_]
  c.securityContext.allowPrivilegeEscalation == true
  msg = sprintf("Container %s must not allow privilege escalation", [c.name])
}