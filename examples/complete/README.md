
# examples/complete

Example that uses the module with many of its configurations. Used in CI E2E tests.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.62.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_rds"></a> [rds](#module\_rds) | ../.. | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | git::https://github.com/defenseunicorns/terraform-aws-uds-vpc.git | v0.0.2-alpha |

## Resources

| Name | Type |
|------|------|
| [random_id.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_iam_role_permissions_boundary"></a> [iam\_role\_permissions\_boundary](#input\_iam\_role\_permissions\_boundary) | ARN of a permissions boundary policy to use when creating IAM roles | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | The prefix to use when naming all resources | `string` | n/a | yes |
| <a name="input_rds_allocated_storage"></a> [rds\_allocated\_storage](#input\_rds\_allocated\_storage) | The allocated storage in gigabytes. | `number` | `20` | no |
| <a name="input_rds_create_random_password"></a> [rds\_create\_random\_password](#input\_rds\_create\_random\_password) | Whether to create random password for RDS primary cluster | `bool` | `true` | no |
| <a name="input_rds_db_name"></a> [rds\_db\_name](#input\_rds\_db\_name) | The name of the database to create when the DB instance is created. | `string` | `"example"` | no |
| <a name="input_rds_deletion_protection"></a> [rds\_deletion\_protection](#input\_rds\_deletion\_protection) | If the DB instance should have deletion protection enabled. | `bool` | `false` | no |
| <a name="input_rds_engine"></a> [rds\_engine](#input\_rds\_engine) | The database engine to use. | `string` | `"postgres"` | no |
| <a name="input_rds_engine_version"></a> [rds\_engine\_version](#input\_rds\_engine\_version) | The database engine version. | `string` | `"15.3"` | no |
| <a name="input_rds_family"></a> [rds\_family](#input\_rds\_family) | The family of the DB parameter group. | `string` | `"postgres15"` | no |
| <a name="input_rds_instance_class"></a> [rds\_instance\_class](#input\_rds\_instance\_class) | The instance type of the RDS instance. | `string` | `"db.t4g.large"` | no |
| <a name="input_rds_major_engine_version"></a> [rds\_major\_engine\_version](#input\_rds\_major\_engine\_version) | The major version of the engine that this option group should be associated with. | `string` | `"15"` | no |
| <a name="input_rds_max_allocated_storage"></a> [rds\_max\_allocated\_storage](#input\_rds\_max\_allocated\_storage) | The upper limit (in gigabytes) to which Amazon RDS can automatically scale the storage of the DB instance. | `number` | `40` | no |
| <a name="input_rds_password"></a> [rds\_password](#input\_rds\_password) | Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file.<br>  The password provided will not be used if the variable create\_random\_password is set to true. | `string` | `null` | no |
| <a name="input_rds_username"></a> [rds\_username](#input\_rds\_username) | Username for the master DB user. | `string` | `"exampleadmin"` | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region to deploy into | `string` | n/a | yes |
| <a name="input_region2"></a> [region2](#input\_region2) | Region to use for RDS backup replication is a separate region | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to all resources | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.62.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.62.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_rds"></a> [rds](#module\_rds) | ../.. | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 5.1.1 |

## Resources

| Name | Type |
|------|------|
| [random_id.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_iam_role_permissions_boundary"></a> [iam\_role\_permissions\_boundary](#input\_iam\_role\_permissions\_boundary) | ARN of a permissions boundary policy to use when creating IAM roles | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | The prefix to use when naming all resources | `string` | n/a | yes |
| <a name="input_rds_allocated_storage"></a> [rds\_allocated\_storage](#input\_rds\_allocated\_storage) | The allocated storage in gigabytes. | `number` | `20` | no |
| <a name="input_rds_create_random_password"></a> [rds\_create\_random\_password](#input\_rds\_create\_random\_password) | Whether to create random password for RDS primary cluster | `bool` | `true` | no |
| <a name="input_rds_db_name"></a> [rds\_db\_name](#input\_rds\_db\_name) | The name of the database to create when the DB instance is created. | `string` | `"example"` | no |
| <a name="input_rds_deletion_protection"></a> [rds\_deletion\_protection](#input\_rds\_deletion\_protection) | If the DB instance should have deletion protection enabled. | `bool` | `false` | no |
| <a name="input_rds_engine"></a> [rds\_engine](#input\_rds\_engine) | The database engine to use. | `string` | `"postgres"` | no |
| <a name="input_rds_engine_version"></a> [rds\_engine\_version](#input\_rds\_engine\_version) | The database engine version. | `string` | `"15.3"` | no |
| <a name="input_rds_family"></a> [rds\_family](#input\_rds\_family) | The family of the DB parameter group. | `string` | `"postgres15"` | no |
| <a name="input_rds_instance_class"></a> [rds\_instance\_class](#input\_rds\_instance\_class) | The instance type of the RDS instance. | `string` | `"db.t4g.large"` | no |
| <a name="input_rds_major_engine_version"></a> [rds\_major\_engine\_version](#input\_rds\_major\_engine\_version) | The major version of the engine that this option group should be associated with. | `string` | `"15"` | no |
| <a name="input_rds_max_allocated_storage"></a> [rds\_max\_allocated\_storage](#input\_rds\_max\_allocated\_storage) | The upper limit (in gigabytes) to which Amazon RDS can automatically scale the storage of the DB instance. | `number` | `40` | no |
| <a name="input_rds_password"></a> [rds\_password](#input\_rds\_password) | Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file.<br>  The password provided will not be used if the variable create\_random\_password is set to true. | `string` | `null` | no |
| <a name="input_rds_username"></a> [rds\_username](#input\_rds\_username) | Username for the master DB user. | `string` | `"exampleadmin"` | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region to deploy into | `string` | n/a | yes |
| <a name="input_region2"></a> [region2](#input\_region2) | Region to use for RDS backup replication is a separate region | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to all resources | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->