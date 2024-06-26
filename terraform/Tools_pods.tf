resource "kubernetes_pod" "jenkins" {
  metadata {
    name      = "jenkins"
    namespace = kubernetes_namespace.tools.metadata[0].name
    labels = {
      app = "jenkins"
    }
  }
  spec {
    container {
      image = "jenkins/jenkins:lts"
      name  = "jenkins"
      port {
        container_port = 8080
      }
    }
  }
}

resource "kubernetes_service" "jenkins" {
  metadata {
    name      = "jenkins-service"
    namespace = kubernetes_namespace.tools.metadata[0].name
  }
  spec {
    selector = {
      app = "jenkins"
    }
    port {
      protocol    = "TCP"
      port        = 8080
      target_port = 8080
    }
    type = "NodePort"
  }
}

resource "kubernetes_pod" "nexus" {
  metadata {
    name      = "nexus"
    namespace = kubernetes_namespace.tools.metadata[0].name
    labels = {
      app = "nexus"
    }
  }
  spec {
    container {
      image = "sonatype/nexus3"
      name  = "nexus"
      port {
        container_port = 8081
      }
    }
  }
}

resource "kubernetes_service" "nexus" {
  metadata {
    name      = "nexus-service"
    namespace = kubernetes_namespace.tools.metadata[0].name
  }
  spec {
    selector = {
      app = "nexus"
    }
    port {
      protocol    = "TCP"
      port        = 8081
      target_port = 8081
    }
    type = "NodePort"
  }
}