#PowerShell

Add-Type -AssemblyName System.Windows.Forms
$DirectorySource = New-Object System.Windows.Forms.FolderBrowserDialog
[void]$DirectorySource.ShowDialog()

$DirectorySourceString = $DirectorySource.SelectedPath

if ( Test-Path -Path $DirectorySourceString -PathType Container ) { 
    Get-ChildItem $DirectorySourceString -Filter *.zip | 
        Foreach-Object {
            Expand-Archive -LiteralPath $_.FullName -DestinationPath $DirectorySourceString
        }
}else {
        Write-Output "It's not a containter/folder/directory"
    }