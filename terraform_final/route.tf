#cluster path

resource "aws_route_table_association" "cluster-public-us-east-1b" {
  subnet_id      = aws_subnet.cluster-public-us-east-1b.id
  route_table_id = aws_route_table.ops_route_table.id
}

resource "aws_route_table_association" "cluster-public-us-east-1c" {
  subnet_id      = aws_subnet.cluster-public-us-east-1c.id
  route_table_id = aws_route_table.ops_route_table.id
}

resource "aws_route_table_association" "cluster-public-us-east-1d" {
  subnet_id      = aws_subnet.cluster-public-us-east-1d.id
  route_table_id = aws_route_table.ops_route_table.id
}