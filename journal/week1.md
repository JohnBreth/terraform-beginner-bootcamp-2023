# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure

Our root module structure is as follows:

```
  - PROJECT_ROOT
  |
  ├── main.tf                 # everything else
  |
  ├── variables.tf            # stores structure of input variables
  |
  ├── providers.tf            # defines required providers and their configuration
  |
  ├── outputs.tf              # stores our outputs
  |
  ├── terraform.tfvars        # data of variables we want to load in our Terraform project
  |
  └── README.md               # required for root modules
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)
