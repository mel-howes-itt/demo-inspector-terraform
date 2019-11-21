resource "aws_security_group" "demo" {
  name = "demo"
  description = "${var.SG_DESCRIPTION}"

  ingress {
    from_port = "${var.SG_PORT}"
    to_port = "${var.SG_PORT}"
    protocol = "${var.SG_PROTOCOL}"
    cidr_blocks = ["${var.SG_CIDR}"]
  }
  ingress {  
    from_port = "${var.SG_PORT2}"
    to_port = "${var.SG_PORT2}"
    protocol = "${var.SG_PROTOCOL2}"
    cidr_blocks = ["${var.SG_CIDR2}"]
  } 
  ingress {  
    from_port = "${var.SG_PORT3}"
    to_port = "${var.SG_PORT3}"
    protocol = "${var.SG_PROTOCOL3}"
    cidr_blocks = ["${var.SG_CIDR3}"]
  }
  
  egress {
    from_port = "${var.SG_PORT}"
    to_port = "${var.SG_PORT}"
    protocol = "${var.SG_PROTOCOL}"
    cidr_blocks = ["${var.SG_CIDR}"]
  }
  egress {  
    from_port = "${var.SG_PORT2}"
    to_port = "${var.SG_PORT2}"
    protocol = "${var.SG_PROTOCOL2}"
    cidr_blocks = ["${var.SG_CIDR2}"]
  }
  egress {  
    from_port = "${var.SG_PORT3}"
    to_port = "${var.SG_PORT3}"
    protocol = "${var.SG_PROTOCOL3}"
    cidr_blocks = ["${var.SG_CIDR3}"]
  }
}

resource "aws_instance" "demo" {
  ami = "${lookup(var.AMI, var.REGION)}"
  instance_type = "${var.INSTANCE_TYPE}"
  key_name = "${var.KEY_NAME}"
  security_groups = ["${aws_security_group.demo.name}"]
  count = "${var.INSTANCE_COUNT}"
  
  tags {
    Name = "InspectInstances"
  }
  
  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
    }
    inline = [
	  "sudo apt-get install wget",
      "wget https://inspector-agent.amazonaws.com/linux/latest/install",
	  "sudo sed -i 's/eu-west-1\.ec2\.//g' /etc/apt/sources.list",
      "sudo bash install -u false"
    ]
  }
}

resource "aws_inspector_resource_group" "inspectordemo" {
  tags {
    Name = "InspectInstances"
  }
}

resource "aws_inspector_assessment_target" "myinspecttarget" {
  name = "inspector-instance-assessment"
  resource_group_arn = "${aws_inspector_resource_group.inspectordemo.arn}"
}

resource "aws_inspector_assessment_template" "inspectordemotemplate" {
  name       = "inspectordemo template"
  target_arn = "${aws_inspector_assessment_target.myinspecttarget.arn}"
  duration   = 3600

  rules_package_arns = [
    "arn:aws:inspector:eu-west-1:357557129151:rulespackage/0-ubA5XvBh",
    "arn:aws:inspector:eu-west-1:357557129151:rulespackage/0-sJBhCr0F",
    "arn:aws:inspector:eu-west-1:357557129151:rulespackage/0-SPzU33xe",
    "arn:aws:inspector:eu-west-1:357557129151:rulespackage/0-SnojL3Z6",
  ]
}

