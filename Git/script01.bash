# Configure the credential helper to store credentials on Windows
git config --global credential.helper wincred

# Login to GitHub
git config --global user.name "MANSIMOES"
git config --global user.email "m.novaisimoes@gmail.com"

# Clone the repository
git clone https://mansimoes@dev.azure.com/mansimoes/eShopOnWeb/_git/eShopOnWeb

# Commit and push
git add .
git commit -m "Initial commit"
git push origin master

# Create a new branch
git checkout -b feature01

# Add stagged changes to the branch
git add .
git commit -m "Add feature 01"
git push origin feature01

# Merge branch to master
git checkout master
git merge feature01
git push origin master

# Unstage changes
git reset HEAD <file>

# Undo changes
git checkout -- <file>

# Delete branch locally
git branch -d feature01


# delete branch 
git branch -d feature01

# create a pull request
git checkout -b feature01
git add .
git commit -m "Add feature 01"
git push origin feature01

# create a pull request
git checkout master
git merge feature01
git push origin master

# fetch and merge
git fetch origin
git merge origin/main

git branch -d feature/my-changes  # delete locally
git push origin --delete feature/my-changes  # delete on remote

