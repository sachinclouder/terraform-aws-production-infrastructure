output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.this.id
}

output "vpc_cidr" {
  description = "VPC CIDR"
  value       = aws_vpc.this.cidr_block
}

output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.this.id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"

  value = {
    for az, subnet in aws_subnet.public :
    az => subnet.id
  }
}

output "public_route_table_id" {
  description = "Public Route Table ID"
  value       = aws_route_table.public.id
}

output "private_subnet_ids" {
  description = "Private subnet IDs"

  value = {
    for az, subnet in aws_subnet.private :
    az => subnet.id
  }
}

output "nat_gateway_id" {
  description = "NAT Gateway ID when NAT Gateway is enabled"
  value       = try(aws_nat_gateway.this[0].id, null)
}

output "private_route_table_id" {
  description = "Private route table ID"
  value       = aws_route_table.private.id
}