First let's focus on creating the directory structure. We create a folder specific to modules
# mkdir modules
We keep all our modules in this directory. Along with modules we want a couple of other folders for different environments for dev and prod. You can have more environments. We build vpc as a module, and ec2 instance as a module. Then we demonstrate how to use these modules in dev and prod environments:
# mkdir dev
# mkdir prod
The directories modules, dev and prod should be under the directory terraform-app.
Then within the modules directory create two folders, one for vpc module, and the other for ec2 module:
# mkdir vpc
# mkdir ec2
Within the vpc folder, create a file for defining vpcs and subnets. You can call it networking.tf:
# touch netwroking.tf
Then check terraform documentation for defining vpcs and subnets-parameterize the arguments and create the variable blocks. Move the variables into a separate file called variables.tf within the vpc folder, because they belong to the vpc resource.
Next we create one subnet where we would launch of ec2 instance. For the vpc id argument in the subnet resource block, instead of assigning the the id of our vpc, we want the user who would reuse the module to decide which vpc id to map to the subnet. For that, we make it a variable: vpc_id = "${var.vpc_id}"
Do this for the subnet cidr too: cidr_block = "${var.subnet_cidr}"
Add them to the variables.tf file. Omit a default value for the vpc_id in the variable block. Now, our networking resources are ready (vpc and subnet).
You can add more resources like internet gateway, NAT gateway, etc.
Next, we create the ec2 resource: instances.tf and the variables blocks.
When done, we now see how to reuse these two modules in the diffetrent environments, dev and prod.
Our dev environment is now a separate project/ stack so we create a file main.tf and input our values for all the arguments created in our module, we then call the module using the path of the module:

module "my_vpc" {
    source = "../modules/vpc"
    vpc_cidr = "10.0.0.0/16
    tenancy = "default"
    vpc_id = ""
    subnet_cidr = "10.0.0.0/24
}
For the vpc_id, create an output block in the networking.tf since it is not yet known.
Then to caall it in the main.tf for dev, we use:
vpc_id = "${module.vpc.vpc_id}"
Same for the subnet_id
When done, now run terraform init on the main.tf file for dev environment