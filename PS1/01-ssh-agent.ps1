# List SSH keys in the SSH agent
ssh-add -l

# List SSH keys in the SSH agent with more detail
ssh-add -L

# List SSH agents running on the system with Get-Process
Get-Process ssh-agent

# Kill all SSH agents running on the system
killall ssh-agent

# Stop the SSH agent
Stop-Service ssh-agent

# Start the SSH agent
Start-Service ssh-agent

# Add your SSH key to the agent
ssh-add ~/.ssh/id_rsa
