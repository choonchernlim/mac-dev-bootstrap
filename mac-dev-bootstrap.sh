#!/usr/bin/env bash
set -e -o pipefail

readonly BASE_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
readonly LOG_DIR="${BASE_DIR}/logs"
readonly LOG_PATH="${LOG_DIR}/ansible-$(date +%Y%m%d%H%M%S).log"

# Install Homebrew if missing
[[ ! -x "$(command -v brew)" ]] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Install Ansible and its dependencies
[[ ! -x "$(command -v ansible)" ]] && brew install ansible
[[ ! -x "$(command -v ansible-lint)" ]] && brew install ansible-lint
[[ ! -x "$(command -v python)" ]] && brew install python

# Create log dir if not exist
mkdir -p "${LOG_DIR}"

# Run the playbook
ANSIBLE_LOG_PATH="${LOG_PATH}" ansible-playbook main.yml "$@"

# Lint the playbook
ansible-lint main.yml
