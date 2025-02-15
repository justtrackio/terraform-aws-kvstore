# terraform-aws-kvstore
Terraform module which creates a kvstore backed by dynamodb and redis

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ddb"></a> [ddb](#module\_ddb) | justtrackio/dynamodb-table/aws | 2.3.0 |
| <a name="module_kvstore_label"></a> [kvstore\_label](#module\_kvstore\_label) | justtrackio/label/null | 0.26.0 |
| <a name="module_redis"></a> [redis](#module\_redis) | justtrackio/ecs-redis/aws | 2.4.0 |
| <a name="module_this"></a> [this](#module\_this) | justtrackio/label/null | 0.26.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br/>This is for some rare cases where resources want additional configuration of tags<br/>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br/>in the order they appear in the list. New attributes are appended to the<br/>end of the list. The elements of the list are joined by the `delimiter`<br/>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | AWS account id | `string` | `null` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `string` | `null` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br/>See description of individual variables for details.<br/>Leave string and numeric variables as `null` to use default value.<br/>Individual variable settings (non-null) override settings in context object,<br/>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br/>  "additional_tag_map": {},<br/>  "attributes": [],<br/>  "delimiter": null,<br/>  "descriptor_formats": {},<br/>  "enabled": true,<br/>  "environment": null,<br/>  "id_length_limit": null,<br/>  "label_key_case": null,<br/>  "label_order": [],<br/>  "label_value_case": null,<br/>  "labels_as_tags": [<br/>    "unset"<br/>  ],<br/>  "name": null,<br/>  "namespace": null,<br/>  "regex_replace_chars": null,<br/>  "stage": null,<br/>  "tags": {},<br/>  "tenant": null<br/>}</pre> | no |
| <a name="input_ddb_autoscaling_enabled"></a> [ddb\_autoscaling\_enabled](#input\_ddb\_autoscaling\_enabled) | Whether or not to enable autoscaling. See note in README about this setting | `bool` | `true` | no |
| <a name="input_ddb_autoscaling_read"></a> [ddb\_autoscaling\_read](#input\_ddb\_autoscaling\_read) | A map of read autoscaling settings. `max_capacity` is the only required key. See example in examples/autoscaling | `map(string)` | `null` | no |
| <a name="input_ddb_autoscaling_write"></a> [ddb\_autoscaling\_write](#input\_ddb\_autoscaling\_write) | A map of write autoscaling settings. `max_capacity` is the only required key. See example in examples/autoscaling | `map(string)` | `null` | no |
| <a name="input_ddb_billing_mode"></a> [ddb\_billing\_mode](#input\_ddb\_billing\_mode) | The billing mode for the DDB table | `string` | `"PROVISIONED"` | no |
| <a name="input_ddb_deletion_protection_enabled"></a> [ddb\_deletion\_protection\_enabled](#input\_ddb\_deletion\_protection\_enabled) | Enables deletion protection for table | `bool` | `true` | no |
| <a name="input_ddb_enabled"></a> [ddb\_enabled](#input\_ddb\_enabled) | For creating a dynamodb table | `bool` | `true` | no |
| <a name="input_ddb_point_in_time_recovery_enabled"></a> [ddb\_point\_in\_time\_recovery\_enabled](#input\_ddb\_point\_in\_time\_recovery\_enabled) | Whether to enable point-in-time recovery | `bool` | `true` | no |
| <a name="input_ddb_read_capacity"></a> [ddb\_read\_capacity](#input\_ddb\_read\_capacity) | The number of read units for this table. If the billing\_mode is PROVISIONED, this field should be greater than 0 | `number` | `null` | no |
| <a name="input_ddb_schedule_scaling_read"></a> [ddb\_schedule\_scaling\_read](#input\_ddb\_schedule\_scaling\_read) | A map of read schedule scaling settings. See example in examples/autoscaling | <pre>list(object({<br/>    schedule     = string<br/>    min_capacity = number<br/>    max_capacity = number<br/>  }))</pre> | `[]` | no |
| <a name="input_ddb_schedule_scaling_write"></a> [ddb\_schedule\_scaling\_write](#input\_ddb\_schedule\_scaling\_write) | A map of write schedule scaling settings. See example in examples/autoscaling | <pre>list(object({<br/>    schedule     = string<br/>    min_capacity = number<br/>    max_capacity = number<br/>  }))</pre> | `[]` | no |
| <a name="input_ddb_write_capacity"></a> [ddb\_write\_capacity](#input\_ddb\_write\_capacity) | The number of write units for this table. If the billing\_mode is PROVISIONED, this field should be greater than 0 | `number` | `null` | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br/>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br/>Map of maps. Keys are names of descriptors. Values are maps of the form<br/>`{<br/>   format = string<br/>   labels = list(string)<br/>}`<br/>(Type is `any` so the map values can later be enhanced to provide additional options.)<br/>`format` is a Terraform format string to be passed to the `format()` function.<br/>`labels` is a list of labels, in order, to pass to `format()` function.<br/>Label values will be normalized before being passed to `format()` so they will be<br/>identical to how they appear in `id`.<br/>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br/>Set to `0` for unlimited length.<br/>Set to `null` for keep the existing setting, which defaults to `0`.<br/>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br/>Does not affect keys of tags passed in via the `tags` input.<br/>Possible values: `lower`, `title`, `upper`.<br/>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br/>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br/>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_orders"></a> [label\_orders](#input\_label\_orders) | Overrides the `labels_order` for the different labels to modify ID elements appear in the `id` | <pre>object({<br/>    ecs     = optional(list(string), ["stage", "tenant", "name"])<br/>    iam     = optional(list(string), ["environment", "stage", "tenant", "name", "attributes"]),<br/>    kvstore = optional(list(string), ["environment", "stage", "tenant", "name"])<br/>  })</pre> | `{}` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br/>set as tag values, and output by this module individually.<br/>Does not affect values of tags passed in via the `tags` input.<br/>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br/>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br/>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br/>Default is to include all labels.<br/>Tags with empty values will not be included in the `tags` output.<br/>Set to `[]` to suppress all generated tags.<br/>**Notes:**<br/>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br/>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br/>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br/>  "default"<br/>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br/>This is the only ID element not also included as a `tag`.<br/>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_organizational_unit"></a> [organizational\_unit](#input\_organizational\_unit) | Usually used to indicate the AWS organizational unit, e.g. 'prod', 'sdlc' | `string` | `null` | no |
| <a name="input_redis_cpu_size"></a> [redis\_cpu\_size](#input\_redis\_cpu\_size) | The cpu size of the redis instance | `number` | `25` | no |
| <a name="input_redis_deployment_maximum_percent"></a> [redis\_deployment\_maximum\_percent](#input\_redis\_deployment\_maximum\_percent) | The upper limit of the number of tasks (as a percentage of `desired_count`) that can be running in a service during a deployment | `number` | `100` | no |
| <a name="input_redis_deployment_minimum_healthy_percent"></a> [redis\_deployment\_minimum\_healthy\_percent](#input\_redis\_deployment\_minimum\_healthy\_percent) | The lower limit (as a percentage of `desired_count`) of the number of tasks that must remain running and healthy in a service during a deployment | `number` | `0` | no |
| <a name="input_redis_enabled"></a> [redis\_enabled](#input\_redis\_enabled) | For creating a redis service | `bool` | `true` | no |
| <a name="input_redis_image_repository"></a> [redis\_image\_repository](#input\_redis\_image\_repository) | Redis image repository to use when use\_redis is true | `string` | `"public.ecr.aws/docker/library/redis"` | no |
| <a name="input_redis_image_tag"></a> [redis\_image\_tag](#input\_redis\_image\_tag) | Redis image tag to use when use\_redis is true | `string` | `"7-alpine"` | no |
| <a name="input_redis_maxmemory"></a> [redis\_maxmemory](#input\_redis\_maxmemory) | The memory size of the redis instance | `number` | `25` | no |
| <a name="input_redis_maxmemory_policy"></a> [redis\_maxmemory\_policy](#input\_redis\_maxmemory\_policy) | When your Redis instance memory is full, and a new write comes in, Redis evicts keys to make room for the write based on your instance's maxmemory policy. | `string` | `"allkeys-lru"` | no |
| <a name="input_redis_memory_size"></a> [redis\_memory\_size](#input\_redis\_memory\_size) | The memory size of the ECS container | `number` | `50` | no |
| <a name="input_redis_task_cpu_size"></a> [redis\_task\_cpu\_size](#input\_redis\_task\_cpu\_size) | The number of CPU units used by the task. If using `FARGATE` launch type `task_cpu` must match [supported memory values](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size) | `number` | `null` | no |
| <a name="input_redis_task_memory_size"></a> [redis\_task\_memory\_size](#input\_redis\_task\_memory\_size) | The amount of memory (in MiB) used by the task. If using Fargate launch type `task_memory` must match [supported cpu value](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size) | `number` | `null` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br/>Characters matching the regex will be removed from the ID elements.<br/>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br/>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_redis_service_discovery_service_arn"></a> [redis\_service\_discovery\_service\_arn](#output\_redis\_service\_discovery\_service\_arn) | ARN of the aws\_service\_discovery\_service created for the redis service |
<!-- END_TF_DOCS -->
