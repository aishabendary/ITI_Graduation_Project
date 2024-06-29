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

resource "kubernetes_secret" "nodejs-app_credentials" {
  metadata {
    name      = "nodejs-app-credentials"
    namespace = kubernetes_namespace.dev.metadata[0].name
  }

  data = {
    HOST      = "mysql"
    USERNAME  = "sql"
    PASSWORD  = "123"
    DATABASE  = "mydatabase"
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
        name  = "MYSQL_ROOT_PASSWORD"
        value = "12345"
      }
      env {
        name  = "MYSQL_DATABASE"
        value = "mydatabase"
      }
      env {
        name  = "MYSQL_USER"
        value = "sql"
      }
      env {
        name  = "MYSQL_PASSWORD"
        value = "123"
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