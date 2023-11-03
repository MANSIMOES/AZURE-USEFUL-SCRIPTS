# Variables
$url = "https://localhost:7245/WeatherForecast/upload"
$filePath = "C:\Users\mnova\source\repos\WebApplicationAPI\test_data.json"
$token = "kas01pt"

# Create a multi-part form content boundary
$boundary = [System.Guid]::NewGuid().ToString()
$LF = "`r`n"

# Create the multi-part form content body
$bodyLines = (
    "--$boundary",
    "Content-Disposition: form-data; name=`"file`"; filename=`"$filePath`"",
    "Content-Type: application/octet-stream$LF",
    [System.IO.File]::ReadAllText($filePath),
    "--$boundary--$LF"
) -join $LF

# Convert the body to bytes
$bodyBytes = [System.Text.Encoding]::UTF8.GetBytes($bodyLines)

# Make the POST request
$response = Invoke-WebRequest -Uri $url -Method POST -Headers @{"token" = $token} -ContentType "multipart/form-data; boundary=$boundary" -Body $bodyBytes

# Display the response
$response.Content
