# Create the ServiceAccount
resource "kubernetes_service_account" "jenkins_admin" {
  metadata {
    name      = "jenkins-admin"
    namespace = "tools"
  }
}