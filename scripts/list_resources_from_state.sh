#!/usr/bin/bash

for folder in `ls -1`                                                                                                                                           ✔
do
  echo
  echo $folder | tr '[:lower:]' '[:upper:]'
  echo
  echo "Resources"
  echo
  cat ${folder}/terraform.tfstate | jq -r ".resources[].type" | sort -u
done
