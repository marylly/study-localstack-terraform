variable "HOST" {
    default = "localhost"
}

terraform {
  backend "local" {}
}

provider "aws" {
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
  region                      = "us-east-1"
  s3_force_path_style         = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    ssm            = "http://${var.HOST}:4583"
  }
}

resource "aws_ssm_parameter" "config-json-current" {
  name  = "/local/parameterstore/config-json-current"
  type  = "String"
  value = <<EOF
  { "aws":
    { "region": "us-east-1" },
    "link": {
        "table": {"name": "config-local" }
    }
  }"
  EOF
}