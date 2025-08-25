# ++++++++++++++++++++++++++++++++++
# General
# ++++++++++++++++++++++++++++++++++

# Verbose list view
alias ls='ls -la'

# I. Am. Lazy.
alias l='ls'

# ssh with verbose option
alias ssh='ssh -v'

# scp with verbose and remote options
alias scp='scp -rvC'

# Open something in the finder
alias o='open'

# Open this directory in the finder
alias od='open .'

alias vs="code"

killdock () {
  kill 15 `ps aux | grep -i "[/]System/Library/CoreServices/Dock.app/Contents/MacOS/Dock" | awk '{print $2}'`
}

bencode (){
  echo -n "$1"|base64
}

bdecode (){
  echo -n "$1"|base64 -D
}

jwt-decode() {
  jq -R 'split(".") |.[0:2] | map(@base64d) | map(fromjson)' <<< $1
}

# Tar and Untar direcctories
tarfile () {
  TODAY=`date "+%m-%d-%Y_%H%M%S"`
  tar -czvf $1-$TODAY.tar.gz $1
}
untarfile () {
  tar -xzvf $1
}

# Use RSYNC to copy files and remove source files
rmove () {
rsync -avh --progress $1 $2 --remove-source-files -d --recursive && rm -rf $1
  }

rcopy () {
rsync -avh --progress $1 $2
  }

mkfile() {
mkdir -p -- "$1" && touch -- "$1"/"$2"
}

# ++++++++++++++++++++++++++++++++++
# SSH
# ++++++++++++++++++++++++++++++++++

# Truncate the contents of your known_hosts file
alias knh='> ~/.ssh/known_hosts'

# ++++++++++++++++++++++++++++++++++
# SSH
# ++++++++++++++++++++++++++++++++++

# Renew IP address. Requires 'sudo' permissions
# Need to add user input for interface to renew
# alias iprenew='sudo ipconfig set en0 DHCP'

makekey () {
  # echo "Please enter the Project Name"
  # read projectname
  ssh-keygen -f ~/.ssh/$1 -t rsa -b 4096 -C "$2" -N ''
}

makedkey () {
  # echo "Please enter the Project Name"
  # read projectname
  ssh-keygen -f ~/.ssh/$1 -t ed25519 -C "$2" -N ''
}

catssl () {
  echo "Grabbing files"
  BUNDLE=`/bin/ls | grep bundle`
  CERT=`/bin/ls | grep -v bundle`

  divider;
  echo "Your Bundle file is ${BUNDLE}"
  echo "Your Certificate file is ${CERT}"
  echo "What would you like to name your file"
  read filename

  divider;
  echo "Concatenating both certificates"
  cat ${CERT} ${BUNDLE} > "${filename}.crt"
  echo "Your certificate is ready!"
}

poetauth () {
  cd $SRC_DIR/DeveloperTooling/src/WorkstationMenuing/
  poetry run python src/menuing.py
}
