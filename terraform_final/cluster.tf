resource "aws_eks_cluster" "ops-django-cluster" {
  name     = "ops-django-cluster"
  role_arn = aws_iam_role.cluster_role.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.cluster-public-us-east-1b.id,
      aws_subnet.cluster-public-us-east-1c.id,
      aws_subnet.cluster-public-us-east-1d.id
      
    ]
    security_group_ids = [ aws_security_group.ops_security_group.id
    ]
  }
  depends_on = [
    aws_iam_role_policy_attachment.cluster-role-AmazonEksClusterPolicy
  ]
}
