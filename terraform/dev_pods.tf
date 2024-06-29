resource "kubernetes_service" "nodejs-app" {
  metadata {
    name      = "nodejs-app-service"
    namespace = kubernetes_namespace.dev.metadata[0].name
    labels = {
      app = "node"
    }
  }

  spec {
    selector = {
      app = "node"
    }

    port {
      port        = 3000
      target_port = 3000
    }

    type = "LoadBalancer"
  }
}

resource "kubernetes_secret" "mysql_credentials" {
  metadata {
    name      = "mysql-credentials"
    namespace = kubernetes_namespace.dev.metadata[0].name
  }

  data = {
    MYSQL_ROOT_PASSWORD = "12345"
    MYSQL_DATABASE      = "mydatabase"
    MYSQL_USER          = "sql"
    MYSQL_PASSWORD      = "123"
  }

  type = "Opaque"
}


resource "kubernetes_pod" "mysql" {
  metadata {
    name      = "mysql"
    namespace = kubernetes_namespace.dev.metadata[0].name
    labels = {
      app = "mysql"
    }
  }

  spec {
    container {
      image = "mysql:5.7"
      name  = "mysql"
      
      env {
        name = "MYSQL_ROOT_PASSWORD"
        value_from {
          secret_key_ref {
            name = kubernetes_secret.mysql_credentials.metadata[0].name
            key  = "MYSQL_ROOT_PASSWORD"
          }
        }
      }
      
      env {
        name = "MYSQL_DATABASE"
        value_from {
          secret_key_ref {
            name = kubernetes_secret.mysql_credentials.metadata[0].name
            key  = "MYSQL_DATABASE"
          }
        }
      }
      
      env {
        name = "MYSQL_USER"
        value_from {
          secret_key_ref {
            name = kubernetes_secret.mysql_credentials.metadata[0].name
            key  = "MYSQL_USER"
          }
        }
      }
      
      env {
        name = "MYSQL_PASSWORD"
        value_from {
          secret_key_ref {
            name = kubernetes_secret.mysql_credentials.metadata[0].name
            key  = "MYSQL_PASSWORD"
          }
        }
      }
      
      port {
        container_port = 3306
      }
    }
  }
}

resource "kubernetes_service" "mysql" {
  metadata {
    name      = "mysql"
    namespace = kubernetes_namespace.dev.metadata[0].name
  }

  spec {
    selector = {
      app = "mysql"
    }

    port {
      port        = 3306
      target_port = 3306
    }

    type = "ClusterIP"
  }
}