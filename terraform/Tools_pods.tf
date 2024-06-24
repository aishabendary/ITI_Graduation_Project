resource "kubernetes_pod" "jenkins" {
  metadata {
    name      = "jenkins"
    namespace = "tools"
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

resource "kubernetes_pod" "nexus" {
  metadata {
    name      = "nexus"
    namespace = "tools"
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