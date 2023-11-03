# Specify the directory path you want to analyze
$directoryPath = "C:\Users\mnova\source\repos"

# Function to calculate the total size of a directory, including subdirectories
function Get-DirectorySize {
    param(
        [string]$path
    )

    # Check if the directory exists
    if (-not (Test-Path $path)) {
        throw "Directory '$path' does not exist."
    }

    # Check if the user has permission to access the directory
    try {
        $acl = Get-Acl $path
    } catch {
        throw "You do not have permission to access directory '$path'."
    }

    # Calculate the size of the directory and all its subdirectories
    $size = 0
    Get-ChildItem -Path $path -File -Recurse -Depth 5 | ForEach-Object -Begin {
        # Initialize the progress bar
        $progress = 0
        Write-Progress -Activity "Calculating directory size" -Status "Progress" -PercentComplete 0
    } -Process {
        $size += $_.Length

        # Update the progress bar
        $progress += $_.Length
        $percentComplete = [int](($progress / $size * 100))
        if ($percentComplete -le 100) {
            Write-Progress -Activity "Calculating directory size" -Status "Progress" -PercentComplete $percentComplete
        }
    } -End {
        # Clear the progress bar
        Write-Progress -Activity "Calculating directory size" -Completed
    }

    return $size
}

# Get the size of the specified directory
try {
    $totalSize = (Get-ChildItem -Path $directoryPath -File -Recurse | Measure-Object -Property Length -Sum).Sum
    $directorySize = Get-DirectorySize -path $directoryPath
} catch {
    Write-Host $_
    return
}

# Create a custom object for the specified directory
$directoryObject = [PSCustomObject]@{
    "Directory" = $directoryPath
    "Bytes" = $directorySize
    "KB" = [math]::Round($directorySize / 1KB, 2)
    "MB" = [math]::Round($directorySize / 1MB, 2)
    "GB" = [math]::Round($directorySize / 1GB, 2)
}

# Display the directory name and its respective size
$directoryObjects = Get-ChildItem -Path $directoryPath -Directory | ForEach-Object {
    $size = Get-DirectorySize -path $_.FullName
    [PSCustomObject]@{
        "Directory" = $_.FullName
        "Bytes" = $size
        "KB" = [math]::Round($size / 1KB, 2)
        "MB" = [math]::Round($size / 1MB, 2)
        "GB" = [math]::Round($size / 1GB, 2)
    }
}

# Combine the custom objects into a single array and display the results in a table
$allObjects = $directoryObject,$directoryObjects
$allObjects | Format-Table -AutoSize