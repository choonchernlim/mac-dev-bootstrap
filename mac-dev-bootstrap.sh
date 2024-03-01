#!/usr/bin/env bash
set -e -o pipefail

readonly BASE_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
readonly LOG_DIR="${BASE_DIR}/logs"
readonly LOG_PATH="${LOG_DIR}/mac-dev-bootstrap-$(date +%Y%m%d%H%M%S).log"
readonly PYTHON_VENV_DIR="${BASE_DIR}/.venv"
readonly PACKAGES="homebrew/core/python"

# Install Homebrew if missing, otherwise update all package definitions and Homebrew itself
if [[ ! -x "$(command -v brew)" ]]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
  brew update --quiet
fi

# Loop through the list and install the missing core packages, if exist, upgrade it if it is outdated
for package in ${PACKAGES}; do
  echo "${package}: Checking..."
  if ! brew list "${package}" &>/dev/null; then
    echo "${package}: Package missing. Installing it..."
    brew install "${package}"
  elif ! brew outdated "${package}" &>/dev/null; then
    echo "${package}: Package outdated. Upgrading it..."
    brew upgrade "${package}" --force
  fi
done

# If .venv does not exist, create it and install ansible and ansible-lint
if [[ ! -d "${PYTHON_VENV_DIR}" ]]; then
  python3 -m venv "${PYTHON_VENV_DIR}"
fi

# If existing virtual environment is activated, deactivate it
if [[ -n "${VIRTUAL_ENV}" ]]; then
  deactivate
fi

# Activate virtual environment
source "${PYTHON_VENV_DIR}/bin/activate"

# Pip install or upgrade ansible and ansible-lint
python3 -m pip install --quiet --upgrade ansible ansible-lint

# Homebrew installed Python in /usr/local for macOS Intel and /opt/homebrew for Apple Silicon
readonly PYTHON_PATH=$(which python3)

# Create log dir if not exist
mkdir -p "${LOG_DIR}"

# Prompting for sudo password upfront (for handling `brew install --cask xxx`)
sudo -v

# Keep sudo alive until the script is done
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Run the playbook
ANSIBLE_LOG_PATH="${LOG_PATH}" ANSIBLE_PYTHON_INTERPRETER="${PYTHON_PATH}" ansible-playbook main.yml "$@"

# Lint the playbook
ansible-lint

# Deactivate virtual environment
deactivate
