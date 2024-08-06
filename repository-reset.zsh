#!/usr/bin/env zsh

set -e

ORIGIN="$(git remote get-url origin)"

rm -fr .git

git init --initial-branch 'main'
git add .
git commit --message 'Repository Reset'
git remote add origin "${ORIGIN}"
git push --force --mirror
git push --set-upstream 'origin' 'main'
