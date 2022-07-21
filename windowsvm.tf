resource "azurerm_network_interface" "eth0" {
  name = module.naming.network_interface.name
  resource_group_name = azurerm_resource_group.this.name
  location = azurerm_resource_group.this.location

  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.default.id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_windows_virtual_machine" "vm" {
    name = module.naming.windows_virtual_machine.name
    resource_group_name = azurerm_resource_group.this.name
    location = azurerm_resource_group.this.location

    size = "Standard_B2ms"
    admin_password = "kung_f00_fighting!"
    admin_username = "derek-admin"
    network_interface_ids = [
        azurerm_network_interface.eth0.id
    ]

    os_disk {
      caching = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    source_image_reference {
      publisher = "MicrosoftWindowsServer"
      offer = "WindowsServer"
      sku = "2019-Datacenter"
      version = "latest"
    }

    tags = local.tags
}