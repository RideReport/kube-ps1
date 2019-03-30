# bash-only, to be sourced from ~/.bashrc

# customized kube-ps1 prompt: shorten EKS context names; highlight "prod"
_HIGHLIGHT=$(tput smso)
_NORMAL=$(tput rmso)
function bold_if_contains_prod() {
  clustername=$1
  if [[ $clustername == *prod* ]]; then
    echo "$_HIGHLIGHT$clustername$_NORMAL"
  else
    echo $clustername
  fi
}

function eks_cluster_name_if_arn() {
  clustername=$1
  if [[ $clustername == "arn:aws:eks:"*":cluster/"* ]]; then
    echo $clustername | cut -d '/' -f 2 
  else
    echo $clustername
  fi
}

function short_and_bold() {
  bold_if_contains_prod $(eks_cluster_name_if_arn $1)
}

KUBE_PS1_CLUSTER_FUNCTION=short_and_bold
