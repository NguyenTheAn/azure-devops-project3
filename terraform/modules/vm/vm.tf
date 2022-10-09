resource "azurerm_network_interface" "main" {
  name                = "project3"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_address_id
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  name                = "myVM"
  location            = var.location
  resource_group_name = var.resource_group
  size                = "Standard_DS2_v2"
  admin_username      = "ubuntu"
  source_image_id     = agent-image-20221009155223
  network_interface_ids = [azurerm_network_interface.main.id]
  admin_ssh_key {
    username   = "ubuntu"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDem/vLgDKALTOkT8PI1+N3TGerxE7ArviZrnBAwGd/cgFTfacYt9ZUVvJQ5GZIZCMHe5YLjN+8Yy5iJLxm1Nbi3fezRYNLb/cGt6esqSdDJ7YIVTPEORZ07e4hXiDcjazrz+K6jLbEMEUu279YKk3SQwQZUchaw9sKdBFjaayoKAvT6ljPh6xOS81jtbSbJu+m6kkYfJFjcb6UbR/eiFFoBI690i+Gw8gGHxcqw1grPH9pG7Ci8WhJWrV1l/k0W3qZ/Gwt6W50zTYoQv3oAPH0H28Pqjhi++Cbk1KwATNpaYyQkao/064BkLCYvLBkdZbUOE9wP6vVg2BAacBsTymd annt45@fsoft.com.vn"
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
