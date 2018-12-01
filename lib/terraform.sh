tftaint () {
module=$1
for resource in `terraform show -module-depth=1 | grep module.$module | tr -d ':' | sed -e "s/module.$module.//"`; do
  if [[ $resource == "aws"* ]] || [[ $resource == *"tainted"* ]]; then
    if [[ $resource == *"tainted"* ]]; then
      continue
    else
      terraform taint -module $module $resource
    fi
  elif [[ $resource != "aws"* ]]; then
    for sub_module in `terraform show | grep module.$module.$resource | tr -d ':' | sed -e "s/module.$module.$resource.//"`; do
      if [[ $sub_module == *"tainted"* ]] || [[ $sub_module == *"data"* ]]; then
        continue
      else
        sub_resource=`echo $sub_module | sed -e "s/$resource.//"`
        terraform taint -module $module.$resource $sub_resource
      fi
    done
  fi
done
}

tftainthosts () {
module=$1
for sub_module in `terraform show | grep module.$module | tr -d ':' | sed -e "s/module.$module.//"`; do
  if [[ $sub_module == *"tainted"* ]] || [[ $sub_module == *"data"* ]] || [[ $sub_module != *".hosts."* ]]; then
    continue
  else
    for resource in $sub_module; do
        terraform taint -module $module $resource
    done
  fi
done
}

tfdestroy () {
built_command=""
for arg; do
  added_command="-target=module.$arg"
  built_command="$built_command$added_command "
done
echo 'terraform destroy' $built_command
}
