module "kvstore_label" {
  source  = "justtrackio/label/null"
  version = "0.26.0"

  label_value_case = "none"
  label_order      = ["environment", "stage", "tenant", "name"]
  tenant           = "kvstore"

  context = module.this.context
}

module "ddb" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "3.2.0"

  name                = module.kvstore_label.id
  hash_key            = "key"
  tags                = module.kvstore_label.tags
  autoscaling_enabled = true
  billing_mode        = var.ddb_billing_mode

  attributes = [
    {
      name = "key"
      type = "S"
    }
  ]
}

module "redis" {
  source  = "justtrackio/ecs-redis/aws"
  version = "2.0.0"

  context      = module.kvstore_label.context
  label_orders = var.label_orders

  redis_maxmemory                    = var.redis_maxmemory
  redis_maxmemory_policy             = var.redis_maxmemory_policy
  container_cpu                      = var.redis_cpu_size
  container_memory_reservation       = var.redis_memory_size
  container_image_repository         = var.redis_image_repository
  container_image_tag                = var.redis_image_tag
  deployment_maximum_percent         = var.redis_deployment_maximum_percent
  deployment_minimum_healthy_percent = var.redis_deployment_minimum_healthy_percent
}
