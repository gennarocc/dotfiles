
# Dotfiles

My shell config. Managed by [dotbot](https://github.com/anishathalye/dotbot)

### Required packages

```
zsh neovim exa tmux fzf nnn ripgrep rsync bat jump fd
```

### Install
```
git clone --recurse-submodules git@github.com:gennarocc/dotfiles.git .dotfiles
cd ./.dotfiles
./install
```

### Aliases
```
# Navigation
n               # Launch nnn file manager
fw              # Fuzzy find workspace projects

# Git shortcuts
fu              # Quick fixup commit
fug             # Fixup + rebase + force push
fb              # Fuzzy branch checkout
glog            # Interactive git log viewer

# Package management (Arch)
update          # System update with btrfs snapshot
install         # Fuzzy package installation
remove          # Fuzzy package removal
cclean          # Clean package cache
pclean          # Remove orphaned packages

# Enhanced ls (using exa)
ls              # Basic listing
la              # Show all files
ll              # Long format with git status
lt              # Tree view (depth 2)
ltt/lttt/ltttt  # Tree views (depth 3/4/5)

# Utilities
grep            # Uses ripgrep (rg)
k               # kubectl shortcut
zsrc            # Reload zsh config
```
