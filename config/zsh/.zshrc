# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.dotfiles/config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $ZDOTDIR/utils.zsh

plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting 
)

for plugin in ${plugins[@]}; do
  add_plugin $plugin
done

source_file functions.zsh
source_file history.zsh
source_file alias.zsh
source_file completion.zsh
source_file key-bindings.zsh
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

setopt GLOB_COMPLETE
setopt MENU_COMPLETE
setopt AUTO_CD
setopt LIST_PACKED
setopt AUTO_LIST
setopt COMPLETE_IN_WORD

export KUBECONFIG=~/.kube/config

# FD
FD_OPTIONS="--hidden --follow --exclude .git"

# FZF
export FZF_DEFAULT_COMMAND="fd --type f --type l $FD_OPTIONS"
export FZF_DEFAULT_OPTS="--pointer '►' --marker=⦁ --height 60% --layout=reverse --color 'fg:#bdae93,fg+:#f9f5d7,hl:#fabd2f,hl+:#fabd2f,info:#8ec07c,pointer:#fb4934,marker:#fe8019,bg+:-1'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
bindkey '^f' fzf-cd-widget
export FZF_TMUX=1

# NNN
# Install NNN plugins
# [[ ! -d $XDG_CONFIG_HOME/nnn/plugins ]] || [[ -z $(ls -A $XDG_CONFIG_HOME/nnn/plugins) ]] || sh -c "$(curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs)" 
export NNN_PLUG='d:preview-tui;i:imgview;j:autojump;p:rsynccp;s:suedit;l:launch'
export NNN_FIFO=/tmp/nnn.fifo
export NNN_FCOLORS='0000d6000000000000000000'

# PROMPT
source $ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f $ZDOTDIR/p10k.zsh ]] || source $ZDOTDIR/p10k.zsh

if [ -z "$SSH_CLIENT" ] && [ -z "$SSH_TTY" ] && [ "$HOST" = "gennaro-pi" ]; then
	pipes -f 20		
elif [ "$HOST" = "gennaro-pi" ]; then
	echo "Welcome to Dungeonware."
fi
