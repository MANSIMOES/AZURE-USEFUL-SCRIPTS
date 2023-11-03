az ad user list --query "[?mail == 'upn']"

az ad sp create-for-rbac --name MyServicePrincipal --role Contributor --scopes /subscriptions/<sub-id>
az ad sp delete --id <appId>

az ad sp delete --id $(az ad sp list --query "[?displayName == 'MyServicePrincipal'].appId" -o tsv)
