output "phone_number" {
  value = data.vault_generic_secret.phone_number
  #value = data.vault_generic_secret.phone_number.data["phone_number"]
  sensitive = true
}

resource "aws_instance" "app" {
  password = data.vault_generic_secret.phone_number.data["phone_number"]
}