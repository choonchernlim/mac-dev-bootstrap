
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

ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM="$ZSH/custom"
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

source $ZSH/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
