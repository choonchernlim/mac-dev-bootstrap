#!/usr/bin/env bash
set -e -o pipefail

# Install Homebrew if missing
[[ ! -x "$(command -v brew)" ]] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Install ansible and its dependencies
[[ ! -x "$(command -v ansible)" ]] && brew install ansible
[[ ! -x "$(command -v python)" ]] && brew install python

# Run the playbook
ansible-playbook main.yml
