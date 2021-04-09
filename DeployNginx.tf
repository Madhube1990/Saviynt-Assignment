provider "kubernetes" {
  host     = "https://104.196.242.174"
  username = "ubuntu"
  password = "ubuntu"

  client_certificate     = "${file("~/.kube/client-cert.pem")}"
  client_key             = "${file("~/.kube/client-key.pem")}"
  cluster_ca_certificate = "${file("~/.kube/cluster-ca-cert.pem")}"
}


resource "kubernetes_deployment" "nginx" {

  metadata {
    name      = "nginx"
    namespace = "web"
  }

  spec {
    selector {
      app = "nginx"
    }

    template {
      metadata {
        labels {
          app = "nginx"
        }
      }

      spec {
        container {
          image = "nginx:1.8"
          name  = "app"

          resources {
            requests {
              memory = "1Gi"
              cpu    = "1"
            }

            limits {
              memory = "2Gi"
              cpu    = "2"
            }
          }

          readiness_probe {
            http_get {
              path = "/health"
              port = "90"
            }

            initial_delay_seconds = 10
            period_seconds        = 10
          }

          liveness_probe {
            exec {
              command = ["/bin/health"]
            }

            initial_delay_seconds = 120
            period_seconds        = 15
          }

          env {
            name  = "CONFIG_FILE_LOCATION"
            value = "/etc/app/config"
          }

          port {
            container_port = 80
          }

          volume_mount {
            name       = "config"
            mount_path = "/etc/app/config"
          }
        }

        init_container {
          name  = "helloworld"
          image = "debian"
          command = ["/bin/echo", "hello", "world"]
        }

        volume {
          name = "config"

          config_map {
            name = "app-config"
          }
        }

      }
    }
  }
}
