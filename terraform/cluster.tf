resource "google_service_account" "main" {
  account_id   = "gke-${var.cluster_name}-${var.branch}-sa"
  display_name = "GKE Cluster ${var.cluster_name}-${var.branch} Service Account"
}

resource "google_container_cluster" "main" {
  name               = "${var.cluster_name}-${var.branch}"
  location           = var.location
  initial_node_count = 3
  binary_authorization {
    evaluation_mode = "PROJECT_SINGLETON_POLICY_ENFORCE"
  }
  node_config {
    service_account = google_service_account.main.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
  timeouts {
    create = "30m"
    update = "40m"
  }
}
