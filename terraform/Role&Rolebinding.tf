# Create the Role with specified rules
resource "kubernetes_role" "jenkins_role" {
  metadata {
    name      = "jenkins-role"
    namespace = var.ns-names[1]
  }

  rule {
    api_groups = [""]
    resources  = ["pods", "pods/log", "services", "deployments", "configmaps", "secrets"]
    verbs      = ["get", "list", "create", "update", "delete"]
  }
}

# Create the RoleBinding
resource "kubernetes_role_binding" "jenkins_role_binding" {
  metadata {
    name      = "jenkins-role-binding"
    namespace = "dev"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.jenkins_role.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.jenkins_admin.metadata[0].name
    namespace = "tools"
  }
}
