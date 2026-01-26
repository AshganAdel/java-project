resource "aws_lb" "jenkins_alb" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.alb_sg
  subnets            = [for subnet in var.public_subnets : subnet]

  tags = {
    Name = "jenkins-alb"
  }
}

resource "aws_lb_target_group" "alb-tg" {
  name        = "alb-tg"
  target_type = "instance"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  health_check {
    path = "/login"
  }
}

resource "aws_lb_target_group" "sounarqube-tg" {
  name        = "sonar-alb-tg"
  target_type = "instance"
  port        = 9000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  health_check {
    path = "/"
  }
}

resource "aws_lb_target_group_attachment" "sonar_test" {
  target_group_arn = aws_lb_target_group.sounarqube-tg.arn
  target_id        = var.instance_id
  port = 9000
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.alb-tg.arn
  target_id        = var.instance_id
  port = 8080
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.jenkins_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-tg.arn
  }
}

resource "aws_lb_listener_rule" "app1" {
  listener_arn = aws_lb_listener.http_listener.arn
  priority     = 10

  condition {
    path_pattern {
      values = ["/sonar/*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.sounarqube-tg.arn
  }
}
resource "aws_lb_listener_rule" "app2" {
  listener_arn = aws_lb_listener.http_listener.arn
  priority     = 20

  condition {
    path_pattern {
      values = ["/jenkins/*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-tg.arn
  }
}

