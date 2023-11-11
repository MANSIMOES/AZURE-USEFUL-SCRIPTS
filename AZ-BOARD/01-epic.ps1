# Base64 encode the Personal Access Token (PAT)
$patToken = "asasasaaasasasas"
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$patToken"))

# Set the header with the encoded PAT
$headers = @{
    Authorization = "Basic $base64AuthInfo"
}

# API endpoint for creating the Epic
$apiUrl = "https://dev.azure.com/mansimoes/GoOne06/_apis/wit/workitems/`$Epic?api-version=6.0"

# JSON payload path
$jsonPayloadPath = "C:\Users\mnova\source\gitlab\mans\AZ-BOARD\epic.json"

# Read the JSON content
$jsonPayload = Get-Content -Path $jsonPayloadPath -Raw

# Make the REST call
$response = Invoke-RestMethod -Uri $apiUrl -Method Post -Headers $headers -Body $jsonPayload -ContentType "application/json-patch+json"

# Output the response
$response
