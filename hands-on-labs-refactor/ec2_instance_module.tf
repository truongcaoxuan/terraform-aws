module "server" {
  source    = "./modules/server"
  ami       = data.aws_ami.ubuntu.id
  subnet_id = aws_subnet.res_publics["public_subnet_2"].id
  security_groups = [
    aws_security_group.icmp-traffic.id,
    aws_security_group.ingress-ssh.id,
    aws_security_group.web-traffic.id
  ]
}

module "web_server" {
  source    = "./modules/web_server"
  ami       = data.aws_ami.ubuntu.id
  subnet_id = aws_subnet.res_publics["public_subnet_1"].id
  security_groups = [
    aws_security_group.icmp-traffic.id,
    aws_security_group.ingress-ssh.id,
    aws_security_group.web-traffic.id,
    aws_security_group.web-traffic-dynamic-var.id
  ]

  key_name    = aws_key_pair.generated.key_name
  user        = "ubuntu"
  private_key = tls_private_key.generated.private_key_pem
}

