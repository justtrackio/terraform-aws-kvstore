output "redis_service_discovery_service_arn" {
  description = "ARN of the aws_service_discovery_service created for the redis service"
  value       = try(aws_service_discovery_service.this[0].arn, "")
}
