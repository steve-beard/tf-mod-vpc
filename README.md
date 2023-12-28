## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route_table.firewall](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.firewall](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.firewall](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azs"></a> [azs](#input\_azs) | The availability zones to use | `list(string)` | n/a | yes |
| <a name="input_base_cidr"></a> [base\_cidr](#input\_base\_cidr) | The base CIDR block for the VPC | `string` | n/a | yes |
| <a name="input_db_subnet_security_group_rules"></a> [db\_subnet\_security\_group\_rules](#input\_db\_subnet\_security\_group\_rules) | A list of security group rules to add to each db subnet security group | <pre>list(object({<br>    name        = string<br>    type        = string<br>    from_port   = number<br>    to_port     = number<br>    protocol    = string<br>    cidr_blocks = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_firewall"></a> [firewall](#input\_firewall) | Whether to create the firewall subnet | `bool` | `false` | no |
| <a name="input_firewall_subnet_security_group_rules"></a> [firewall\_subnet\_security\_group\_rules](#input\_firewall\_subnet\_security\_group\_rules) | A list of security group rules to add to each firewall subnet security group | <pre>list(object({<br>    name        = string<br>    type        = string<br>    from_port   = number<br>    to_port     = number<br>    protocol    = string<br>    cidr_blocks = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_internal_subnet_security_group_rules"></a> [internal\_subnet\_security\_group\_rules](#input\_internal\_subnet\_security\_group\_rules) | A list of security group rules to add to each internal subnet security group | <pre>list(object({<br>    name        = string<br>    type        = string<br>    from_port   = number<br>    to_port     = number<br>    protocol    = string<br>    cidr_blocks = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_private_subnet_security_group_rules"></a> [private\_subnet\_security\_group\_rules](#input\_private\_subnet\_security\_group\_rules) | A list of security group rules to add to each private subnet security group | <pre>list(object({<br>    name        = string<br>    type        = string<br>    from_port   = number<br>    to_port     = number<br>    protocol    = string<br>    cidr_blocks = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_public_subnet_security_group_rules"></a> [public\_subnet\_security\_group\_rules](#input\_public\_subnet\_security\_group\_rules) | A list of security group rules to add to each public subnet security group | <pre>list(object({<br>    name        = string<br>    type        = string<br>    from_port   = number<br>    to_port     = number<br>    protocol    = string<br>    cidr_blocks = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_region"></a> [region](#input\_region) | The region to deploy to | `string` | `"us-east-1"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | The name of the VPC | `string` | n/a | yes |
| <a name="input_vpc_security_group_rules"></a> [vpc\_security\_group\_rules](#input\_vpc\_security\_group\_rules) | A list of security group rules to add to the main security group | <pre>list(object({<br>    name        = string<br>    type        = string<br>    from_port   = number<br>    to_port     = number<br>    protocol    = string<br>    cidr_blocks = list(string)<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_additional_security_group_ids"></a> [additional\_security\_group\_ids](#output\_additional\_security\_group\_ids) | The IDs of the additional security groups |
| <a name="output_firewall_route_table_ids"></a> [firewall\_route\_table\_ids](#output\_firewall\_route\_table\_ids) | The IDs of the firewall route tables |
| <a name="output_firewall_subnets"></a> [firewall\_subnets](#output\_firewall\_subnets) | The IDs of the firewall subnets |
| <a name="output_internet_gateway_id"></a> [internet\_gateway\_id](#output\_internet\_gateway\_id) | The ID of the Internet Gateway |
| <a name="output_main_security_group_id"></a> [main\_security\_group\_id](#output\_main\_security\_group\_id) | The ID of the main security group |
| <a name="output_nat_gateway_ids"></a> [nat\_gateway\_ids](#output\_nat\_gateway\_ids) | The IDs of the NAT Gateways |
| <a name="output_private_route_table_ids"></a> [private\_route\_table\_ids](#output\_private\_route\_table\_ids) | The IDs of the private route tables |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | The IDs of the private subnets |
| <a name="output_public_route_table_ids"></a> [public\_route\_table\_ids](#output\_public\_route\_table\_ids) | The IDs of the public route tables |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | The IDs of the public subnets |
| <a name="output_vpc_endpoints"></a> [vpc\_endpoints](#output\_vpc\_endpoints) | The IDs of the VPC endpoints |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
