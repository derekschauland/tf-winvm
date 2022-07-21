resource "azurerm_public_ip" "pip" {
    name = "bastionpip"
    location = azurerm_resource_group.this.location
    resource_group_name = azurerm_resource_group.this.name
    allocation_method = "Static"
    sku = "Standard"
}

resource "azurerm_bastion_host" "jump" {
name = module.naming.bastion_host.name
resource_group_name = azurerm_resource_group.this.name
location = azurerm_resource_group.this.location

ip_configuration {
  name = "jump_config"
  subnet_id = azurerm_subnet.bastion.id
  public_ip_address_id = azurerm_public_ip.pip.id

}
}