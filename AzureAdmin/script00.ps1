# Prerequisites

# Run the following command from PowerShell to determine your PowerShell version:
$PSVersionTable.PSVersion

Get-Module -Name PowerShellGet -ListAvailable | Select-Object -Property Name,Version,Path

# Determine if you have the AzureRM PowerShell module installed:
Get-Module -Name AzureRM -ListAvailable

Install-Module -Name Az -AllowClobber -Scope CurrentUser

Uninstall-Module -Name AzureRM -AllVersions -Force

# Set the PowerShell execution policy to remote signed:
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Use the Install-Module cmdlet to install the Az PowerShell module:
Install-Module -Name Az -Repository PSGallery -Force

# Use Update-Module to update to the latest version of the Az PowerShell module:
Import-Module Az

Update-Module -Name Az -Force
