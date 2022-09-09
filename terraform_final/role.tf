resource "aws_iam_user" "user" {
  name = var.user_name
}

#crate policy 
resource "aws_iam_user_policy_attachment" "attach-user" {
  user       = aws_iam_user.user.name
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonSSMFullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  ])
   policy_arn = each.value
} 
 
#create role for EC2 for smm 
resource "aws_iam_role" "smm_role" {
  name = "smm_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}

#profile
resource "aws_iam_instance_profile" "EC2_profile" {
  name = "EC2_profile"
  role = aws_iam_role.smm_role.id
}

#######################################################
resource "aws_iam_role" "cluster_role" {
  name = "eks_cluster_role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
  POLICY
}

resource "aws_iam_role_policy_attachment" "cluster-role-AmazonEksClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster_role.name
}
#################################################
data "tls_certificate" "eks-cert" {
  url = aws_eks_cluster.ops-django-cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks-oicp" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks-cert.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.ops-django-cluster.identity[0].oidc[0].issuer
}