provider "vsphere" {
  # If you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_virtual_machine" "template" {
  name          = "${var.vsphere_virtual_machine_template}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_datacenter" "dc" {
  name = "${var.vsphere_datacenter}"
}

data "vsphere_datastore" "datastore" {
  name          = "${var.vsphere_datastore}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_compute_cluster" "cluster" {
  name          = "${var.vsphere_compute_cluster}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "${var.vsphere_network}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

// Folders and tags
// Create Folder
resource "vsphere_folder" "folder" {
  path          = "${var.prefix}${var.vmfolder}"
  type          = "vm"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
  tags          = ["${vsphere_tag.tag.id}"]

  //custom_attributes = "${map(vsphere_custom_attribute.attribute.id, "${var.attributeValue}")}"
}

// Apply attribute to the folder
// https://www.terraform.io/docs/providers/vsphere/r/custom_attribute.html
resource "vsphere_custom_attribute" "attribute" {
  name                = "${var.prefix}${var.attribute}"
  managed_object_type = "Folder"
}

// vSphere Tag Category (SINGLE or MULTIPLE)
resource "vsphere_tag_category" "category" {
  name        = "${var.tagCategory}"
  description = "Managed by Terraform"
  cardinality = "MULTIPLE"

  // The types of objects this tag can be associated with.
  associable_types = [
    "VirtualMachine",
    "Folder",
  ]
}

// vSphere Tag
resource "vsphere_tag" "tag" {
  name        = "${var.tag}"
  category_id = "${vsphere_tag_category.category.id}"
  description = "Managed by Terraform"
}
// Vms

resource "vsphere_virtual_machine" "vm" {
  name                        = "${var.vm_name}_${count.index + 1}"
  resource_pool_id            = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"
  folder                      = "${vsphere_folder.folder.path}"
  datastore_id                = "${data.vsphere_datastore.datastore.id}"
  count                       = "${var.vm_count}"
  num_cpus                    = "${var.cpu_count}"
  memory                      = "${var.memory}"
  guest_id                    = "ubuntu64Guest"
  wait_for_guest_net_routable = false
  wait_for_guest_net_timeout  = 0

  network_interface {
    network_id = "${data.vsphere_network.network.id}"
  }

  tags = ["${vsphere_tag.tag.id}"]

  disk {
    label            = "disk0"
    size             = "${var.disk_size}"
    thin_provisioned = true
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    customize {
      network_interface {}

      ipv4_gateway    = "10.100.0.1"
      dns_server_list = ["8.8.8.8"]

      linux_options {
        host_name = "${var.vm_name}"
        domain    = "vsphere.local"
      }
    }
  }
}
