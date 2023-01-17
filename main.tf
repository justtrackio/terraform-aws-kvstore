locals {
  has_additional_attributes = length(module.this.attributes) > 1
  redis_container_name      = "redis"
}

# can't just pull in the context here because the attributes add up instead of being replaced by the input
module "ddb_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  enabled             = module.this.enabled
  namespace           = module.this.namespace
  tenant              = module.this.tenant
  environment         = module.this.environment
  stage               = module.this.stage
  name                = module.this.name
  delimiter           = module.this.delimiter
  tags                = module.this.tags
  additional_tag_map  = module.this.additional_tag_map
  label_order         = var.ddb_label_order
  regex_replace_chars = module.this.regex_replace_chars
  id_length_limit     = module.this.id_length_limit
  label_key_case      = var.label_key_case
  label_value_case    = var.label_value_case
  descriptor_formats  = var.descriptor_formats
  labels_as_tags      = var.labels_as_tags
}

module "redis_label" {
  count   = var.redis_enabled ? 1 : 0
  source  = "cloudposse/label/null"
  version = "0.25.0"

  context     = module.ddb_label.context
  attributes  = concat(["kvstore_${try(module.this.attributes[0], "")}"], local.has_additional_attributes ? slice(module.this.attributes, 1, length(module.this.attributes)) : [])
  label_order = var.redis_label_order
}

module "ddb" {
  source = "github.com/justtrackio/terraform-aws-dynamodb-table?ref=v1.0.1"

  context    = module.ddb_label.context
  attributes = concat(["kvstore-${try(module.this.attributes[0], "")}"], local.has_additional_attributes ? slice(module.this.attributes, 1, length(module.this.attributes)) : [])

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

module "task_label" {
  source      = "cloudposse/label/null"
  version     = "0.25.0"
  attributes  = ["task"]
  label_order = var.iam_label_order

  context = module.this.context
}

data "aws_iam_policy_document" "ecs_task" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_task" {
  count = var.redis_enabled ? 1 : 0

  name               = module.task_label.id
  assume_role_policy = data.aws_iam_policy_document.ecs_task.json
  tags               = module.task_label.tags
}

module "exec_label" {
  source      = "cloudposse/label/null"
  version     = "0.25.0"
  attributes  = ["exec"]
  label_order = var.iam_label_order

  context = module.this.context
}

data "aws_iam_policy_document" "ecs_task_exec" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_exec" {
  count = var.redis_enabled ? 1 : 0

  name               = module.exec_label.id
  assume_role_policy = data.aws_iam_policy_document.ecs_task_exec.json
  tags               = module.exec_label.tags
}

data "aws_iam_policy_document" "ecs_exec" {
  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ssm:GetParameters",
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
  }
}

resource "aws_iam_role_policy" "ecs_exec" {
  count = var.redis_enabled ? 1 : 0

  name   = module.exec_label.id
  policy = data.aws_iam_policy_document.ecs_exec.json
  role   = aws_iam_role.ecs_exec[0].id
}

module "container_definition" {
  count   = var.redis_enabled ? 1 : 0
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
  count   = var.redis_enabled ? 1 : 0
  source  = "cloudposse/ecs-alb-service-task/aws"
  version = "0.66.4"

  context = module.redis_label[0].context

  container_definition_json          = "[${sensitive(module.container_definition[0].json_map_encoded)}]"
  deployment_maximum_percent         = var.redis_deployment_maximum_percent
  deployment_minimum_healthy_percent = var.redis_deployment_minimum_healthy_percent
  desired_count                      = var.redis_desired_count
  ecs_cluster_arn                    = var.redis_ecs_cluster_arn
  launch_type                        = var.redis_launch_type
  name                               = "${var.name}${module.this.delimiter}redis"
  network_mode                       = var.redis_network_mode
  propagate_tags                     = var.redis_propagate_tags
  vpc_id                             = var.redis_vpc_id
  task_role_arn                      = [aws_iam_role.ecs_task[0].arn]
  task_exec_role_arn                 = [aws_iam_role.ecs_exec[0].arn]

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
  count = var.redis_enabled ? 1 : 0
  name  = "kvstore_${try(module.this.attributes[0], "")}.${module.this.stage}-${module.this.name}.redis"

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
