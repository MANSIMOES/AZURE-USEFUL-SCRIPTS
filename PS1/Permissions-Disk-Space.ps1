# Define the directory path and the username/group and permissions
$directoryPath = "C:\Program Files"
$username = "mans"
$permissions = "FullControl"

# Check if the directory exists
if (Test-Path -Path $directoryPath -PathType Container) {
    # Get the current ACL (Access Control List) of the directory
    $acl = Get-Acl -Path $directoryPath

    # Create a new rule with the specified permissions and username/group
    $rule = New-Object System.Security.AccessControl.FileSystemAccessRule($username, $permissions, "ContainerInherit, ObjectInherit", "None", "Allow")

    # Add the rule to the ACL
    $acl.AddAccessRule($rule)

    # Apply the modified ACL to the directory
    Set-Acl -Path $directoryPath -AclObject $acl

    Write-Host "Permissions granted successfully to $username for $directoryPath."
} else {
    Write-Host "Directory $directoryPath does not exist."
}
