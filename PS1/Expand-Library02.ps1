#PowerShell

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