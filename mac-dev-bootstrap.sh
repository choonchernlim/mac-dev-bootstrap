#!/usr/bin/env bash
set -e -o pipefail

readonly BASE_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# Install Homebrew if missing
[[ ! -x "$(command -v brew)" ]] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Install Ansible and its dependencies
[[ ! -x "$(command -v ansible)" ]] && brew install ansible
[[ ! -x "$(command -v ansible-lint)" ]] && brew install ansible-lint
[[ ! -x "$(command -v python)" ]] && brew install python

# Run the playbook
ANSIBLE_LOG_PATH="${BASE_DIR}/logs/ansible-$(date +%Y%m%d%H%M%S).log" ansible-playbook main.yml "$@"

# Lint the playbook
ansible-lint main.yml
