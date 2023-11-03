# This script retrieves the name and ID of the current Azure subscription using the Azure CLI.
subscriptionName=$(az account show --query name --output tsv)
subscriptionId=$(az account show --query id --output tsv)

# The subscription name and ID are then printed to the console.
echo $subscriptionName
echo $subscriptionId

# The script then creates a new Azure service connection in Azure DevOps using the Azure CLI.
# Creates a new Azure AD service principal and assigns the "contributor" role to it for the specified subscription ID.
# The service principal is named "sp-az400-azdo".
# Replace $subscriptionId with the actual subscription ID.
az ad sp create-for-rbac --name sp-az400-azdo --role contributor --scopes /subscriptions/$subscriptionId

spId=$(az ad sp list --display-name sp-az400-azdo --query "[].id" --output tsv)
echo $spId
roleName=$(az role definition list --name "User Access Administrator" --query "[0].name" --output tsv)
echo $roleName
