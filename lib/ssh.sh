sk () {
  echo "Setting up SSH keys for $1@$2..."
  ssh $1@$2 'mkdir -p ~/.ssh; chmod 700 ~/.ssh'
  scp $1@$2:.ssh/authorized_keys ~/.ssh/authorized_keys_tmp
  cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys_tmp
  scp ~/.ssh/authorized_keys_tmp $1@$2:.ssh/authorized_keys
  ssh $1@$2 'chmod 600 ~/.ssh/authorized_keys'
  rm ~/.ssh/authorized_keys_tmp
  echo "SSH keys successfully created."
}

cleanknownhost() {
  sed -i~ "$1 d" ~/.ssh/known_hosts;
}

update_keys () {
  if [ -r $BOXEN_SRC_DIR/keys/authorized_keys ] ; then
    echo "Setting up SSH keys for $1@$2..."
    ssh $1@$2 'mkdir -p ~/.ssh; chmod 700 ~/.ssh'
    scp $BOXEN_SRC_DIR/keys/authorized_keys $1@$2:.ssh/authorized_keys
    ssh $1@$2 'chmod 600 ~/.ssh/authorized_keys'
    echo "SSH keys successfully updated."
  else
    echo "You cannot update the keys on this server because you do not have the appropriate files."
  fi
}

cqlprod() {
# 10.105.1.242,
# "10.105.1.242", "10.105.2.88", "10.105.0.8"
  # cqlsh 10.105.0.8 -u scylla -p piwWSc9e81XMxan
  docker run -it --rm --entrypoint cqlsh scylladb/scylla -u scylla -p piwWSc9e81XMxan 10.105.2.88
}

cqlqa() {
  # cqlsh --cqlversion=3.3.1 10.106.2.229 -u scylla -p cPu1b73NlyKxpen
  docker run -it --rm --entrypoint cqlsh scylladb/scylla -u scylla -p cPu1b73NlyKxpen 10.106.2.80
}

cqlstg() {
  # cqlsh 10.107.0.204 -u scylla -p T10q4FBJGWcQRZp
  docker run -it --rm --entrypoint cqlsh scylladb/scylla -u scylla -p T10q4FBJGWcQRZp 10.107.0.204
}

pgdevaurora() {
  PGPASSWORD='-3%TB<oBK5hA}!4' pgcli -h dev-aurora-postgresql.cluster-cdpd3q1tstmy.us-west-2.rds.amazonaws.com  -U devpgauradmin postgres
}

pgqaaurora() {
  PGPASSWORD='JPxQgmw$2bCSHhj8H' pgcli -h qa-aurora-postgresql.cluster-ctmcnogqf0cr.us-west-2.rds.amazonaws.com  -U qapgadmin postgres
}

pgaurorastg() {
  PGPASSWORD='54!nQa6\Gu7zJ%nB' pgcli -h staging-aurora-postgresql.cluster-cgysmlzlvibe.us-west-2.rds.amazonaws.com -U stagingpgadmin postgres
}

pgauroraprod() {
  PGPASSWORD='2YRjojQ*3CBsb8xg' pgcli -h prod-aurora-postgresql.cluster-c5milolfh3ru.us-west-2.rds.amazonaws.com -U prodpgadmin postgres
}

pgdev() {
  PGPASSWORD='avu_dL!7Dk!xDMUT' pgcli -h postdb.develop.nxcr.com  -U devpgadmin postgres
}

pgcliqa() {
  PGPASSWORD='JPxQgmw$2bCSHhj8H' pgcli -h postdb.qa.nxcr.com  -U qapgadmin postgres
}

pgclistg() {
  PGPASSWORD='54!nQa6\Gu7zJ%nB' pgcli -h postdb.staging.nxcr.com  -U stagingpgadmin postgres
}

pgcliprod() {
  PGPASSWORD="2YRjojQ*3CBsb8xg" pgcli -h postdb.prod.nxcr.com -U prodpgadmin postgres
}

# pgclibeta() {
#   PGPASSWORD="avu_dL!7Dk!xDMUT" pgcli -h postdb.dev.nxcr.com -U devpgadmin base
# }

# pgqaaurora() {
#   PGPASSWORD='4Kt8QBESRPxqvGt3y8M3M1gsYj8v52' pgcli -h qa-aurora-postgresql.cluster-ctmcnogqf0cr.us-west-2.rds.amazonaws.com  -U fivetran_readonly postgres
# }