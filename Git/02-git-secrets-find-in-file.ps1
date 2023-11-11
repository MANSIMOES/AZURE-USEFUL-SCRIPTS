# Change to your preferred installation directory
Set-Location C:\Users\mnova\source

# Clone the git-secrets repository
git clone https://github.com/awslabs/git-secrets.git

# Navigate to the git-secrets directory
Set-Location git-secrets

# Install git-secrets
./install.ps1

# Make the git-secrets script executable
# chmod +x git-secrets

# Install git-secrets to your git directory
git secrets --install

# Add git-secrets to your PATH (if needed):
$path = "C:\path\to\your\installation\directory\git-secrets"
$env:PATH += ";$path"
[Environment]::SetEnvironmentVariable("PATH", $env:PATH, [EnvironmentVariableTarget]::User)

# Scan your repo for secrets
git secrets --scan --recursive