eval "$(jump shell)"

source $ZDOTDIR/utils.zsh

plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting 
)

for plugin in ${plugins[@]}; do
  add_plugin $plugin
done

source_file prompt.zsh
source_file functions.zsh
source_file history.zsh
source_file alias.zsh
source_file completion.zsh
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

setopt GLOB_COMPLETE
setopt MENU_COMPLETE
setopt AUTO_CD
setopt LIST_PACKED
setopt AUTO_LIST
setopt COMPLETE_IN_WORD

# FZF
export FZF_DEFAULT_OPTS='--preview-window border-sharp -i --height=50%'
export FZF_TMUX=1

# NNN
export NNN_PLUG='p:preview-tui;i:imgview;j:autojump;v:rsynccp'
export NNN_FIFO=/tmp/nnn.fifo
export NNN_FCOLORS='0000d6000000000000000000'

