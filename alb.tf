#create application load balancer
resource "aws_lb" "myapp_alb" {
  name = "${var.project_name}-${var.environment}-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.myapp_alb_sg.id]
  subnets = [aws_subnet.pub_myapp_subnet_az1.id, aws_subnet.pub_myapp_subnet_az2.id]
  enable_deletion_protection = false

  tags = {
    Name = "${var.project_name}-${var.environment}-alb"
  }
}

#create target group for application load balancer
resource "aws_lb_target_group" "myapp_alb_tg" {
  name     = "${var.project_name}-${var.environment}-alb-tg"
  target_type = "ip"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200,301,302"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}

#create a listner on port 80 with redirect action
resource "aws_lb_listener" "myapp_alb_listener" {
  load_balancer_arn = aws_lb.myapp_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.myapp_alb_tg.arn
  }
}

# #create a listner on port 443 with forward action
# resource "aws_lb_listener" "myapp_alb_listener_http" {
#   load_balancer_arn = aws_lb.myapp_alb.arn
#   port              = 443
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.myapp_alb_tg.arn
#   }
# }