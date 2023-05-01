# AWS Volume EBS
resource "aws_ebs_volume" "xbeta1" {
  availability_zone = "ap-south-1b"
  size              = 20

  tags = {
    Name = "SanDisk"
  }
}
resource "aws_ebs_volume" "xbeta2" {
  availability_zone = "ap-south-1b"
  size              = 20

  tags = {
    Name = "SanDisk2"
  }
}

