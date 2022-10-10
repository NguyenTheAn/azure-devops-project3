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
  network_interface_ids = [azurerm_network_interface.main.id]
  admin_ssh_key {
    username   = "ubuntu"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC//q+l3obww4eIYItZlIK0dVLSe6PMCa8heCPmvNAnhHvEpRYu8YksnDNxaqQvbKRZdpmR2kv4MxtjYbod2AciAeXrubtCD1N6mqicGkWZ12qe1FBoNmJEXPG4cycmkTBpNi99FKHX718cdmspJ7T2Ued3cChNHE/RoVRQyv6LyObfnWw9xutckfahStJEiOKaUfDp87V/5XjEAPmon9wKyiMlgVKEg5ziZRRwgfYH11lgGd6VBTZ7T0E3H3zgNt3dJgMnRlBmV47Ob3YhNXdGEho9/rcC0dSJ7JMABM4DNsdDbyMdZT/aNZcvI/U8eVdUx8lbXfnNNIdFaKidlmqqeV1AmaOjWbnIy5OErLYczxJgfAfI9lXVtKmE/2T71xJsY3XhtJghBkWS8Jg6BO5Re6AhNeoIlA1qAfzf7zj9aafRgtx8AYY9lBIh0nhEJLF8VaJgjYsy173G69vGNjQfdfUF0oyHqSA7k56tRVIbEA2PohpCdunUwQlBmcVt9A8= ann52999@gmail.com"
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
