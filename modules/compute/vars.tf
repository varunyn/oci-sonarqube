# Variables passed into compute module

variable "tenancy_ocid" {}
variable "compartment_ocid" {}
variable "availability_domain" {}
variable "subnet1_ocid" {}

variable "generate_public_ssh_key" {}

variable "public_ssh_key" {
  description = "Public SSH keys path to be included in the ~/.ssh/authorized_keys file for the default user on the instance. "
  default     = ""
}
variable "image_id" {
  description = "The OCID of an image for an instance to use. "
  default     = ""
}
variable "shape" {
  default = "VM.Standard.E3.Flex"
}
variable "flex_shape_ocpus" {
  default = 1
}

variable "flex_shape_memory" {
  default = 10
}

locals {
  compute_flexible_shapes = [
    "VM.Standard.E3.Flex",
    "VM.Standard.E4.Flex"
  ]
}


locals {
  is_flexible_node_shape = contains(local.compute_flexible_shapes, var.shape)
}

