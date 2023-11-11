# List Azure regions
az account list-locations -o table

# Search for regions containing the word "Europe" and display the results in a table
az account list-locations --query "[?contains(displayName, 'Europe')]" -o Table

# Search for a specific region by display name and display the results in a table
az account list-locations --query "[?displayName=='Central US']" -o Table

# Create a resource group
REGION='westeurope'
RESOURCEGROUPNAME='ResourceGroup01'
az group create -n $RESOURCEGROUPNAME -l $REGION