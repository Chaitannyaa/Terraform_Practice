provider "aws" {
   region     = "eu-central-1"
   access_key = "AKIA27CR22N3OCTIFG3D"
   secret_key = "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"
}

resource "aws_iam_user" "test" {
  count = length(var.user_names)
  name  = var.user_names[count.index]
}

variable "user_names" {
  description = "IAM usernames"
  type        = list(string)
  default     = ["user1", "user2", "user3"]
}