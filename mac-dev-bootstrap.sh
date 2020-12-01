#!/usr/bin/env bash
# shellcheck disable=SC1090

readonly BASE_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

git_checkout() {
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

curl_install() {
  local url="$1"

  sh -c "$(curl -fsSL "${url}")"
}

install_homebrew() {
  echo "====================================================================="
  echo " HomeBrew"
  echo "====================================================================="
  if  [[ ! -x "$(command -v brew)" ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  else
    brew analytics off
    brew update
    brew upgrade
    brew cleanup
    brew doctor
  fi

  echo "====================================================================="
  echo " Nerd Font"
  echo "====================================================================="
  brew tap homebrew/cask-fonts
  brew install --cask font-hack-nerd-font

  echo "====================================================================="
  echo " Rectangle"
  echo "====================================================================="
  brew install --cask rectangle

  echo "====================================================================="
  echo " Essential Packages..."
  echo "====================================================================="
  brew install jq python wget yarn tree composer imagemagick maven
}

install_oh_my_zsh() {
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

install_sdk() {
  echo "====================================================================="
  echo " SDKMAN"
  echo "====================================================================="
  if [[ ! -d "${HOME}/.sdkman" ]]; then
    curl_install "https://get.sdkman.io"
    sdk install java
  else
    export SDKMAN_DIR="${HOME}/.sdkman"
    [[ -s "${HOME}/.sdkman/bin/sdkman-init.sh" ]] && source "${HOME}/.sdkman/bin/sdkman-init.sh"

    sdk selfupdate force
    sdk upgrade
  fi
}

install_nvm() {
  echo "====================================================================="
  echo " NVM"
  echo "====================================================================="
  brew install nvm

  . "/usr/local/opt/nvm/nvm.sh"

  # Install only LTS
  nvm install --lts

  nvm ls

  # Remove old versions
  # shellcheck disable=SC2012,SC2086
  rm -rf "$(ls -td ${HOME}/.nvm/versions/node/* | awk "NR>1")"
}

install_gcloud() {
  echo "====================================================================="
  echo " GCloud"
  echo "====================================================================="
  if [[ ! -d "${HOME}/google-cloud-sdk" ]]; then
    curl https://sdk.cloud.google.com > install_gcloud.sh
    bash install_gcloud.sh --disable-prompts
    rm install_gcloud.sh
  else
    gcloud config set disable_usage_reporting false
    gcloud components update --quiet
  fi
}

install_vimrc() {
  echo "====================================================================="
  echo " VIMRC"
  echo "====================================================================="

  local vimrc="${HOME}/.vim_runtime"

  git_checkout "https://github.com/amix/vimrc.git" "${vimrc}"

  if [[ ! -d "${vimrc}" ]]; then
    sh "${vimrc}/install_awesome_vimrc.sh"
  else
    /usr/local/bin/pip3 install requests --upgrade
    /usr/local/bin/python3 "${vimrc}/update_plugins.py"
  fi
}

install_iterm2() {
  echo "====================================================================="
  echo " ITERM2"
  echo "====================================================================="

  brew install --cask iterm2

  cp "${BASE_DIR}/iterm2/Profiles.json" "${HOME}/Library/Application Support/iTerm2/DynamicProfiles"
}

install_all() {
  install_homebrew
  install_oh_my_zsh
  install_sdk
  install_nvm
  install_gcloud
  install_vimrc
  install_iterm2

  echo "====================================================================="
  echo "Add the following line in ${HOME}/.zshrc:-"
  echo " "
  echo "export MAC_DEV_BOOTSTRAP_HOME=\"${BASE_DIR}\""
  echo "export MAC_DEV_BOOTSTRAP_SCRIPT=\"\${MAC_DEV_BOOTSTRAP_HOME}/mac-dev-bootstrap.sh\""
  echo "alias update=\"cd \${MAC_DEV_BOOTSTRAP_HOME} && git pull --ff-only; \${MAC_DEV_BOOTSTRAP_SCRIPT}\""
}

install_all
