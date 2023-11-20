# Create ec2 instances
resource "aws_instance" "ovia_webserver" {
  count = "${var.ec2_count}"
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  subnet_id = "${var.subnet_id}"
  tags = {
    Name = "ovia-ubuntu"
  }
}