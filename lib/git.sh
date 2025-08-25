# ++++++++++++++++++++++++++++++++++
# General
# ++++++++++++++++++++++++++++++++++
# alias git=hub
alias trigger-ci="git commit -m 'deploy: trigger CI' --allow-empty"

alias gpsh='git push'
alias gpshom='git push origin master'

alias gpl='git pull'
alias gplom='git pull origin master'

alias gl='git log'

alias gs='git status'
alias gf='git fetch'

alias ga='git add'

alias gc='git commit -m'
alias gco='git checkout'

alias gm='git merge'
alias gmm='git merge main'

alias gcom='git checkout main'

alias gb='git branch'
alias gbl='git branch --list'
alias gr='git rm'

gprq () {
#  hub pull-request -b $1 -a pablitoc -m "$2"
 gh pr create -B $1 -t "$2" -b "$3"
}
# command to remove files from git tracking
# find . -name .DS_Store -print0 | xargs -0 git rm --ignore-unmatch

gitcleanup () {
  git fetch --prune && git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -D
}

# Remove a local branch and re-track it from origin
gfb () {
  git checkout main
  git branch -D $1
  git fetch origin
  git branch --track $1 origin/$1
  git checkout $1
}

sgr () {
if [ $# -lt 1 ]; then
  echo "SPD Git Repo Clone utility"
  echo "syntax: ${0} repo"
  exit 1
fi

GIT_SSH_COMMAND="ssh -i ~/.ssh/pabloed" git clone git@github.com:StrategicProductDevelopment/${1}.git $HOME/src/gp/${1}
pushd $HOME/src/gp/${1} || exit 2

if ! command -v pre-commit &>/dev/null; then
  echo "ERROR: pre-commit not found."
  echo "Please install with 'brew install pre-commit'"
  exit 2
fi

pre-commit install
if [ $? -ne 0 ]; then
  echo "ERROR: pre-commit install failed; please run manually"
  exit 2
fi

popd
}