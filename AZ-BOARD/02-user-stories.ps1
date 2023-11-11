# Base64 encode the Personal Access Token (PAT)
$patToken = "asasaaasaaas"
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$patToken"))

# Set the header with the encoded PAT
$headers = @{
    Authorization = "Basic $base64AuthInfo"
}

# API endpoint for creating user stories
$apiUrlTemplate = "https://dev.azure.com/mansimoes/GoOne06/_apis/wit/workitems/`$User Story?api-version=6.0"

# Path to the JSON file containing the payloads
$jsonFilePath = "C:\Users\mnova\source\gitlab\mans\AZ-BOARD\CombinedUserStories.json"

# Read the JSON content from the file
$jsonFileContent = Get-Content -Path $jsonFilePath -Raw
$jsonPayloads = $jsonFileContent | ConvertFrom-Json

# Loop through each payload and send it to the Azure DevOps API
foreach ($jsonPayload in $jsonPayloads) {
    # Convert the user story object back to JSON
    $jsonPayloadString = $jsonPayload | ConvertTo-Json -Depth 10

    try {
        # Make the REST call
        $response = Invoke-RestMethod -Uri $apiUrlTemplate -Method Post -Headers $headers -Body $jsonPayloadString -ContentType "application/json-patch+json"
        
        # Output the response
        Write-Host "User Story created: " $response.id
    }
    catch {
        Write-Host "Error creating user story: $_"
    }
}
