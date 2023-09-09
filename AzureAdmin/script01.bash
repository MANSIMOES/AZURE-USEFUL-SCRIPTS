# Azure CLI Commands for Visual Code Collection

# Log in to Azure
az login

# List all Azure subscriptions available to your account
az account list --output table

# Set a specific subscription to be the current active subscription
az account set --subscription "Subscription Name or ID"

# List all resource groups in your subscription
az group list --output table

# Create a new resource group
az group create --name "ResourceGroupName" --location "LocationName"

# Delete a resource group
az group delete --name "ResourceGroupName" 

# List all virtual machines in a resource group
az vm list --resource-group "ResourceGroupName" --output table

# Create a virtual machine
# Note: This is a basic example; VM creation can have many more parameters
az vm create \
  --resource-group "ResourceGroupName" \
  --name "VMName" \
  --image "Canonical:UbuntuServer:18.04-LTS:latest" \
  --admin-username "YourUsername" \
  --generate-ssh-keys

# Start a virtual machine
az vm start --resource-group "ResourceGroupName" --name "VMName"

# Stop a virtual machine
az vm stop --resource-group "ResourceGroupName" --name "VMName"

# Delete a virtual machine
az vm delete --resource-group "ResourceGroupName" --name "VMName"

# List all available VM sizes in a region
az vm list-sizes --location "LocationName" --output table

# List all storage accounts in a resource group
az storage account list --resource-group "ResourceGroupName" --output table

# List all available locations/regions
az account list-locations --output table

# Create a storage account
az storage account create --name "StorageAccountName" --resource-group "ResourceGroupName" --location "LocationName" --sku "Standard_LRS"

# List keys of a storage account
az storage account keys list --account-name "StorageAccountName" --resource-group "ResourceGroupName"

# Create a blob container in a storage account
az storage container create --name "ContainerName" --account-name "StorageAccountName" --auth-mode login

# Upload a file to a blob container
az storage blob upload --container-name "ContainerName" --name "BlobName" --type "ContentType" --account-name "StorageAccountName" --type text/plain -f "PathToFile"

# List Azure Kubernetes Service (AKS) clusters
az aks list --resource-group "ResourceGroupName" --output table

# Create a basic managed Kubernetes cluster (AKS)
az aks create --resource-group "ResourceGroupName" --name "ClusterName" --node-count 1 --enable-addons monitoring --generate-ssh-keys

# Get credentials to manage AKS cluster
az aks get-credentials --resource-group "ResourceGroupName" --name "ClusterName"

# List Azure Web Apps (App Services)
az webapp list --resource-group "ResourceGroupName" --output table

# Create an App Service plan
az appservice plan create --name "PlanName" --resource-group "ResourceGroupName" --sku B1 --is-linux

# Create a Web App in the App Service plan
az webapp create --resource-group "ResourceGroupName" --plan "PlanName" --name "WebAppName" --runtime "RUNTIME_VALUE"  # e.g., "NODE|10.14"

# List all Azure SQL Databases in a resource group
az sql db list --resource-group "ResourceGroupName" --server "ServerName" --output table

# List all virtual networks in a resource group
az network vnet list --resource-group "ResourceGroupName" --output table

# List all subnets in a virtual network
az network vnet subnet list --resource-group "ResourceGroupName" --vnet-name "VNetName" --output table


