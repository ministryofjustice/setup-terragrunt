#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o xtrace

#######################################
# Functions
#######################################
declare -xr GITHUB_BIN="github-bin"

#######################################
# Functions
#######################################
function parse_verion() {
  if [[ "${INPUT_TERRAFORM_VERSION}" == "latest" ]]; then
    terraformVersion=$(curl https://api.github.com/repos/hashicorp/terraform/releases/latest | jq -r '.tag_name' | sed 's/v//')
  else
    terraformVersion=$(echo "${INPUT_TERRAFORM_VERSION}" | sed 's/v//')
  fi

  if [[ "${INPUT_TERRAGRUNT_VERSION}" == "latest" ]]; then
    terragruntVersion=$(curl https://api.github.com/repos/gruntwork-io/terragrunt/releases/latest | jq -r '.tag_name')
  else
    terragruntVersion="${INPUT_TERRAGRUNT_VERSION}"
  fi
}

function setup_github_bin() {
  mkdir -p ${GITHUB_BIN}
}

function install_terraform() {
  terraformDownloadUrl="https://releases.hashicorp.com/terraform/${terraformVersion}/terraform_${terraformVersion}_linux_amd64.zip"
  wget ${terraformDownloadUrl} -O /tmp/terraform_${terraformVersion}_linux_amd64.zip
  unzip /tmp/terraform_${terraformVersion}_linux_amd64.zip -d /tmp
  mv /tmp/terraform ${GITHUB_BIN}
}

function install_terragrunt() {
  terragruntDownloadUrl="https://github.com/gruntwork-io/terragrunt/releases/download/${terragruntVersion}/terragrunt_linux_amd64"
  wget ${terragruntDownloadUrl} -O /tmp/terragrunt
  chmod +x /tmp/terragrunt
  mv /tmp/terragrunt ${GITHUB_BIN}
}

#######################################
# Script
#######################################
parse_verion
setup_github_bin
install_terraform
install_terragrunt