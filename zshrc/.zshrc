
# =====================================================================
# mac-dev-bootstrap :: Don't change anything below!
# =====================================================================

export PATH="/usr/local/sbin:$PATH"

alias python="/usr/local/bin/python3"
alias pip="/usr/local/bin/pip3"

export MAVEN_OPTS="-Xms2048m -Xmx2048m"
export JAVA_OPTS="-Xms2048m -Xmx2048m"
export JAVA_HOME="${SDKMAN_DIR}/candidates/java/current"
export GPG_TTY=$(tty)

ZSH="${HOME}/.oh-my-zsh"
ZSH_CUSTOM="${ZSH}/custom"
ZSH_THEME="spaceship"

if [[ -z "$TERM_PROGRAM" || "$TERM_PROGRAM" == "iTerm.app" ]]; then
    export TERM="xterm-256color"
    ZSH_THEME="powerlevel10k/powerlevel10k"
fi

plugins=(
	git
	zsh-syntax-highlighting
	zsh-autosuggestions
)

source "${ZSH}/oh-my-zsh.sh"

source "${HOME}/google-cloud-sdk/completion.zsh.inc"
source "${HOME}/google-cloud-sdk/path.zsh.inc"

export NVM_DIR="${HOME}/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"

export SDKMAN_DIR="${HOME}/.sdkman"
[[ -s "${HOME}/.sdkman/bin/sdkman-init.sh" ]] && source "${HOME}/.sdkman/bin/sdkman-init.sh"

[[ ! -f "${HOME}/.p10k.zsh" ]] || source "${HOME}/.p10k.zsh"

