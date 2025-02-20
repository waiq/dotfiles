# git-pull: Switch branches, pull updates, and return to your original branch
#
# Usage:
#   git-pull [branch_name]
#
# Description:
#   This function allows you to switch to a target branch (e.g., main or master), 
#   pull the latest changes from that branch, and return to your current branch. 
#   It automatically stashes any uncommitted changes before switching branches 
#   and pops them back after returning.
#
# Parameters:
#   branch_name (optional): The name of the branch you want to switch to. 
#                           Defaults to 'main' if no argument is provided.
#
# Example:
#   git-pull               # Switches to 'main', pulls changes, and returns to the original branch
#   git-pull master         # Switches to 'master', pulls changes, and returns to the original branch
#
# Important:
#   Uncommitted changes, including untracked files, are stashed before switching branches 
#   and restored when switching back to the original branch.
#

git-pull() {
  TARGET_BRANCH=${1:-main}  
  CURRENT=$(git rev-parse --abbrev-ref HEAD)
  
  # Check if there are uncommitted changes
  if ! git diff --quiet || ! git diff --staged --quiet || [ -n "$(git ls-files --others --exclude-standard)" ]; then
    STASH_NEEDED=1
    git stash -u
  fi
  
  # Switch to the target branch, pull the latest changes, then switch back
  git checkout "$TARGET_BRANCH" && git pull && git checkout "$CURRENT"
  
  # Pop the stashed changes back if they were stashed
  if [ -n "$STASH_NEEDED" ]; then
    git stash pop
  fi
}
