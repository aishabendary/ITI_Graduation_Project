

resource "kubernetes_persistent_volume" "jenkins_pv" {
  metadata {
    name = "jenkins-pv"
  }
  spec {
    capacity = {
      storage = "10Gi"
    }
    access_modes = ["ReadWriteOnce"]
    persistent_volume_source {
      host_path {
        path = "/mnt/data/jenkins"
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "jenkins_pvc" {
  metadata {
    name      = "jenkins-pvc"
    namespace = kubernetes_namespace.tools.metadata[0].name
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "10Gi"
      }
    }
  }
}

resource "kubernetes_persistent_volume" "nexus_pv" {
  metadata {
    name = "nexus-pv"
  }
  spec {
    capacity = {
      storage = "10Gi"
    }
    access_modes = ["ReadWriteOnce"]
    persistent_volume_source {
      host_path {
        path = "/mnt/data/nexus"
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "nexus_pvc" {
  metadata {
    name      = "nexus-pvc"
    namespace = kubernetes_namespace.tools.metadata[0].name
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "10Gi"
      }
    }
  }
}
