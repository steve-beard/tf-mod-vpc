output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnets" {
  description = "The IDs of the public subnets"
  value       = aws_subnet.public.*.id
}

output "private_subnets" {
  description = "The IDs of the private subnets"
  value       = aws_subnet.private.*.id
}

output "firewall_subnets" {
  description = "The IDs of the firewall subnets"
  value       = aws_subnet.firewall.*.id
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.gw.id
}

output "nat_gateway_ids" {
  description = "The IDs of the NAT Gateways"
  value       = aws_nat_gateway.nat.*.id
}

output "public_route_table_ids" {
  description = "The IDs of the public route tables"
  value       = aws_route_table.public.*.id
}

output "private_route_table_ids" {
  description = "The IDs of the private route tables"
  value       = aws_route_table.private.*.id
}

output "firewall_route_table_ids" {
  description = "The IDs of the firewall route tables"
  value       = aws_route_table.firewall.*.id
}
