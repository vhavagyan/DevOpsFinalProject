resource "aws_iam_role" "nodes-role" {
  name = "eks-node-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes-role.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes-role.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes-role.name
}

resource "aws_eks_node_group" "public-nodes" {
  cluster_name    = aws_eks_cluster.ops-django-cluster.name
  node_group_name = "public-nodes"
  node_role_arn   = aws_iam_role.nodes-role.arn

  subnet_ids = [
    aws_subnet.cluster-public-us-east-1b.id,
    aws_subnet.cluster-public-us-east-1c.id,
    aws_subnet.cluster-public-us-east-1d.id
  ]
  capacity_type  = "ON_DEMAND"
  instance_types = ["t2.micro"]

  scaling_config {
    desired_size = 3
    max_size     = 3
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.nodes-AmazonEC2ContainerRegistryReadOnly
  ]
}

# #EKS can't directly set the "Name" tag, so we use the autoscaling_group_tag resource. 
# resource "aws_autoscaling_group_tag" "nodes_group" {
#   for_each = toset(
#     [for asg in flatten(
#       [for resources in aws_eks_node_group.public-noder.resources : resources.autoscaling_groups]
#     ) : asg.name]
#   )

#   autoscaling_group_name = each.value

#   tag {
#     key   = "Name"
#     value = "eks-asg"
#     propagate_at_launch = true
#   }
#   depends_on = [
#     aws_eks_cluster.im-cluster,
#     aws_eks_node_group.public-noder
#   ]
# }
