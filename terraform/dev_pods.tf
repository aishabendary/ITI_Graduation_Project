resource "kubernetes_pod" "mysql" {
  metadata {
    name      = "mysql"
    namespace = kubernetes_namespace.dev.metadata[0].name
  }
  spec {
    container {
      image = "mysql:5.7"
      name  = "mysql"
      env {
        name  = "MYSQL_ROOT_PASSWORD"
        value = "12345"
      }
      env {
        name  = "MYSQL_DATABASE"
        value = "mydatabase"
      }
      port {
        container_port = 3306
      }
    }
  }
}