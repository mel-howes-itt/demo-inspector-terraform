# demo-inspector-terraform
Demo for using Terraform to provision 2 x EC2 instances with a particular tag, install AWS Inspector agent and then create AWS Inspector assessment target and template for those instances. 

The key name and path referenced (needed for the SSH to install AWS Inspector agent) are fake :-) Please add your own. 

Use a separate .tfvars file with your AWS Acess Key and Secret Key in order to get this example to work. 

You may need to change the region, this example is based on eu-west-1 (Ireland). If you change the region then you will need to change the ARNs for the rules packages. See here: https://docs.aws.amazon.com/inspector/latest/userguide/inspector_rules-arns.html

The security group has 3 ingress and egress rules to open ports 22, 80 and 443. This is needed so that you can SSH in to ec2, get the AWS Inspector agent installer from https site and then run an update that grabs files from http site. 
