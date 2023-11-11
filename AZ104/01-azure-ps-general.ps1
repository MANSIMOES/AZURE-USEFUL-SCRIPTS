# Azure PowerShell Commands for Visual Code Collection

# Import Azure module
Import-Module Az

# Log in to Azure
Login-AzAccount

# List all Azure subscriptions available to your account
Get-AzSubscription

# Set a specific subscription to be the current active subscription
Set-AzContext -Subscription "Subscription Name or ID"

# List all resource groups in your subscription
Get-AzResourceGroup

# Create a new resource group
New-AzResourceGroup -Name "ResourceGroupName" -Location "LocationName"

# Delete a resource group
Remove-AzResourceGroup -Name "ResourceGroupName" -Force

# List all virtual machines in a resource group
Get-AzVM -ResourceGroupName "ResourceGroupName"

# Create a virtual machine
# Note: This is a basic example; VM creation can have many more parameters
New-AzVm -ResourceGroupName "ResourceGroupName" -Name "VMName" -Location "LocationName" -VirtualNetworkName "VNetName" -SubnetName "SubnetName" -SecurityGroupName "NSGName" -PublicIpAddressName "IPName"

# Start a virtual machine
Start-AzVM -ResourceGroupName "ResourceGroupName" -Name "VMName"

# Stop a virtual machine
Stop-AzVM -ResourceGroupName "ResourceGroupName" -Name "VMName" -Force

# Delete a virtual machine
Remove-AzVM -ResourceGroupName "ResourceGroupName" -Name "VMName" -Force

# List all storage accounts in a resource group
Get-AzStorageAccount -ResourceGroupName "ResourceGroupName"

# Create a storage account
New-AzStorageAccount -ResourceGroupName "ResourceGroupName" -Name "StorageAccountName" -Location "LocationName" -SkuName "Standard_LRS"

# List all blob containers in a storage account
Get-AzStorageContainer -Context (Get-AzStorageAccountKey -ResourceGroupName "ResourceGroupName" -Name "StorageAccountName").Context

# Create a blob container in a storage account
New-AzStorageContainer -Name "ContainerName" -Context (Get-AzStorageAccountKey -ResourceGroupName "ResourceGroupName" -Name "StorageAccountName").Context
