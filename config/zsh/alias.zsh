# Quick Shortcuts
alias n="nnn -eA"
alias k="kubectl"
alias zsrc="source ~/.zshrc"
alias grep="rg"
alias grepl="rg | less -R"
alias q="exit"

# PARU 
alias update="sudo btrfs-snp / syschanges 3 600 && paru -Syu --removemake  --sudoloop"
alias install="paru -Slq | fzf --multi --border=sharp --preview 'paru -Si {1}' | xargs -ro paru -S --removemake --sudoloop"
alias remove="paru -Qq | fzf --multi --preview 'paru -Qi {1}' | xargs -ro paru -Rcns"
alias cclean="sudo paccache -rk3 && sudo pacman -Sc --noconfirm"
alias pclean="paru -Qdtq | xargs -ro paru -Rs"

# GIT
alias fu="git commit -am 'fixup'"
alias fug="git commit -am 'fixup' && git rebase -i HEAD~2 && git push -f"

# LS
EZA_ICON_SPACING=2
alias ls='eza --icons --group-directories-first'
alias la='eza -la --icons --git --group-directories-first'
alias ll='eza -l --icons --git --group-directories-first'
alias lt='eza --tree --level=2 --icons --group-directories-first --git-ignore --ignore-glob "cache"  --ignore-glob "log" --ignore-glob "logs"'
