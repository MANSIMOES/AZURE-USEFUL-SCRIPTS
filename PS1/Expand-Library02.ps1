<#
.SYNOPSIS
Expands archives from a source directory to a target directory.

.DESCRIPTION
This script prompts the user to select a source and target directory using the Windows Forms FolderBrowserDialog. It then searches for archives in the source directory that match the pattern '*takeout-20200927T11*' and expands them to the target directory using the Expand-Archive cmdlet.

.PARAMETER DirectorySource
The source directory to search for archives.

.PARAMETER DirectoryTarget
The target directory to expand archives to.

.EXAMPLE
PS C:\> Expand-Library02.ps1
This example prompts the user to select a source and target directory using the Windows Forms FolderBrowserDialog. It then searches for archives in the source directory that match the pattern '*takeout-20200927T11*' and expands them to the target directory using the Expand-Archive cmdlet.

.NOTES
Author: Marcos NOVAIS SIMOES
Date: Unknown
#>
Add-Type -AssemblyName System.Windows.Forms

$DirectorySource = New-Object System.Windows.Forms.FolderBrowserDialog
[void]$DirectorySource.ShowDialog()
$DirectorySourceString = $DirectorySource.SelectedPath

$DirectoryTarget = New-Object System.Windows.Forms.FolderBrowserDialog
[void]$DirectoryTarget.ShowDialog()
$DirectoryTargetString = $DirectoryTarget.SelectedPath

if ( Test-Path -Path $DirectorySourceString -PathType Container) { 
    Get-ChildItem $DirectorySourceString | Where-Object {$_.FullName -like '*takeout-20200927T11*'} | 
        Foreach-Object {
            #Write-Output $_.FullName
            Expand-Archive -LiteralPath $_.FullName -DestinationPath $DirectoryTargetString
        }
}else {
        Write-Output "It's not a containter/folder/directory"
    }