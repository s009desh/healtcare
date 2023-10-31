provider "aws" {
  region     = "us-east-1"
  access_key = "ACCESS-keys"
  secret_key = "secert Acces keys"
}

resource "aws_instance" "jenkins_master" {
  ami             = "ami-0261755bbcb8c4a84"
  instance_type   = "t2.micro"
  key_name        = "kubernetes"
  security_groups = ["launch-wizard-1"]
  tags = {
    Name = "jenkins-master"
  }

  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
              echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
              sudo apt-get update
              sudo apt-get install -y fontconfig openjdk-11-jre
              sudo apt-get install -y jenkins
              EOF
}

resource "aws_instance" "jenkins_slave" {
  ami             = "ami-0261755bbcb8c4a84"
  instance_type   = "t2.micro"
  key_name        = "kubernetes"
  security_groups = ["launch-wizard-1"]
  tags = {
    Name = "jenkins-slave"

  }

  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }
}

resource "aws_instance" "kubernetes_master" {
  ami             = "ami-0261755bbcb8c4a84"
  instance_type   = "t2.micro"
  key_name        = "kubernetes"
  security_groups = ["launch-wizard-1"]
  tags = {
    Name = "kubernetes-master"
  }

  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }
}

resource "aws_instance" "kubernetes_slave" {
  ami             = "ami-0261755bbcb8c4a84"
  instance_type   = "t2.micro"
  key_name        = "kubernetes"
  security_groups = ["launch-wizard-1"]
  tags = {
    Name = "kubernetes-slave"
  }

  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }
}

resource "aws_instance" "kubernetes_slave2" {
  ami             = "ami-0261755bbcb8c4a84"
  instance_type   = "t2.micro"
  key_name        = "kubernetes"
  security_groups = ["launch-wizard-1"]
  tags = {
    Name = "kubernetes-slave"
  }

  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }
}

resource "aws_instance" "monitering" {
  ami             = "ami-0261755bbcb8c4a84"
  instance_type   = "t2.micro"
  key_name        = "kubernetes"
  security_groups = ["launch-wizard-1"]
  tags = {
    Name = "Monitering"
  }

  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }

   user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get prometheus -y
              sudo apt-get install -y apt-transport-https software-properties-common wget
              sudo mkdir -p /etc/apt/keyrings/
              wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null
              echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
              echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com beta main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
              sudo apt-get update -y
              sudo apt-get install grafana
              EOF

}
