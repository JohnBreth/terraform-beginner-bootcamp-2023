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
  cloud {
   organization = "CyberInsightLab"
   workspaces {
     name = "terra-house-cyberinsight"
   }
  }

}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.user_uuid
  token = var.terratowns_access_token
}

module "home_bootcamp_hosting" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  #bucket_name = var.bucket_name
  public_path = var.bootcamp.public_path
  content_version = var.bootcamp.content_version
}

resource "terratowns_home" "home" {
  name = "Terraform For Beginners Bootcamp Infographics"
  description = <<DESCRIPTION
Here are some infographics that helped me understand some of the concepts 
related to the topics covered in this bootcamp
DESCRIPTION
  domain_name = module.home_bootcamp_hosting.domain_name
  #domain_name = "blahblah.cloudfront.net"
  town = "the-nomad-pad"
  content_version = var.bootcamp.content_version
}

module "home_azure_hosting" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  #bucket_name = var.bucket_name
  public_path = var.azure.public_path
  content_version = var.azure.content_version
}

resource "terratowns_home" "home_azure" {
  name = "Azure Networking Cookbook"
  description = <<DESCRIPTION
Here are some delicious Azure networking infographics!
DESCRIPTION
  domain_name = module.home_azure_hosting.domain_name
  #domain_name = "blahblah.cloudfront.net"
  town = "cooker-cove"
  content_version = var.azure.content_version
}