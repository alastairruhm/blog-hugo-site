#!/bin/bash

echo -e "\033[0;32mDeploying site to coding pages...\033[0m"

# Build the project.
echo -e "\033[0;32mGenerate static pages using theme [null]...\033[0m"
hugo # if using a theme, replace by `hugo -t <yourtheme>`

# Go To Public folder
cd public
# Add changes to git.
git add -A

# Commit changes.
msg="rebuilding site $(date '+%Y-%m-%d %H:%M:%S')"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master

# Come Back
cd ..

echo -e "\033[0;32mCommit hugo dir content updates to coding...\033[0m"

# Add changes to git.
git add -A

# Commit changes.
msg="updating hugo dir $(date '+%Y-%m-%d %H:%M:%S')"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master

# Come Back
cd ..