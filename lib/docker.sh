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
  aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 180974838604.dkr.ecr.us-west-2.amazonaws.com
}

docdf (){
  docker system df
}

docprune (){
  docker image prune -a -f
}
