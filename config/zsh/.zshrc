# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.dotfiles/config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

eval "$(jump shell)"

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

# FZF
FD_OPTIONS="--hidden --follow --exclude .git"
export FZF_DEFAULT_COMMAND="fd --type f --type l $FD_OPTIONS"
export FZF_DEFAULT_OPTS="--prompt ' ' --pointer '►' --marker=⦁ --height 60% --layout=reverse --color 'fg:#bdae93,fg+:#f9f5d7,hl:#fabd2f,hl+:#fabd2f,info:#8ec07c,pointer:#fb4934,marker:#fe8019,bg+:-1'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
bindkey '^f' fzf-cd-widget
export FZF_DEFAULT_OPTS='--preview-window border-sharp -i --height=50%'
export FZF_TMUX=1
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# NNN
export NNN_PLUG='p:preview-tui;i:imgview;j:autojump;v:rsynccp'
export NNN_FIFO=/tmp/nnn.fifo
export NNN_FCOLORS='0000d6000000000000000000'

source ~/powerlevel10k/powerlevel10k.zsh-theme

[[ ! -f ~/.dotfiles/config/zsh/.p10k.zsh ]] || source ~/.dotfiles/config/zsh/.p10k.zsh
