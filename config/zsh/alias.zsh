# Go Back 
alias -- -='cd -'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'

# FOlders
alias md='mkdir -p'
alias rd=rmdir

#Config Files
alias dots="cd ~/.dotfiles"
alias zrc="nvim ~/.zprofile && source ~/.zshrc"
alias arc="cd ~/.config/awesome && nvim rc.lua"

# Quick Shortcuts
alias q="exit"
alias ip4="curl https://echoip.xyz"
alias grep="rg"
alias grepl="rg | less -R"
alias q="exit"

# PARU 
alias update="paru -Syu --removemake  --sudoloop"
alias install="paru -Slq | fzf --multi --preview 'paru -Si {1}' | xargs -ro paru -S --removemake --sudoloop"
alias remove="paru -Qq | fzf --multi --preview 'paru -Qi {1}' | xargs -ro paru -Rcns"
alias cclean="sudo paccache -rk3 && sudo pacman -Sc --noconfirm"
alias pclean="paru -Qdtq | xargs -ro paru -Rs"

# LS
TREE_IGNORE="cache|log|logs|node_modules|vendor"
alias ls='exa --group-directories-first'
alias la='ls -a'
alias ll='ls --git -la'
alias lt='ls --tree -D -L 2 -I ${TREE_IGNORE}'
alias ltt='ls --tree -D -L 3 -I ${TREE_IGNORE}'
alias lttt='ls --tree -D -L 4 -I ${TREE_IGNORE}'
alias ltttt='ls --tree -D -L 5 -I ${TREE_IGNORE}'
