alias j='jekyll --server --auto'

createtokens () {
  echo zendesk_service_user=`ruby -rsecurerandom -e "puts test=SecureRandom.base64(12)"`
}