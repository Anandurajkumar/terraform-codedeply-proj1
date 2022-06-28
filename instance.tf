
  resource "aws_instance" "codecommmit-ec2" {  
  ami = "ami-0cff7528ff583bf9a" 
  instance_type = "t2.micro"
  iam_instance_profile = "${aws_iam_instance_profile.test_profile2.name}"
  key_name = "ansil"
  security_groups = ["asg_sec_group"]
  user_data = <<-EOF
            #!/bin/bash
            sudo yum -y update
            sudo yum install ruby -y
            sudo yum install wget -y
            cd /home/ec2-user
            aws s3 cp s3://aws-codedeploy-us-east-1/samples/latest/SampleApp_Linux.zip . --region us-east-1
            aws s3 cp --recursive s3://aws-codedeploy-us-east-1 . --region us-east-1
            chmod +x ./latest/install
            sudo ./latest/install auto 
            
            EOF


  tags = {
    Name = "codecimmit-terraform_instace"
      }
}