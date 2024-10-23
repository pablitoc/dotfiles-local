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
  aws ecr get-login-password --region us-west-2 --no-verify-ssl --profile amibstackprod | docker login --username AWS --password-stdin 346334011463.dkr.ecr.us-west-2.amazonaws.com
}

docloginfra () {
  aws ecr get-login-password --region us-west-2 --no-verify-ssl --profile arps-n2-infra-profile | docker login --username AWS --password-stdin 822854964954.dkr.ecr.us-west-2.amazonaws.com
}

docloginacrp () {
  az acr login -n ssppaps1arpscr1.azurecr.io
}

docloginacrn () {
  az acr login -n ssppans1arpscr1.azurecr.io
}



doclogit () {
  export CR_PAT="PAT"
  echo $CR_PAT | docker login ghcr.io -u USERNAME --password-stdin
}

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
