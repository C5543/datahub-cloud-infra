terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "feaac8e8-d6f6-4f8f-820f-49751ccbf410"
}

resource "azurerm_resource_group" "rg" {
  name     = "datahub-rg"
  location = "norwayeast"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "datahub-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "web" {
  name                 = "datahub-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "nsg" {
  name                = "datahub-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "allow-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-datahub-ui"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "9002"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = azurerm_subnet.web.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_public_ip" "pip" {
  name                = "datahub-public-ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic" {
  name                = "datahub-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.web.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = "datahub-vm"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  size                = "Standard_D2s_v3"
  admin_username      = "azureuser"

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("ssh-keys/terraform-azure.pub")
  }

  network_interface_ids = [azurerm_network_interface.nic.id]

  os_disk {
    name                 = "datahub-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 50
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  custom_data = base64encode(file("script/customdata.sh"))
}

output "datahub_vm_public_ip" {
  value = azurerm_public_ip.pip.ip_address
}

output "datahub_ui_url" {
  value = "http://${azurerm_public_ip.pip.ip_address}:9002"
}

resource "azurerm_postgresql_flexible_server" "datahub_db" {
  name                   = "datahub-postgres"
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  version                = "16"
  administrator_login    = "datahubadmin"
  administrator_password = "StrongPassword123!"  # غيّرها
  storage_mb             = 32768
  sku_name               = "B_Standard_B1ms"
  zone                   = "1"

  backup_retention_days = 7

  tags = {
    environment = "DataHub"
  }
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_vm" {
  name      = "allow-vm"
  server_id = azurerm_postgresql_flexible_server.datahub_db.id

  start_ip_address = azurerm_public_ip.pip.ip_address
  end_ip_address   = azurerm_public_ip.pip.ip_address
}

