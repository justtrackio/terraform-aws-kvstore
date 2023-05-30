variable "ddb_autoscaling_enabled" {
  description = "Whether or not to enable autoscaling. See note in README about this setting"
  type        = bool
  default     = true
}

variable "ddb_billing_mode" {
  type        = string
  default     = "PROVISIONED"
  description = "The billing mode for the DDB table"
}

variable "ddb_enabled" {
  type        = bool
  description = "For creating a dynamodb table"
  default     = true
}

variable "ddb_read_capacity" {
  description = "The number of read units for this table. If the billing_mode is PROVISIONED, this field should be greater than 0"
  type        = number
  default     = null
}

variable "ddb_write_capacity" {
  description = "The number of write units for this table. If the billing_mode is PROVISIONED, this field should be greater than 0"
  type        = number
  default     = null
}

variable "label_orders" {
  type = object({
    kvstore = optional(list(string), ["environment", "stage", "tenant", "name"])
  })
  default     = {}
  description = "Overrides the `labels_order` for the different labels to modify ID elements appear in the `id`"
}

variable "redis_cpu_size" {
  type        = number
  default     = 25
  description = "The cpu size of the redis instance"
}

variable "redis_deployment_maximum_percent" {
  type        = number
  description = "The upper limit of the number of tasks (as a percentage of `desired_count`) that can be running in a service during a deployment"
  default     = 100
}

variable "redis_deployment_minimum_healthy_percent" {
  type        = number
  description = "The lower limit (as a percentage of `desired_count`) of the number of tasks that must remain running and healthy in a service during a deployment"
  default     = 0
}

variable "redis_enabled" {
  type        = bool
  description = "For creating a redis service"
  default     = true
}

variable "redis_image_repository" {
  type        = string
  description = "Redis image repository to use when use_redis is true"
  default     = "redis"
}

variable "redis_image_tag" {
  type        = string
  description = "Redis image tag to use when use_redis is true"
  default     = "7-alpine"
}

variable "redis_maxmemory" {
  type        = number
  default     = 25
  description = "The memory size of the redis instance"
}

variable "redis_maxmemory_policy" {
  type        = string
  description = "When your Redis instance memory is full, and a new write comes in, Redis evicts keys to make room for the write based on your instance's maxmemory policy."
  default     = "allkeys-lru"
}

variable "redis_memory_size" {
  type        = number
  default     = 50
  description = "The memory size of the ECS container"
}
