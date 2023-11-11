# Create an App service plan
RESOURCEGROUPNAME='ResourceGroup01'
SERVICEPLANNAME='az400m04l09-sp1'
az appservice plan create -g $RESOURCEGROUPNAME -n $SERVICEPLANNAME --sku S1

# Create two web app
SUFFIX=MANS
az webapp create -g $RESOURCEGROUPNAME -p $SERVICEPLANNAME -n RGATES-$SUFFIX-DevTest
az webapp create -g $RESOURCEGROUPNAME -p $SERVICEPLANNAME -n RGATES-$SUFFIX-Prod

# Create a web app with a deployment slot
az webapp deployment slot create -g $RESOURCEGROUPNAME -p $SERVICEPLANNAME -n RGATES-$SUFFIX-DevTest --slot staging

# Create a web app with a deployment slot and a custom domain
az webapp deployment slot create -g $RESOURCEGROUPNAME -p $SERVICEPLANNAME -n RGATES-$SUFFIX-DevTest --slot staging
az webapp config hostname add -g $RESOURCEGROUPNAME -n RGATES-$SUFFIX-DevTest --hostname RGATES-$SUFFIX-DevTest.azurewebsites.net
az webapp config hostname add -g $RESOURCEGROUPNAME -n RGATES-$SUFFIX-DevTest --hostname RGATES-$SUFFIX-DevTest-staging.azurewebsites.net --slot staging

# Create a web app with a deployment slot and a custom domain and a certificate
az webapp deployment slot create -g $RESOURCEGROUPNAME -p $SERVICEPLANNAME -n RGATES-$SUFFIX-DevTest --slot staging
az webapp config hostname add -g $RESOURCEGROUPNAME -n RGATES-$SUFFIX-DevTest --hostname RGATES-$SUFFIX-DevTest.azurewebsites.net
az webapp config hostname add -g $RESOURCEGROUPNAME -n RGATES-$SUFFIX-DevTest --hostname RGATES-$SUFFIX-DevTest-staging.azurewebsites.net --slot staging
az webapp config ssl upload -g $RESOURCEGROUPNAME -n RGATES-$SUFFIX-DevTest --certificate-file ~/Downloads/az400m04l09-sslcert.pfx --certificate-password "P@ssw0rd1234"

# Create a web app with a deployment slot and a custom domain and a certificate and a traffic routing
az webapp deployment slot create -g $RESOURCEGROUPNAME -p $SERVICEPLANNAME -n RGATES-$SUFFIX-DevTest --slot staging
az webapp config hostname add -g $RESOURCEGROUPNAME -n RGATES-$SUFFIX-DevTest --hostname RGATES-$SUFFIX-DevTest.azurewebsites.net
az webapp config hostname add -g $RESOURCEGROUPNAME -n RGATES-$SUFFIX-DevTest --hostname RGATES-$SUFFIX-DevTest-staging.azurewebsites.net --slot staging
az webapp config ssl upload -g $RESOURCEGROUPNAME -n RGATES-$SUFFIX-DevTest --certificate-file ~/Downloads/az400m04l09-sslcert.pfx --certificate-password "P@ssw0rd1234"
az webapp config ssl bind -g $R

# Create a Traffic Manager
az network traffic-manager profile create -g $RESOURCEGROUPNAME -n RGATES-$SUFFIX-DevTest-TrafficManager --routing-method Weighted --unique-dns-name RGATES-$SUFFIX-DevTest-TrafficManager --ttl 30

# Create a Traffic Manager with endpoints
az network traffic-manager endpoint create -g $RESOURCEGROUPNAME --profile-name RGATES-$SUFFIX-DevTest-TrafficManager -n RGATES-$SUFFIX-DevTest-TrafficManager-DevTest --type azureEndpoints --target-resource-id /subscriptions/0b1f6471-1bf0-4dda-aec3-cb9272f09590/resourceGroups/ResourceGroup01/providers/Microsoft.Web/sites/RGATES-$SUFFIX-DevTest --endpoint-status enabled --weight 1 --priority 1
az network traffic-manager endpoint create -g $RESOURCEGROUPNAME --profile-name RGATES-$SUFFIX-DevTest-TrafficManager -n RGATES-$SUFFIX-DevTest-TrafficManager-Prod --type azureEndpoints --target-resource-id /subscriptions/0b1f6471-1bf0-4dda-aec3-cb9272f09590/resourceGroups/ResourceGroup01/providers/Microsoft.Web/sites/RGATES-$SUFFIX-Prod --endpoint-status enabled --weight 1 --priority 2

# Create a Traffic Manager with endpoints and a custom domain
az network traffic-manager endpoint create -g $RESOURCEGROUPNAME --profile-name RGATES-$SUFFIX-DevTest-TrafficManager -n RGATES-$SUFFIX-DevTest-TrafficManager-DevTest --type azureEndpoints --target-resource-id /subscriptions/0b1f6471-1bf0-4dda-aec3-cb9272f09590/resourceGroups/ResourceGroup01/providers/Microsoft.Web/sites/RGATES-$SUFFIX-DevTest --endpoint-status enabled --weight 1 --priority 1
az network traffic-manager endpoint create -g $RESOURCEGROUPNAME --profile-name RGATES-$SUFFIX-DevTest-TrafficManager -n RGATES-$SUFFIX-DevTest-TrafficManager-Prod --type azureEndpoints --target-resource-id /subscriptions/0b1f6471-1bf0-4dda-aec3-cb9272f09590/resourceGroups/ResourceGroup01/providers/Microsoft.Web/sites/RGATES-$SUFFIX-Prod --endpoint-status enabled --weight 1 --priority 2
az network traffic-manager profile update -g $RESOURCEGROUPNAME -n RGATES-$SUFFIX-DevTest-TrafficManager --routing-method Weighted --unique-dns-name RGATES-$SUFFIX-DevTest-TrafficManager --ttl 30 --monitor-path / --monitor-port 80 --monitor-protocol HTTP

# Create a Traffic Manager with endpoints and a custom domain and a certificate
az network traffic-manager endpoint create -g $RESOURCEGROUPNAME --profile-name RGATES-$SUFFIX-DevTest-TrafficManager -n RGATES-$SUFFIX-DevTest-TrafficManager-DevTest --type azureEndpoints --target-resource-id /subscriptions/0b1f6471-1bf0-4dda-aec3-cb9272f09590/resourceGroups/ResourceGroup01/providers/Microsoft.Web/sites/RGATES-$SUFFIX-DevTest --endpoint-status enabled --weight 1 --priority 1
az network traffic-manager endpoint create -g $RESOURCEGROUPNAME --profile-name RGATES-$SUFFIX-DevTest-TrafficManager -n RGATES-$SUFFIX-DevTest-TrafficManager-Prod --type azureEndpoints --target-resource-id /subscriptions/0b1f6471-1bf0-4dda-aec3-cb9272f09590/resourceGroups/ResourceGroup01/providers/Microsoft.Web/sites/RGATES-$SUFFIX-Prod --endpoint-status enabled --weight 1 --priority 2
az network traffic-manager profile update -g $RESOURCEGROUPNAME -n RGATES-$SUFFIX-DevTest-TrafficManager --routing-method Weighted --unique-dns-name RGATES-$SUFFIX-DevTest-TrafficManager --ttl 30 --monitor-path / --monitor-port 80 --monitor-protocol HTTP
az network traffic-manager profile create -g $RESOURCEGROUPNAME -n RGATES-$SUFFIX-DevTest-TrafficManager --routing-method Weighted --unique-dns-name RGATES-$SUFFIX-DevTest-TrafficManager --ttl 30

# Create a Traffic Manager with endpoints and a custom domain and a certificate and a traffic routing
az network traffic-manager endpoint create -g $RESOURCEGROUPNAME --profile-name RGATES-$SUFFIX-DevTest-TrafficManager -n RGATES-$SUFFIX-DevTest-TrafficManager-DevTest --type azureEndpoints --target-resource-id /subscriptions/0b1f6471-1bf0-4dda-aec3-cb9272f09590/resourceGroups/ResourceGroup01/providers/Microsoft.Web/sites/RGATES-$SUFFIX-DevTest --endpoint-status enabled --weight 1 --priority 1
az network traffic-manager endpoint create -g $RESOURCEGROUPNAME --profile-name RGATES-$SUFFIX-DevTest-TrafficManager -n RGATES-$SUFFIX-DevTest-TrafficManager-Prod --type azureEndpoints --target-resource-id /subscriptions/0b1f6471-1bf0-4dda-aec3-cb9272f09590/resourceGroups/ResourceGroup01/providers/Microsoft.Web/sites/RGATES-$SUFFIX-Prod --endpoint-status enabled --weight 1 --priority 2
az network traffic-manager profile update -g $RESOURCEGROUPNAME -n RGATES-$SUFFIX-DevTest-TrafficManager --routing-method Weighted --unique-dns-name RGATES-$SUFFIX-DevTest-TrafficManager --ttl 30 --monitor-path / --monitor-port 80 --monitor-protocol HTTP
az network traffic-manager profile create -g $RESOURCEGROUPNAME -n RGATES-$SUFFIX-DevTest-TrafficManager --routing-method Weighted --unique-dns-name RGATES-$SUFFIX-DevTest-TrafficManager --ttl 30

# Create Application Insights
az resource create -g $RESOURCEGROUPNAME -n RGATES-$SUFFIX-DevTest-AppInsights -l westeurope --resource-type "Microsoft.Insights/components" --properties '{"Application_Type":"web"}'