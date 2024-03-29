# demo-inspector-terraform
Demo for using Terraform to provision 2 x EC2 instances with a particular tag, install AWS Inspector agent and then create AWS Inspector assessment target and template for those instances. You can then use either the AWS CLI or the Console to start an assessment run using the template.

The key name and path referenced (needed for the SSH to install AWS Inspector agent) are fake! Please add your own so it works. 

Use a separate .tfvars file with your AWS Acess Key and Secret Key in order to get this example to work. 

You may need to change the region, this example is based on eu-west-1 (Ireland). If you change the region then you will need to change the ARNs for the rules packages. See here: https://docs.aws.amazon.com/inspector/latest/userguide/inspector_rules-arns.html

This line in the script relates to a seemingly incorrect URL in sources.list which references a non-existent URL related to the region, which needs to be edited. If it's not changed the installation of the AWS Inspector agent stalls forever:

sudo sed -i 's/eu-west-1\.ec2\.//g' /etc/apt/sources.list

The security group has 3 ingress and egress rules to open ports 22, 80 and 443. This is needed so that Terraform can SSH in to ec2, get the AWS Inspector agent installer from https site and then run an update that grabs files from http site. 

Note that AWS Linux AMIs have the AWS Inspector agent already installed, so this example is using an Ubuntu 16.04 AMI. The AMI will need to be updated, dependent on your region.

These scripts are for proof of concept for demo purposes and are not considered production ready.
