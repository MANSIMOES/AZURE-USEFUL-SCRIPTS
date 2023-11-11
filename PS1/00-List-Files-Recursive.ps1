# List all files in a directory and subdirectories recursively and display it in one single table by merging the data from all subdirectories.
# The script will also display the total number of files and the total size of all files.
# Usage: .\00-List-Files-Recursive.ps1 -Path "C:\Users\mnova\source\gitlab\mans\"

param (
    [Parameter(Mandatory=$true)]
    [string]$Path
)

# Function to format bytes to a more readable format
Function Format-Bytes {
    Param ([int64]$bytes)
    If ($bytes -gt 1PB) { [string]::Format("{0:0.00} PB", $bytes / 1PB) }
    ElseIf ($bytes -gt 1TB) { [string]::Format("{0:0.00} TB", $bytes / 1TB) }
    ElseIf ($bytes -gt 1GB) { [string]::Format("{0:0.00} GB", $bytes / 1GB) }
    ElseIf ($bytes -gt 1MB) { [string]::Format("{0:0.00} MB", $bytes / 1MB) }
    ElseIf ($bytes -gt 1KB) { [string]::Format("{0:0.00} KB", $bytes / 1KB) }
    Else { [string]::Format("{0} B", $bytes) }
}

# Get all files under the path recursively
$files = Get-ChildItem -Path $Path -Recurse -File

# Calculate total size
$totalSize = ($files | Measure-Object -Property Length -Sum).Sum

# Output the total number of files and total size
Write-Host "Total number of files: $($files.Count)"
Write-Host "Total size of all files: $(Format-Bytes -bytes $totalSize)"

# Generate file list table
$fileListTable = $files | Select-Object FullName, @{Name="Size";Expression={Format-Bytes -bytes $_.Length}}

# Display the file list table
$fileListTable | Format-Table -AutoSize

# If you want to output this to a file, remove the comment from the line below
# $fileListTable | Format-Table -AutoSize | Out-File "file_list.txt"

# End of script