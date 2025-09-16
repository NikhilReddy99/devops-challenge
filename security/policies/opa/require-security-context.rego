package kubernetes.admission

violation[{"msg": msg, "patch": patch}] {
  input.kind.kind == "Pod"
  pod := input.request.object

  not pod_has_run_as_non_root(pod)
  msg = "Pod must set securityContext.runAsNonRoot or containers must set runAsNonRoot"
  patch = {"op": "add", "path": "/spec/securityContext/runAsNonRoot", "value": true}
}

pod_has_run_as_non_root(pod) {
  pod.spec.securityContext.runAsNonRoot == true
}

violation2[msg] {
  input.kind.kind == "Pod"
  some i
  c := input.request.object.spec.containers[i]
  not c.securityContext.readOnlyRootFilesystem
  msg = sprintf("Container %s must set securityContext.readOnlyRootFilesystem=true", [c.name])
}
