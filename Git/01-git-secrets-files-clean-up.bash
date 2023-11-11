# Removing sensitive data from a repository: 
    # https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository
    # If you commit sensitive data, such as a password or SSH key into a Git repository, you can remove it from the history. 
    # To entirely remove unwanted files from a repository's history you can use either the git filter-repo tool or the BFG Repo-Cleaner open source tool.

# Purging a file from your repository's history - Using the BFG
    # The BFG Repo-Cleaner is a simpler, faster alternative to git-filter-branch for cleansing bad data out of your Git repository history:

    # To remove your file with sensitive data and leave your latest commit untouched, run
        bfg --delete-files YOUR-FILE-WITH-SENSITIVE-DATA

    # To replace all text listed in passwords.txt wherever it can be found in your repository's history, run:
        bfg --replace-text passwords.txt

    # After the sensitive data is removed, you must force push your changes to GitHub. 
        # Force pushing rewrites the repository history, which removes sensitive data from the commit history. 
        # If you force push, it may overwrite commits that other people have based their work on.
        git push --force

# Using git filter-repo
    # Warning: If you run git filter-repo after stashing changes, you won't be able to retrieve your changes with other stash commands. 
    # Before running git filter-repo, we recommend unstashing any changes you've made. 
    # To unstash the last set of changes you've stashed, run git stash show -p | git apply -R. For more information, see Git Tools - Stashing and Cleaning.

    # Install the latest release of the git filter-repo tool. 
        brew install git-filter-repo

    # Navigate into the repository's working directory.
        cd YOUR-REPOSITORY

    # Run the following command, replacing PATH-TO-YOUR-FILE-WITH-SENSITIVE-DATA with the path to the file you want to remove, not just its filename. These arguments will:
        # Force Git to process, but not check out, the entire history of every branch and tag
        # Remove the specified file, as well as any empty commits generated as a result
        # Remove some configurations, such as the remote URL, stored in the .git/config file. You may want to back up this file in advance for restoration later.
        # Overwrite your existing tags
            git filter-repo --invert-paths --path PATH-TO-YOUR-FILE-WITH-SENSITIVE-DATA

    # Add your file with sensitive data to .gitignore to ensure that you don't accidentally commit it again.
        echo "YOUR-FILE-WITH-SENSITIVE-DATA" >> .gitignore
        git add .gitignore
        git commit -m "Add YOUR-FILE-WITH-SENSITIVE-DATA to .gitignore"

    # The git filter-repo tool will automatically remove your configured remotes. 
        # Use the git remote set-url command to restore your remotes, replacing OWNER and REPO with your repository details. 
            git remote add origin https://github.com/OWNER/REPOSITORY.git

    # Once you're happy with the state of your repository, and you have set the appropriate remote, force-push your local changes to overwrite your repository on GitHub.com, 
    # as well as all the branches you've pushed up. A force push is required to remove sensitive data from your commit history.
        git push origin --force --all

    # In order to remove the sensitive file from your tagged releases, you'll also need to force-push against your Git tags:
        git push origin --force --tags