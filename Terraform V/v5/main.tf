provider "aws" {
   region     = "eu-central-1"
   access_key = "AKIATQ37NXB2NN3D4ARS"
   secret_key = "3v9mlwZQvmccL3ou1dxiDeEf1bWaG3kccpVlXXXX"
}

variable "user_names" {
  description = "IAM usernames"
  type        = set(string)
  default     = ["user1", "user2", "user3"]
}

resource "aws_iam_user" "example" {
  for_each = var.user_names
  name  = each.value
}

variable "iam_users" {
  description = "role of iam user"
  type        = map(string)
  default     = {
    user1  = "normal user"
    user2  = "admin user"
    user3  = "root user"
  }
}

output "print_the_names" {
  value = [for name in var.user_names : name]
}

output "user_with_roles" {
  value = [for name, role in var.iam_users : "${name} is the ${role}"]
}