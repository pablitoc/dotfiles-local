# Remove Untagged images
doclean () {
  docker images -a | grep '^<none>' | tr -s ' ' | cut -d ' ' -f 3 | xargs docker rmi -f
}
# Removes old images
docleanimages () {
  docker images -a | tr -s ' ' | cut -d ' ' -f 3 | xargs docker rmi
}
# Remove all containers
docleancontainers () {
  docker rm $(docker ps -aq)
}
# Remove VFS directory of
docleanvfs () {
  docker volume rm $(docker volume ls -qf dangling=true)
}
# Runs all containers defined in your docker-compose file. If it is needed – rebuild and remove old unused containers.
docleanbuild () {
  docker-compose up -d --build --remove-orphans
}
docleancompose () {
  docker-compose stop && docker-compose rm -f && docker-compose rm -v
}
# Regenerate TLS connection certs, requires confirmation
docrecert () {
  docker-machine regenerate-certs $1
}
# Start Docker Machine
docstart () {
  # Start Virtual Machine for Docker
  docker-machine start
  # Get Environment Variables
  docker-machine env
  # Set Environment Variables
  eval "$(docker-machine env default)"
}
# Stop docker Machine
docstop () {
  # Start Virtual Machine for Docker
  docker-machine stop
}

doclogin () {
  profile=$(_awsp)
  account=$(aws sts get-caller-identity --query "Account" --output text --profile $profile)
  aws ecr get-login-password --region us-west-2 --no-verify-ssl --profile $profile | docker login --username AWS --password-stdin $account.dkr.ecr.us-west-2.amazonaws.com
  ##AWS Account login
  aws ecr get-login-password --region us-west-2 --no-verify-ssl --profile $profile | docker login --username AWS --password-stdin 602401143452.dkr.ecr.us-west-2.amazonaws.com

}

docloginacrp () {
  az acr login -n ssppaps1arpscr1.azurecr.io
}

docloginacrn () {
  az acr login -n ssppans1arpscr1.azurecr.io
}

docloginfaibp () {
  az acr login -n azuraps1faibcr1.azurecr.io
}

doclogit () {
  export CR_PAT=$GH_TOKEN
  echo $CR_PAT | docker login ghcr.io -u USERNAME --password-stdin
}

# https://blog.scottlowe.org/2020/01/25/manually-loading-container-images-with-containerd/
# ctr image pull docker.io/calico/node:v3.11.2

docdf (){
  docker system df
}

docprune (){
  docker image prune -a -f
}

# default_docker_machine() {
#   docker-machine ls | grep -Fq "default"
# }

# if ! default_docker_machine; then
#   docker-machine create --driver virtualbox default
# fi

# default_docker_machine_running() {
#   default_docker_machine | grep -Fq "Running"
# }

# if ! default_docker_machine_running; then
#   docker-machine start default
# fi
