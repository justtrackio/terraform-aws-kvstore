module "example" {
  source = "../.."

  tenant                                   = "t"
  namespace                                = "ns"
  environment                              = "env"
  stage                                    = "st"
  name                                     = "nm"
  attributes                               = ["a1", "a2"]
  ddb_label_order                          = ["environment", "name", "attributes"]
  iam_role_label_order                     = ["environment", "name", "attributes"]
  redis_label_order                        = ["name", "attributes"]
  label_value_case                         = "none" # only for keeping case
  redis_ecs_cluster_arn                    = "arn:aws:ecs:eu-central-1:123456789123:cluster/my-cluster"
  redis_service_discovery_dns_namespace_id = "ns-ab12c34defghij5k"
}
