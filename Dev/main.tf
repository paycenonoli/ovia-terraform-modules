# Define the provider
provider "aws" {
  region  = "us-east-2"
  profile = "default"
}
# Create modules
module "my_vpc" {
    source = "../modules/vpc"
    vpc_cidr = "10.0.0.0/16"
    tenancy = "default"
    vpc_id = "${module.my_vpc.vpc_id}"
    subnet_cidr = "10.0.0.0/24"
}

module "my_ec2" {
    source = "../modules/ec2"
    ec2_count = 1
    ami_id = "ami-0e83be366243f524a"
    instance_type = "t2.micro"
    subnet_id = "${module.my_vpc.subnet_id}"
}
