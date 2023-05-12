# CREATING THE SECURITY GROUPS
 
resource "aws_security_group" "ecomm-security" {
  name        = "allow ecomm SSH and HTTP"
  description = "Allowing 22 and 8080"
  vpc_id      = aws_vpc.ecomm-VPC.id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ECOMM security"
  }
}
