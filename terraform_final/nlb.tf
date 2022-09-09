resource "aws_lb" "nlb" {
  name               = "cluster-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = [aws_subnet.cluster-public-us-east-1b.id, aws_subnet.cluster-public-us-east-1c.id, aws_subnet.cluster-public-us-east-1d.id]
#   enable_deletion_protection = true
  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "nlb_tg" {
  name     = "cluster-nlb-tg"
  port     = 30001
  protocol = "TCP"
  target_type = "instance"
  vpc_id   = aws_vpc.ops_vpc.id
}

resource "aws_lb_listener" "nlb_lis" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = "80"
  protocol          = "TCP"

default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_tg.arn
  }
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_eks_node_group.public-nodes.resources[0].autoscaling_groups[0].name 
  lb_target_group_arn   = aws_lb_target_group.nlb_tg.arn
  depends_on = [
    # aws_eks_node_group.public_noder,
    aws_lb_target_group.nlb_tg
    ]
}











