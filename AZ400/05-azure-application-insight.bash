# Set variables for resource group and Application Insights name
resourceGroup="ResourceGroup01"
SUFFIX=MANS
appName=RGATES-$SUFFIX-DevTest

# Get resource group location
location=$(az group show --name $resourceGroup --query location --output tsv)

# Create Application Insights resource
az resource create \
    --resource-group $resourceGroup \
    --name $appName \
    --resource-type "Microsoft.Insights/components" \
    --location $location \
    --properties '{"Application_Type":"web"}'
