locals {
  has_additional_attributes = length(module.this.attributes) > 1
  redis_container_name      = "redis"
}

# can't just pull in the context here because the attributes add up instead of being replaced by the input
module "ddb_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  attributes         = concat(["kvstore-${try(module.this.attributes[0], "")}"], local.has_additional_attributes ? slice(module.this.attributes, 1, length(module.this.attributes)) : [])
  enabled            = var.ddb_enabled
  label_order        = var.label_orders.ddb
  label_key_case     = var.label_key_case
  label_value_case   = var.label_value_case
  descriptor_formats = var.descriptor_formats
  labels_as_tags     = var.labels_as_tags

  context = module.this.context
}

module "redis_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  attributes         = concat(["kvstore_${try(module.this.attributes[0], "")}"], local.has_additional_attributes ? slice(module.this.attributes, 1, length(module.this.attributes)) : [])
  label_order        = var.label_orders.redis
  label_key_case     = var.label_key_case
  label_value_case   = var.label_value_case
  descriptor_formats = var.descriptor_formats
  labels_as_tags     = var.labels_as_tags
  enabled            = var.redis_enabled

  context = module.this.context
}

module "ddb" {
  count = module.ddb_label.enabled ? 1 : 0

  source  = "justtrackio/dynamodb-table/aws"
  version = "1.0.2"

  context = module.ddb_label.context

  billing_mode = var.ddb_billing_mode

  autoscale_read_schedule  = var.ddb_autoscale_read_schedule
  autoscale_write_schedule = var.ddb_autoscale_write_schedule

  hash_key = "key"

  dynamodb_attributes = [{
    name = "key"
    type = "S"
  }]

  ttl_enabled = false

  tags = {
    Model = "kvstore_${try(module.this.attributes[0], "")}"
  }
}

module "container_definition" {
  count   = module.redis_label.enabled ? 1 : 0
  source  = "cloudposse/ecs-container-definition/aws"
  version = "0.58.1"

  container_image              = "${var.redis_image_repository}:${var.redis_image_tag}"
  container_name               = local.redis_container_name
  container_cpu                = var.redis_cpu_size
  container_memory_reservation = var.redis_service_memory_size

  port_mappings = [
    {
      containerPort = 6379
      hostPort      = 0
      protocol      = "tcp"
    },
  ]

  command = [
    "--maxmemory ${var.redis_memory_size}mb",
    "--maxmemory-policy allkeys-lru"
  ]
}

module "redis" {
  count   = module.redis_label.enabled ? 1 : 0
  source  = "cloudposse/ecs-alb-service-task/aws"
  version = "0.66.4"

  context = module.redis_label.context

  container_definition_json          = "[${sensitive(module.container_definition[0].json_map_encoded)}]"
  deployment_maximum_percent         = var.redis_deployment_maximum_percent
  deployment_minimum_healthy_percent = var.redis_deployment_minimum_healthy_percent
  desired_count                      = var.redis_desired_count
  ecs_cluster_arn                    = var.redis_ecs_cluster_arn
  launch_type                        = var.redis_launch_type
  network_mode                       = var.redis_network_mode
  propagate_tags                     = var.redis_propagate_tags
  vpc_id                             = var.redis_vpc_id

  service_registries = [{
    registry_arn   = aws_service_discovery_service.this[0].arn
    container_name = local.redis_container_name
    container_port = 6379
  }]

  tags = {
    Model           = "kvstore_${try(module.this.attributes[0], "")}"
    ApplicationType = "redis"
  }

  service_placement_constraints = var.redis_service_placement_constraints != null ? var.redis_service_placement_constraints : module.this.environment == "prod" ? [{
    type       = "memberOf"
    expression = "attribute:spotinst.io/container-instance-lifecycle==od"
  }] : []
}

resource "aws_service_discovery_service" "this" {
  count = module.redis_label.enabled ? 1 : 0
  name  = var.redis_service_discovery_name

  dns_config {
    namespace_id = var.redis_service_discovery_dns_namespace_id

    dns_records {
      ttl  = 60
      type = "SRV"
    }
  }

  health_check_custom_config {
    failure_threshold = 1
  }

  tags = module.this.tags
}
