#!/bin/bash

# This script is used to push changes to a git repository.
# It takes a commit message as an argument and pushes the changes to the remote repository.
# Usage: ./push-commit.sh "Your commit message"
# Check if a commit message is provided
if [ -z "$1" ]; then
  echo "Error: No commit message provided."
  echo "Usage: $0 \"Your commit message\""
  exit 1
fi
# Check if the current directory is a git repository
if [ ! -d ".git" ]; then
  echo "Error: This script must be run in a git repository."
  exit 1
fi
# Add all changes to the staging area
git add .
# Check if the add command was successful
if [ $? -ne 0 ]; then
  echo "Error: Failed to add changes to the staging area."
  exit 1
fi
# Commit the changes with the provided commit message
git commit -m "$1"
# Check if the commit command was successful
if [ $? -ne 0 ]; then
  echo "Error: Failed to commit changes."
  exit 1
fi
# Push the changes to the remote repository
git push
# Check if the push command was successful
if [ $? -ne 0 ]; then
  echo "Error: Failed to push changes to the remote repository."
  exit 1
fi
# Script written with <3 by | <Kamil Baldyga/> | github.com/ME0WGE