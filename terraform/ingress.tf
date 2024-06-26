resource "kubernetes_network_policy" "tools_network_policy" {
  metadata {
    name      = "tools-network-policy"
    namespace = kubernetes_namespace.tools.metadata[0].name
  }
  spec {
    pod_selector {}
    policy_types = ["Ingress"]
    ingress {
      from {
        namespace_selector {}
        pod_selector {}
      }
      ports {
        port     = 8080
        protocol = "TCP"
      }
      ports {
        port     = 8081
        protocol = "TCP"
      }
    }
  }
}

resource "kubernetes_network_policy" "dev_network_policy" {
  metadata {
    name      = "dev-network-policy"
    namespace = kubernetes_namespace.dev.metadata[0].name
  }
  spec {
    pod_selector {}
    policy_types = ["Ingress"]
    ingress {
      from {
        namespace_selector {}
        pod_selector {}
      }
      ports {
        port     = 5000
        protocol = "TCP"
      }
      ports {
        port     = 3306
        protocol = "TCP"
      }
    }
  }
}