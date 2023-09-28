locals {
  is_provisioned         = var.ddb_billing_mode == "PROVISIONED"
  default_read_capacity  = local.is_provisioned ? var.ddb_read_capacity == null ? 1 : var.ddb_read_capacity : null
  default_write_capacity = local.is_provisioned ? var.ddb_write_capacity == null ? 1 : var.ddb_write_capacity : null
  ddb_autoscaling_read = local.is_provisioned ? var.ddb_autoscaling_read == null ? {
    max_capacity = 100
  } : var.ddb_autoscaling_read : {}
  ddb_autoscaling_write = local.is_provisioned ? var.ddb_autoscaling_write == null ? {
    max_capacity = 100
  } : var.ddb_autoscaling_write : {}
}

module "kvstore_label" {
  source  = "justtrackio/label/null"
  version = "0.26.0"

  label_value_case = "none"
  label_order      = var.label_orders.kvstore
  tenant           = "kvstore"

  context = module.this.context
}

module "ddb" {
  count   = var.ddb_enabled ? 1 : 0
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "3.2.0"

  name                = module.kvstore_label.id
  hash_key            = "key"
  tags                = module.kvstore_label.tags
  autoscaling_enabled = var.ddb_autoscaling_enabled
  autoscaling_read    = local.ddb_autoscaling_read
  autoscaling_write   = local.ddb_autoscaling_write
  billing_mode        = var.ddb_billing_mode
  read_capacity       = local.default_read_capacity
  write_capacity      = local.default_write_capacity

  attributes = [
    {
      name = "key"
      type = "S"
    }
  ]
}

module "redis" {
  count   = var.redis_enabled ? 1 : 0
  source  = "justtrackio/ecs-redis/aws"
  version = "2.1.0"

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
  service_discovery_name             = "${module.kvstore_label.tenant}-${module.kvstore_label.name}.${module.kvstore_label.stage}"
}
