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

echo -e "\033[0;32mRebuilding site...\033[0m"

git commit -m "$msg"

# Push source and build repos.
git push origin master


curl -X POST --data-urlencode 'payload={"channel": "#blogsite", "username": "webhookbot", "text": "rebuilding site :white_check_mark:", "attachments": [{"color": "#36a64f", "text": "pushed to coding platform"}]}' https://hooks.slack.com/services/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

# Come Back
cd ..

echo -e "\033[0;32mCommit hugo dir content updates to coding...\033[0m"

# Add changes to git.
git add -A

updateTime=$(date '+%Y-%m-%d %H:%M:%S')
# Commit changes.
msg="updating hugo dir $updateTime"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master

curl -X POST --data-urlencode 'payload={"channel": "#blogsite", "username": "webhookbot", "text": "updating hugo directory:white_check_mark:", "attachments": [{"color": "#36a64f", "text": "pushed to coding platform"}]}' https://hooks.slack.com/services/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

# Come Back
cd ..