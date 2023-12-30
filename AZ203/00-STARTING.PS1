# Navigate to the root folder
Set-Location C:\Users\mnova\source
# Remove the existing folder dp-203 (if any)
Remove-Item -r dp-203 -f
# Clone the latest version of the repo
git clone https://github.com/MicrosoftLearning/dp-203-azure-data-engineer dp-203
# Navigate into the new folder
Set-Location dp-203/Allfiles/labs/01
# Run the setup script
./setup.ps1