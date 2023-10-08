variable "terratowns_endpoint" {
 type = string
}

variable "terratowns_access_token" {
 type = string
}

variable "user_uuid" {
 type = string
}

#variable "bucket_name" {
# type = string
#}

variable "bootcamp" {
  type = object({
    public_path = string
    content_version = number
  })
}

variable "azure" {
  type = object({
    public_path = string
    content_version = number
  })
}