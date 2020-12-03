
ZSH="${HOME}/.oh-my-zsh"
ZSH_CUSTOM="${ZSH}/custom"
ZSH_THEME="spaceship"

if [[ -z "${TERM_PROGRAM}" || "${TERM_PROGRAM}" == "iTerm.app" ]]; then
    export TERM="xterm-256color"
    ZSH_THEME="powerlevel10k/powerlevel10k"
fi

plugins=(
	git
	zsh-syntax-highlighting
	zsh-autosuggestions
)

source "${ZSH}/oh-my-zsh.sh"

[[ ! -f "${HOME}/.p10k.zsh" ]] || source "${HOME}/.p10k.zsh"
