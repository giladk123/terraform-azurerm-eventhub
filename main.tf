resource "azurerm_eventhub_namespace" "namespace" {
  for_each = var.namespaces

  name                     = each.value.name
  location                 = each.value.location
  resource_group_name      = var.resource_group_name
  sku                      = each.value.sku
  capacity                 = each.value.capacity
  auto_inflate_enabled     = each.value.auto_inflate_enabled
  maximum_throughput_units = each.value.maximum_throughput_units

}

resource "azurerm_eventhub" "eventhub" {
  for_each = var.eventhubs

  name                = each.value.name
  namespace_name      = azurerm_eventhub_namespace.namespace[each.value.namespace_name].name
  resource_group_name = var.resource_group_name
  partition_count     = each.value.partitions
  message_retention   = each.value.message_retention

  dynamic "capture_description" {
    for_each = each.value.capture_enabled ? [1] : []
    content {
      enabled  = each.value.capture_enabled
      encoding = each.value.capture_encoding
      destination {
        name                = "EventHubArchive.AzureBlockBlob"
        archive_name_format = "{Namespace}/{EventHub}/{PartitionId}/{Year}/{Month}/{Day}/{Hour}/{Minute}/{Second}"
        blob_container_name = each.value.blob_container_name
        storage_account_id  = each.value.storage_account_id
      }
    }
  }
}