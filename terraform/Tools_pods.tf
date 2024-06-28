
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
        container_port = 50000
      }
      volume_mount {
        mount_path = "/var/jenkins_home"
        name       = "jenkins-storage"
      }
    }
    volume {
      name = "jenkins-storage"
      persistent_volume_claim {
        claim_name = kubernetes_persistent_volume_claim.jenkins_pvc.metadata[0].name
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
      port        = 50000
      target_port = 8080
    }
    type = "LoadBalancer"
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
      volume_mount {
        mount_path = "/nexus-data"
        name       = "nexus-storage"
      }
    }
    volume {
      name = "nexus-storage"
      persistent_volume_claim {
        claim_name = kubernetes_persistent_volume_claim.nexus_pvc.metadata[0].name
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
      target_port = 8085
    }
    type = "LoadBalancer"
  }
}