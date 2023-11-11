# Variables
$url = "https://localhost:7245/WeatherForecast/upload"
$filePath = "C:\Users\mnova\source\repos\WebApplicationAPI\test_data.json"
$token = "kas01pt"

# Make the POST request
$response = Invoke-RestMethod -Uri $url -Method POST -InFile $filePath -Headers @{"token" = $token} -ContentType "multipart/form-data"

# Display the response
$response
