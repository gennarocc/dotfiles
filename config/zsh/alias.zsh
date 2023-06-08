# Quick Shortcuts
alias n="nnn -e"
alias k="kubectl"
alias zsrc="source ~/.zshrc"
alias q="exit"
alias grep="rg"
alias grepl="rg | less -R"
alias q="exit"

# PARU 
alias update="sudo btrfs-snp / syschanges 3 600 && paru -Syu --removemake  --sudoloop"
alias install="paru -Slq | fzf --multi --border=sharp --preview 'paru -Si {1}' | xargs -ro paru -S --removemake --sudoloop"
alias remove="paru -Qq | fzf --multi --preview 'paru -Qi {1}' | xargs -ro paru -Rcns"
alias cclean="sudo paccache -rk3 && sudo pacman -Sc --noconfirm"
alias pclean="paru -Qdtq | xargs -ro paru -Rs"

# UTILS
# Creates archive in current dir
alias backup="sudo tar -cvzf backup-$(date +%s).tar.gz -C /srv/network/Music . -C /srv/network/Workspace . -C /srv/network/Pictures ."

# GIT
alias fu="git commit -am 'fixup'"
alias fug="git commit -am 'fixup' && git rebase -i HEAD~2 && git push -f"

# LS
TREE_IGNORE="cache|log|logs|node_modules|vendor"
alias ls='exa --group-directories-first'
alias la='ls -a'
alias ll='ls --git -la'
alias lt='ls --tree -D -L 2 -I ${TREE_IGNORE}'
alias ltt='ls --tree -D -L 3 -I ${TREE_IGNORE}'
alias lttt='ls --tree -D -L 4 -I ${TREE_IGNORE}'
alias ltttt='ls --tree -D -L 5 -I ${TREE_IGNORE}'
