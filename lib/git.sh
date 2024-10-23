# ++++++++++++++++++++++++++++++++++
# General
# ++++++++++++++++++++++++++++++++++
# alias git=hub

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
alias gmm='git merge master'

alias gcom='git checkout master'
alias gcodl='git checkout deploy/live'
alias gcods='git checkout deploy/stage'

alias gb='git branch'
alias gbl='git branch --list'
alias gr='git rm'
# alias gpr='hub pull-request -b master'

gprq () {
 hub pull-request -b $1 -a pablitoc -m "$2"
}

gitcleanup () {
  git fetch --prune && git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -d
}

#grao () {
#  git remote add origin git@github.com:autogravity/$1.git
#}

# Remove a local branch and re-track it from origin
gfb () {
  git checkout master
  git branch -D $1
  git fetch origin
  git branch --track $1 origin/$1
  git checkout $1
}
