alias j='jekyll --server --auto'

createtokens () {
  echo RandomToken=`ruby -rsecurerandom -e "puts test=SecureRandom.base64(12)"`
}