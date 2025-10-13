# XDG Base Directory Specification
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache

# Zsh config dir
export ZDOTDIR=$HOME/.dotfiles/config/zsh

if [ -d "$HOME/.local/bin" ]; then
	PATH="$HOME/.local/bin:$PATH"
fi

# Editor vars
export TERM="xterm-256color"
export EDITOR=nvim
export GOPATH=$XDG_CONFIG_HOME/go
