chefclean () {
command=$1
for client in $command; do
  if [[ $client == "ag-validator" ]]; then
    continue
  else
    knife client delete $client -y && \
    knife node delete $client -y && \
    rancher stop $client && \
    rancher deactivate $client
  fi
done
}

# Chef & Rancher Clean-Up
# knife node delete -y & knife client delete -y & rancher deactivate & rancher rm
chefclr() {
knife node delete -y $input & knife client delete -y $input & rancher deactivate $input & rancher rm $input
}
