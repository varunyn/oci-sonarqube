# Create a Virtual Cloud Network

module "vcn" {
  source              = "./modules/vcn"
  tenancy_ocid        = var.tenancy_ocid
  compartment_ocid    = var.compartment_ocid
  availability_domain = var.availability_domain
}

# Creates Compute Instance

module "compute" {
  source                  = "./modules/compute"
  tenancy_ocid            = var.tenancy_ocid
  compartment_ocid        = var.compartment_ocid
  availability_domain     = var.availability_domain
  image_id                = lookup(data.oci_core_images.InstanceImageOCID.images[0], "id")
  public_ssh_key          = var.ssh_public_key
  subnet1_ocid            = module.vcn.subnet_ocid
  shape                   = var.node_shape
  flex_shape_ocpus        = var.node_flex_shape_ocpus
  flex_shape_memory       = var.node_flex_shape_memory
  generate_public_ssh_key = var.generate_public_ssh_key
}

module "remote-exec" {
  source        = "./modules/remote"
  public-ip1    = module.compute.public_ip
  instance_user = var.instance_user
  private_key   = module.compute.generated_private_key_pem
}
