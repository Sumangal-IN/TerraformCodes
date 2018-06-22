provider "aws" {
  access_key = "****"
  secret_key = "****"
  region     = "us-east-1"
}

resource "aws_instance" "DemoApp" {
	ami           = "ami-467ca739"
	instance_type = "t2.micro"
	key_name = "aws10"
	tags {
		Name = "DemoApp"
	}
	
	provisioner "file" {
        source = "demo-0.0.1-SNAPSHOT.jar"
        destination = "demo-0.0.1-SNAPSHOT.jar"
        connection {
            type = "ssh"
            user = "ec2-user"
            private_key = "${file("C:\\Users\\1003862\\Downloads\\aws10.pem")}"
        }
    }

    provisioner "remote-exec" {
        inline = [
		  "nohup java -jar demo-0.0.1-SNAPSHOT.jar > /tmp/demo.log 2>&1 &",
		  "sleep 1"
        ]
        connection {
            type = "ssh"
            user = "ec2-user"
            private_key = "${file("C:\\Users\\1003862\\Downloads\\aws10.pem")}"
        }
    }
}
