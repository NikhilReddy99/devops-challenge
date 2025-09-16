package kubernetes.admission

deny[msg] {
  input.kind.kind == "Pod"
  some i
  container := input.request.object.spec.containers[i]
  container.securityContext.allowPrivilegeEscalation == true
  msg = sprintf("Container '%s' allows privilege escalation", [container.name])
}
