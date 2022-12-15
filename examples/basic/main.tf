module "example" {
  source = "../.."

  name                                     = "service-name"
  label_value_case                         = "none" # only for keeping case
  attributes                               = ["myEntity"]
  redis_ecs_cluster_arn                    = "arn:aws:ecs:eu-central-1:123456789123:cluster/my-cluster"
  redis_service_discovery_dns_namespace_id = "ns-ab12c34defghij5k"
}
