#!/bin/bash
rm -rf .git
git init
# Configure generic user for this repo
git config user.name "Meadow Open Source"
git config user.email "opensource@meadow.app"

git add .gitignore
git commit -m "Add .gitignore"

# List files, excluding .git
find . -type f -not -path './.git/*' -not -name '.gitignore' -not -name 'chunked_init.sh' -not -name 'chunked_push.sh' > file_list.txt

batch_size=20
counter=0

while read p; do
  git add "$p"
  ((counter++))
  if (( counter % batch_size == 0 )); then
    git commit -m "Adding batch of files $counter"
  fi
done < file_list.txt

git commit -m "Adding remaining files"
rm file_list.txt
