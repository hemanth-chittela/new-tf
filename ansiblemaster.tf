# Ansible master

resource "aws_instance" "ans_master" {
  ami           = "ami-0763cf792771fe1bd"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.ecomm-pub-sn.id
  key_name = "Tim"
  vpc_security_group_ids = [aws_security_group.allow_ecomm.id]
  user_data = file("installAnsible1.sh")
  private_ip = "10.0.1.10"



  tags = {
    Name = "Ansible Master"
  }
}
