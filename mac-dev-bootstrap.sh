#!/usr/bin/env bash
set -e -o pipefail

readonly BASE_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
readonly LOG_DIR="${BASE_DIR}/logs"
readonly LOG_PATH="${LOG_DIR}/mac-dev-bootstrap-$(date +%Y%m%d%H%M%S).log"

# Install Homebrew if missing
[[ ! -x "$(command -v brew)" ]] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# update formulae and Homebrew itself
brew update

# Ansible and its core dependencies
readonly ansible_formulae="ansible ansible-lint python"

# loop through the list and install the missing formulae, if exist, upgrade it if it is outdated
for formula in ${ansible_formulae}; do
  if [[ ! -x "$(command -v "${formula}")" ]]; then
    brew install "${formula}"
  else
    brew outdated "${formula}" || brew upgrade "${formula}"
  fi
done

# Homebrew installed Python in /usr/local for macOS Intel and /opt/homebrew for Apple Silicon
readonly PYTHON_PATH=$(which python3)

# Create log dir if not exist
mkdir -p "${LOG_DIR}"

# Prompting for sudo password upfront (for handling `brew install --cask xxx`)
sudo -v

# Run the playbook
ANSIBLE_LOG_PATH="${LOG_PATH}" ANSIBLE_PYTHON_INTERPRETER="${PYTHON_PATH}" ansible-playbook main.yml "$@"

# Lint the playbook
ansible-lint
