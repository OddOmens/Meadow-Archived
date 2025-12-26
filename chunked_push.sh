#!/bin/bash
# Usage: ./chunked_push.sh <remote_url>

REMOTE_URL=$1
if [ -z "$REMOTE_URL" ]; then
    echo "Usage: ./chunked_push.sh <remote_url>"
    exit 1
fi

git remote remove origin 2>/dev/null
git remote add origin "$REMOTE_URL"

# Increase buffer size just in case
git config http.postBuffer 524288000

# Push commits in batches
# This relies on the fact that we have many commits from chunked_init.sh
commits=($(git rev-list --reverse HEAD))
total=${#commits[@]}
echo "Total commits: $total"

step=10
for (( i=0; i<$total; i+=$step )); do
    idx=$((i + step - 1))
    if [ $idx -ge $total ]; then
        idx=$((total - 1))
    fi
    hash=${commits[$idx]}
    echo "Pushing commit $hash ($((idx+1))/$total)"
    git push origin "$hash":refs/heads/main
    if [ $? -ne 0 ]; then
        echo "Push failed, retrying..."
        sleep 5
        git push origin "$hash":refs/heads/main
        if [ $? -ne 0 ]; then
          echo "FATAL: Push failed."
          exit 1
        fi
    fi
done
echo "Push complete."
