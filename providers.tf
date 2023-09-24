terraform {
#   cloud {
#     organization = "CyberInsightLab"

#     workspaces {
#       name = "terra-house-cyberinsight"
#     }
#   }
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

provider "aws" {
  # Configuration options
}
provider "random" {
  # Configuration options
}
