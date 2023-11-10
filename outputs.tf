output "redis_service_discovery_service_arn" {
  description = "ARN of the aws_service_discovery_service created for the redis service"
  value       = try(module.redis[0].service_discovery_service_arn, "")
}
