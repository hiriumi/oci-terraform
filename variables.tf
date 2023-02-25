variable "compartment_id" {
  description = "OCID from your tenancy page"
  type        = string
}
variable "region" {
  description = "region where you have OCI tenancy"
  type        = string
  default     = "us-ashburn-1"
}

variable "internet_gateway_enabled" {
    type = string
    default = "true"
}

variable "internet_gateway_display_name" {
    type = string
    default = "Ashburn Internet Gateway"
}