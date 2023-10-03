resource "aws_vpc_endpoint_route_table_association" "endpoint" {
  count = length(var.route_table_ids)

  route_table_id  = var.route_table_ids[count.index]
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}