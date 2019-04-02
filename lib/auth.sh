vaultlogin () {
  if vault token lookup &>/dev/null; then
    :
  else
    vault login -method=github token=$VAULT_GITHUB_TOKEN
  fi
}

awsmfa () {
  if aws-mfa | grep -e AWS_SESSION_TOKEN -e AWS_SECURITY_TOKEN &>/dev/null; then
    eval $(aws-mfa)
  else
    aws-mfa
  fi
}