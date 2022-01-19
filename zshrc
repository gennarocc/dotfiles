# Path
export ZSH="$HOME/.oh-my-zsh"

# Globals
ZSH_THEME=""
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
ZSH_CUSTOM=$HOME/.config/zsh/

plugins=(git geometry zsh-autosuggestions sudo fzf zsh-interactive-cd)

source $ZSH/oh-my-zsh.sh

# User configuration

source $ZSH_CUSTOM/.zprofile

