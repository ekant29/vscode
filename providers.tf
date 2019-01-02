provider "azurevm" 
{
    azure_subscription_id = "${var.azure_subscription_id}"
    azure_client_id = "${var.azure_subscription_id}"
    azure_client_secret = "${var.azure_subscription_id}"
    azure_tenant_id = "${var.azure_tenant_id}"
}