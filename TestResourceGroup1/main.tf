resource "azurerm_resource_group" "Terraform-ARG" {
  name     = "TestResourceGroup1"
  location = "West US"
}

resource "azurerm_virtual_network" "Terraform-Vnet" {
    name                = "mytestVnet"
    address_space       = ["20.20.0.0/16"]
    location            = "West US"
    resource_group_name = "${azurerm_resource_group.Terraform-ARG.name}"
}

resource "azurerm_subnet" "Terraform-Subnet" {
    name                 = "mytestSubnet"
    resource_group_name  = "${azurerm_resource_group.Terraform-ARG.name}"
    virtual_network_name = "${azurerm_virtual_network.Terraform-Vnet.name}"
    address_prefix       = "20.20.1.0/24"
}

resource "azurerm_network_security_group" "Terraform-NSG" {
    name                = "mytestNetworkSecurityGroup"
    location            = "West US"
    resource_group_name = "${azurerm_resource_group.Terraform-ARG.name}"

    security_rule {
        name                       = "RDP"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "3389"
        source_address_prefix      = "20.20.1.0/24"
        destination_address_prefix = "20.20.1.0/24"
    }
}

resource "azurerm_network_interface" "Terraform-NetInterface" {
  name                = "${var.vm_hostname1}001-nic"
  location            = "${azurerm_resource_group.Terraform-ARG.location}"
  resource_group_name = "${azurerm_resource_group.Terraform-ARG.name}"

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = "${azurerm_subnet.Terraform-Subnet.id}"
    private_ip_address_allocation = "dynamic"
  }
}

#resource "random_id" "vm-sa" {
#  keepers = {
#    vm_hostname = "${var.vm_hostname}"
#  }

resource "azurerm_virtual_machine" "vm-windows" {
  name                  = "${var.vm_hostname1}001"
  location              = "${azurerm_resource_group.Terraform-ARG.location}"
  resource_group_name   = "${azurerm_resource_group.Terraform-ARG.name}"
  network_interface_ids = ["${azurerm_network_interface.Terraform-NetInterface.id}"]
  vm_size               = "Standard_DS1_v2"
  
  #We could also use below code to name server
  #name                  = "${var.prefix}-vm"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true


  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter-Server-Core-smalldisk"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_data_disk {
    name              = "datadisk_new"
    managed_disk_type = "Standard_LRS"
    create_option     = "Empty"
    lun               = 0
    disk_size_gb      = "1024"
  }

  os_profile {
    computer_name  = "${var.vm_hostname1}001"
    admin_username = "${var.admin_username}"
    admin_password = "${var.admin_password}"
   }
   os_profile_windows_config {}

}