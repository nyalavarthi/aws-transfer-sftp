
# Variables file implemented terraform workspaces using maps

variable "workspace_to_environment_map" {
  type = map
  default = {
    sbx = ""
    dev = "dev"
    qa  = "qa"
    prd = "prd"
  }
}

#SFTP bucket name for each environment. 
variable "sftp_bucket_name_map" {
  description = "A map from environment to a list of key pairs"
  type        = map
  default = {
    sbx = ""
    dev = "sftp-bucket-ny13"
    qa  = ""
    prd = ""
  }
}

#SFTP bucket prefix ( folder ) for each environment for one user
variable "sftp_user_map" {
  description = "A map from environment to a list of key pairs"
  type        = map
  default = {
    sbx = ""
    dev = "sftp-testuser-dev"
    qa  = ""
    prd = ""
  }
}

#account details
variable "region" {
  type        = string
  description = "default aws region"
} 

variable "access_key" {
  type        = string
  description = "aws access key for aws provider"
}

variable "secret_key" {
  type        = string
  description = "aws secret key for aws provider"
}

/* variable "aws_tags" {
  description = "Tagging for ownership and cost information."
  type        = map(any)
  default = null

} */


#learn work terraform workspaces here - https://www.terraform.io/docs/state/workspaces.html
# command to initilize environment specific workspace ( dev, qa, prd)
# each env will have a separate backend file
# terraform init -backend-config=backends/dev-env.tf
# then init follow the below commands
# terraform workspace new "dev"
# terraform plan
# terraform apply
locals {
  workspace_env = "${lookup(var.workspace_to_environment_map, terraform.workspace, "dev")}"
  #convert to uppercase 
  environment      = "${upper(local.workspace_env)}"
  sftp_bucket_name = "${var.sftp_bucket_name_map[local.workspace_env]}"
  sftp_user        = "${var.sftp_user_map[local.workspace_env]}"
} 


variable "owner_name" {
  default = "Jhojo Malicdem"
}
