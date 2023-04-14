# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "web_data_public_address" {
  value = "${aws_instance.web_data.public_ip}:8080"
}

output "web_data_public_ip" {
  value = aws_instance.web_data.public_ip
}

output "web_lookup_public_address" {
  value = "${aws_instance.web_lookup.public_ip}:8080"
}

output "web_lookup_public_ip" {
  value = aws_instance.web_lookup.public_ip
}

output "web_lookup_sshfile_public_address" {
  value = "${aws_instance.web_lookup_sshfile.public_ip}:8080"
}

output "web_lookup_sshfile_public_ip" {
  value = aws_instance.web_lookup_sshfile.public_ip
}

output "ami_value_data" {
  value = data.aws_ami.ubuntu.id
}

output "ami_value_lookup" {
  value = lookup(var.aws_amis, var.aws_region)
}

output "aws_region_deploy" {
  value = var.aws_region
}