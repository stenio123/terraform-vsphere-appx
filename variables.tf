variable "disk_size" {
	description = "Size in GB of the Root Disk"
	default = "35"
}
variable "vm_name" {
	description = "Application Name"
}
variable "cpu_count" {
	description = "Number of CPUs"
	default = "2"
}
variable "memory" {
	description = "Memory size in MB"
	default = "1024"
}
variable "vm_count" {
	description = "Number of VMs to create for this application"
	default = "2"
}
variable "tag_name" {
	description = "Tag to include, values can be Production or Staging"
	default = "Staging"
}

variable "vmfolder" {
	description = "Folder to store VM"
	default = "Stenio-demo"
}

// Attribute Name 
variable "attribute" {
  description = "The attribute Name"
  default = "fromTerraform"
}

// Attribute Name 
variable "attributeValue" {
  description = "The attribute value"
  default = "yes"
}

variable "prefix" {
  description = "Prefix value"
  default = "demo-"
}
// VM Name
variable "tagCategory" {
  description = "The Tag Category Name"
  default = "Customer"
}

// VM Name prefix 
variable "tag" {
  description = "The Tag Name"
  default ="Stenio"
}