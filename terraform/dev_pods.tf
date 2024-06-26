
resource "kubernetes_pod" "nodejs-app" {
  metadata {
    name      = "nodejs-app"
    namespace = kubernetes_namespace.dev.metadata[0].name
  }
  spec {
    container {
      image = "node:14"
      name  = "nodejs-app"
      port {
        container_port = 5000
      }
      env {
        name  = "MYSQL_HOST"
        value = "mysql"
      }
      env {
        name  = "MYSQL_USER"
        value = "root"
      }
      env {
        name  = "MYSQL_PASSWORD"
        value = "12345"
      }
      env {
        name  = "MYSQL_DB"
        value = "mydatabase"
      }
    }
  }
}

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