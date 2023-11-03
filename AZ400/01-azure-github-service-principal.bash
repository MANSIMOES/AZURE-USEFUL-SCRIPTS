# Create an Azure Service Principal and save it as GitHub secret
# Creates a new Azure service principal with the name "define-a-service-principal-name" and assigns the "contributor" role to it.
# The scope of the role assignment is the specified resource group within the specified subscription.
# The command also generates an authentication file in SDK format.
az ad sp create-for-rbac --name define-a-service-principal-name --role contributor --scopes /subscriptions/SUBSCRIPTION-ID/resourceGroups/RESOURCE-GROUP --sdk-auth