# https://kubernetes.io/docs/reference/kubectl/cheatsheet/
# Kubernetes alias

alias k='kubectl'

# short alias to set/show context/namespace (only works for bash and bash-compatible shells, current context to be set before using kn to set namespace)
alias kx='f() { [ "$1" ] && kubectl config use-context $1 || kubectl config current-context ; } ; f'
alias kn='f() { [ "$1" ] && kubectl config set-context --current --namespace $1 || kubectl config view --minify | grep namespace | cut -d" " -f6 ; } ; f'

kuse () {
  kubectl config use-context $1
}

kshnats () {
  export INFO="$(k describe pods --all-namespaces -l app=$1 | grep -iw -e namespace -e Name)"
  export POD="$(echo $INFO | grep -w Name | awk '{print $2}')"
  export NAMESPACE="$(echo $INFO | grep -w Namespace | awk '{print $2}')"
  kubectl exec -it $POD -n $NAMESPACE /bin/sh
}

ksh () {
  export INFO="$(k describe pods --all-namespaces -l app.kubernetes.io/name=$1 | grep -iw -e namespace -e Name)"
  export POD="$(echo $INFO | grep -w Name | awk '{print $2}')"
  export NAMESPACE="$(echo $INFO | grep -w Namespace | awk '{print $2}')"
  kubectl exec -it $POD -n $NAMESPACE /bin/sh
}

kcp () {
  export INFO="$(k describe pods --all-namespaces -l app=$1 | grep -iw -e namespace -e Name)"
  export POD="$(echo $INFO | grep -w Name | awk '{print $2}')"
  export NAMESPACE="$(echo $INFO | grep -w Namespace | awk '{print $2}')"
  kubectl cp $POD -n $NAMESPACE
}

delcrashedpods () {
  k get pods | grep -e Crash -e Terminating | awk '{print $1}' | xargs -I {} kubectl delete --force pod {}
}

helmsearch () {
  helm search repo $1 --versions
}
