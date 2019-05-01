variable "vsphere_datacenter" {
	default = "PacketDatacenter"
}

variable "vsphere_compute_cluster" {
	default = "MainCluster"
}
variable "vsphere_datastore" {
	default = "datastore1"
}
variable "vsphere_network" {
	default = "VM Network"
}

variable "vsphere_virtual_machine_template" {
	default = "Ubuntu"
}

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

variable "vmfolder" {
	description = "Folder to store VM"
	default = "Stenio-demo"
}

variable "attribute" {
  description = "The attribute Name"
  default = "fromTerraform"
}

variable "attributeValue" {
  description = "The attribute value"
  default = "yes"
}

variable "prefix" {
  description = "Prefix value"
  default = "demo-"
}
variable "tagCategory" {
  description = "The Tag Category Name"
  default = "Customer"
}

variable "tag" {
  description = "The Tag Name"
  default ="Stenio"
}