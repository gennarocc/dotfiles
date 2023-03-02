function prompt_setup {
  autoload -Uz add-zsh-hook vcs_info
  setopt prompt_subst
  RPROMPT='%F{cyan}${vcs_info_msg_0_}%f'
  zstyle ':vcs_info:*' check-for-changes true
  zstyle ':vcs_info:*' unstagedstr ' *'
  zstyle ':vcs_info:*' stagedstr ' +'
  zstyle ':vcs_info:git:*' formats       '[%b%u%c]'
  zstyle ':vcs_info:git:*' actionformats '[%b|%a%u%c]'

  PROMPT='%F{blue}%2~%f %F{magenta}λ%f '
}

prompt_setup "$@"
