# Ansible master 

resource "aws_instance" "Ansible-Ecomm-Master" {
  ami           = "ami-0763cf792771fe1bd"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.ecomm-public-subnet.id
  key_name = "Tim"
  vpc_security_group_ids = [aws_security_group.ecomm-security.id]
  user_data = file("installAnsible.sh") 
  private_ip = "10.0.1.10"



  tags = {
    Name = "Ansible Master"
  }
}
