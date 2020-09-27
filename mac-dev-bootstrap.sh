#!/usr/bin/env bash
# shellcheck disable=SC1090

readonly BASE_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

function git_checkout() {
  local url="$1"
  local dir="$2"

  if [[ ! -d "${dir}" ]]; then
    git clone --depth=1 "${url}" "${dir}"
  else
    cd "${dir}" || exit
    git reset --hard
    git pull --ff-only
  fi
}

function curl_install() {
  local url="$1"

  sh -c "$(curl -fsSL "${url}")"
}

function install_homebrew() {
  echo "====================================================================="
  echo " HomeBrew"
  echo "====================================================================="
  if  [[ ! -x "$(command -v brew)" ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  else
    brew update
    brew upgrade
    brew cleanup
    brew doctor
  fi

  echo "====================================================================="
  echo " Nerd Font"
  echo "====================================================================="
  brew tap homebrew/cask-fonts
  brew cask install font-hack-nerd-font

  echo "====================================================================="
  echo " Rectangle"
  echo "====================================================================="
  brew cask install rectangle
}

function install_oh_my_zsh() {
  echo "====================================================================="
  echo " Oh My Zsh"
  echo "====================================================================="

  local zsh="${HOME}/.oh-my-zsh"
  local zsh_custom="${zsh}/custom"

  if [[ ! -d "${HOME}/.oh-my-zsh" ]]; then
    curl_install   "https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
  else
    (cd "${zsh}" && git reset --hard && git pull --ff-only)
  fi

  echo "====================================================================="
  echo " PowerLevel10k"
  echo "====================================================================="
  git_checkout "https://github.com/romkatv/powerlevel10k.git" "${zsh_custom}/themes/powerlevel10k"
  cp "${BASE_DIR}/zshrc/.p10k.zsh" "${HOME}/.p10k.zsh"

  echo "====================================================================="
  echo " Spaceship"
  echo "====================================================================="
  git_checkout "https://github.com/denysdovhan/spaceship-prompt.git" "${zsh_custom}/themes/spaceship-prompt"
  ln -s "${zsh_custom}/themes/spaceship-prompt/spaceship.zsh-theme" "${zsh_custom}/themes/spaceship.zsh-theme"

  echo "====================================================================="
  echo " Syntax Highlighting"
  echo "====================================================================="
  git_checkout "https://github.com/zsh-users/zsh-syntax-highlighting.git" "${zsh_custom}/plugins/zsh-syntax-highlighting"

  echo "====================================================================="
  echo " ZSH-AutoSuggestions"
  echo "====================================================================="
  git_checkout "https://github.com/zsh-users/zsh-autosuggestions.git" "${zsh_custom}/plugins/zsh-autosuggestions"
}

function install_sdk() {
  echo "====================================================================="
  echo " SDKMAN"
  echo "====================================================================="
  if [[ ! -d "${HOME}/.sdkman" ]]; then
    curl_install "https://get.sdkman.io"
  else
    export SDKMAN_DIR="${HOME}/.sdkman"
    [[ -s "${HOME}/.sdkman/bin/sdkman-init.sh" ]] && source "${HOME}/.sdkman/bin/sdkman-init.sh"

    sdk selfupdate force
  fi
}

function install_nvm() {
  echo "====================================================================="
  echo " NVM"
  echo "====================================================================="
  if [[ ! -d "${HOME}/.nvm" ]]; then
    curl_install "https://raw.githubusercontent.com/creationix/nvm/v0.35.3/install.sh"
  fi

  export NVM_DIR="${HOME}/.nvm"
  [ -s "${NVM_DIR}/nvm.sh" ] && \. "${NVM_DIR}/nvm.sh"  # This loads nvm
  [ -s "${NVM_DIR}/bash_completion" ] && \. "${NVM_DIR}/bash_completion"  # This loads nvm bash_completion

  # Install only LTS
  nvm install --lts

  nvm ls

  # Remove old versions
  # shellcheck disable=SC2012,SC2086
  rm -rf "$(ls -td ${HOME}/.nvm/versions/node/* | awk "NR>1")"
}

function install_gcloud() {
  echo "====================================================================="
  echo " GCloud"
  echo "====================================================================="
  if [[ ! -x "$(command -v gcloud)" ]]; then
    curl https://sdk.cloud.google.com > install_gcloud.sh
    bash install_gcloud.sh --disable-prompts
    rm install_gcloud.sh
  else
    gcloud components update --quiet
  fi
}

function install_all() {
  install_homebrew
  install_oh_my_zsh
  install_sdk
  install_nvm
  install_gcloud

  echo "====================================================================="
  echo "Add the following line in ${HOME}/.zshrc:-"
  echo " "
  echo "export MAC_DEV_BOOTSTRAP=${BASE_DIR}/mac-dev-bootstrap.sh"
  echo "alias update=\"\$MAC_DEV_BOOTSTRAP\""
}

install_all
