terraform {

required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  #backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "ExamPro"

  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
  #cloud {
  #  organization = "ExamPro"
  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}

}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.user_uuid
  token = var.terratowns_access_token
}

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  assets_path = var.assets_path
  content_version = var.content_version
}

resource "terratowns_home" "home" {
  name = "Terraform For Beginners Bootcamp Infographics"
  description = <<DESCRIPTION
Here are some infographics that helped me understand some of the concepts 
related to the topics covered in this bootcamp
DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  #domain_name = "blahblah.cloudfront.net"
  town = "missingo"
  content_version = 1
}