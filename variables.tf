variable "namespaces" {
  description = "A map of namespace names and their properties"
  type = map(object({
    name                          = string
    location                      = string
    sku                           = string
    capacity                      = optional(number)
    auto_inflate_enabled          = optional(bool)
    maximum_throughput_units      = optional(number)
    public_network_access_enabled = optional(bool)
  }))
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "eventhubs" {
  description = "A map of event hub names and their properties"
  type = map(object({
    name                = string
    namespace_name      = string
    partitions          = number
    message_retention   = number
    capture_enabled     = optional(bool)
    capture_encoding    = optional(string)
    blob_container_name = optional(string)
    storage_account_id  = optional(string)
    destination_name    = optional(string)
    archive_name_format = optional(string)
  }))
}
