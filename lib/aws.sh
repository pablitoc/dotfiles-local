ec2_ip () {
  aws ec2 describe-instances --filters "Name=tag:Name,Values=prod-web-host-031"
}

export AWS_CA_BUNDLE="/etc/ssl/cert.pem"
alias awsr="export AWS_REGION=\$(_ar)" \
  awsru="unset AWS_REGION"

alias awsp="export AWS_PROFILE=\$(_awsp)"
alias awsu="unset AWS_PROFILE"
alias awsloginprog="prog_auth.sh"

# aws configure list-profiles | fzf
_awsp () {
  if [[ "$1" == "--no-programmatic" ]]; then
    aws configure list-profiles | grep -v programmatic | fzf --prompt "Choose AWS profile: "
  elif [[ "$1" == "--programmatic" ]]; then
    aws configure list-profiles | grep programmatic | fzf --prompt "Choose AWS profile: "
  elif [[ "$1" == "--iac" ]]; then
    aws configure list-profiles | grep iac | fzf --prompt "Choose AWS profile: "
  else
    aws configure list-profiles | fzf --prompt "Choose AWS profile: "
  fi
}

# awslogin: Interactive AWS SSO login using aws-azure-login and fzf profile picker.
#
# 1. Prompts the user to select an AWS profile (excluding "programmatic" profiles) using fzf.
# 2. If the user cancels or does not select a profile, the function aborts and does NOT run aws-azure-login.
# 3. If a profile is selected, sets AWS_PROFILE and launches aws-azure-login in GUI mode using Microsoft Edge.
#
# Requirements:
#   - fzf must be installed and in your PATH.
#   - aws-azure-login must be installed and in your PATH.
#   - Microsoft Edge must be installed at the specified path.
#
# Usage:
#   awslogin
#
awslogin() {
  # Prompt user to select a non-programmatic AWS profile using fzf
  local PROFILE
  PROFILE=$(_awsp --no-programmatic)
  # If no profile is selected (user cancels), abort
  if [[ -z "$PROFILE" ]]; then
    echo "No AWS Profile selected. Aborting aws-azure-login."
    return 1
  fi
  # Set the AWS_PROFILE environment variable for this shell session
  eval "export AWS_PROFILE='$PROFILE'"
  # Launch aws-azure-login in GUI mode using Microsoft Edge as the browser
  PUPPETEER_EXECUTABLE_PATH="/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge" aws-azure-login --mode gui
}

awsloginspd() {
  PUPPETEER_EXECUTABLE_PATH="/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge" aws-azure-login --mode gui --spd-app-dev
}

awsloginarps() {
  PUPPETEER_EXECUTABLE_PATH="/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge" aws-azure-login --mode gui --arps-app-dev
}

# SSM Get Instance ID by Private DNS Name
# Usage: ssm <private-dns-name>
ssm () {
  local PROFILE
  PROFILE=$(_awsp --iac)
  # If no profile is selected (user cancels), abort
  if [[ -z "$PROFILE" ]]; then
    echo "No AWS Profile selected. Aborting aws-azure-login."
    return 1
  fi
  # Set the AWS_PROFILE environment variable for this shell session
  eval "export AWS_PROFILE='$PROFILE'"
  aws ssm start-session --target "$(_getid "$1")"
}
_getid () {
  aws ec2 describe-instances \
  --filters "Name=private-dns-name,Values=$1" \
  --query "Reservations[*].Instances[*].InstanceId" \
  --output text
}

update-kubeconfig () {
  aws eks --region "$1" update-kubeconfig --name "$2" --alias "$2" --profile $(_awsp)
}

desc-subnet () {
  local subnet_type="$1"
  
  case "$subnet_type" in
    "routable"|"r")
      echo "=== Routable Subnets ==="
      aws ec2 describe-subnets --output json --profile $(_awsp --no-programmatic) | jq '.Subnets | map(select(.CidrBlock | test("^10\\.2[0-9]{2}\\.") | not)) | map({SubnetId, CidrBlock, AvailabilityZone})'
      ;;
    "non-routable"|"nr")
      echo "=== Non-Routable Subnets ==="
      aws ec2 describe-subnets --output json --profile $(_awsp --no-programmatic) | jq '.Subnets | map(select(.CidrBlock | test("^10\\.1[0-9]{2}\\.") | not)) | map({SubnetId, CidrBlock, AvailabilityZone})'
      ;;
    *)
      echo "Usage: desc-subnet [routable|r|non-routable|nr]"
      echo "  routable (r)     - Show routable subnets"
      echo "  non-routable (nr) - Show non-routable subnets"
      return 1
      ;;
  esac
}