ec2_ip () {
  aws ec2 describe-instances --filters "Name=tag:Name,Values=prod-web-host-031"
}

alogin () {
  aws sso login --profile $1
}