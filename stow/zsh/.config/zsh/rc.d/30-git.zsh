# Pull target branch and return to current branch; stashes local changes when needed.
git-pull() {
  local target_branch="${1:-main}"
  local current
  local stash_needed=""

  current="$(git rev-parse --abbrev-ref HEAD)" || return 1

  if ! git diff --quiet || ! git diff --staged --quiet || [ -n "$(git ls-files --others --exclude-standard)" ]; then
    stash_needed=1
    git stash -u || return 1
  fi

  git checkout "$target_branch" && git pull && git checkout "$current"

  if [ -n "$stash_needed" ]; then
    git stash pop
  fi
}
