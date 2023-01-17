module "example" {
  source = "../.."

  name             = "service-name"
  label_value_case = "none" # only for keeping case
  attributes       = ["myEntity"]

  redis_enabled = false
}
