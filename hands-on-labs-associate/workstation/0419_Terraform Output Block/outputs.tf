#-----------------------------------
// Output from ec2_instance_res.tf
#-----------------------------------
output "res_web_server_public_url" {
  description = "Public URL of Web server"
  value       = "http://${aws_instance.web_server.public_ip}"
}

output "res_web_server_public_ip" {
  description = "Public IP addresses of EC2 instances"
  value       = aws_instance.web_server.public_ip
}

output "res_ubuntu_server_public_url" {
  description = "Public URL of Web server"
  value       = "http://${aws_instance.ubuntu_server.public_ip}"
}

output "res_ubuntu_server_public_ip" {
  description = "Public IP addresses of EC2 instances"
  value       = aws_instance.ubuntu_server.public_ip
}

#-----------------------------------
// Output from auto_scalling_module.tf
#-----------------------------------
output "module_asg_max_size" {
  value = module.autoscaling.autoscaling_group_max_size
}

// Output from s3_bucket_module.tf
output "module_s3_bucket_name" {
  value = module.s3-bucket.s3_bucket_bucket_domain_name
}

#-----------------------------------
// Output from mdule ec2_instance_module.tf
#-----------------------------------
output "module_server_public_ip" {
  value = module.server.public_ip
}

output "module_server_public_dns" {
  value = module.server.public_dns
}

output "module_server_type" {
  value = module.server.instance_type
}

output "module_web_server_public_ip" {
  value = module.web_server.public_ip
}

output "module_web_server_public_dns" {
  value = module.web_server.public_dns
}

output "module_web_server_type" {
  value = module.web_server.instance_type
}

#-----------------------------------
// Output from variable_sensitive.tf
#-----------------------------------
output "sensitive_first_name" {
  value     = local.contact_info_sensitive.first_name
  sensitive = true
}

output "sensitive_last_name" {
  value     = local.contact_info_sensitive.last_name
  sensitive = true
}

output "sensitive_phone_number" {
  value     = local.contact_info_sensitive.phone_number
  sensitive = true
}

output "nonsensitive_my_number" {
  value = local.my_number
}

#-----------------------------------
// Output from variable_validation.tf
#-----------------------------------
output "valid_cloud" {
  value = local.contact_info_valid.cloud
}

output "valid_department" {
  value = local.contact_info_valid.department
}

output "valid_cost_code" {
  value = local.contact_info_valid.cost_code
}

output "valid_ip_address" {
  value = local.contact_info_valid.ip_address

}

#-----------------------------------
// Output form data_aws_res.tf
#-----------------------------------
output "data-bucket-arn" {
  value = data.aws_s3_bucket.data_bucket.arn
}

output "data-bucket-domain-name" {
  value = data.aws_s3_bucket.data_bucket.bucket_domain_name
}

output "data-bucket-region" {
  value = "The ${data.aws_s3_bucket.data_bucket.id} bucket is located in ${data.aws_s3_bucket.data_bucket.region}"
}

#-----------------------------------
// Output form locals_num.tf
#-----------------------------------
output "local_num_max_value" {
  value = local.maximum
}
output "local_num_min_value" {
  value = local.minimum
}