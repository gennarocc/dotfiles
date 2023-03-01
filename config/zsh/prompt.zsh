function prompt_setup {
  NEWLINE=$'\n'
  TOP_LEFT_CURVE="╭"
  BOTTOM_LEFT_CURVE="╰"
  TOP_LEFT="┌"
  BOTTOM_LEFT="└"
  LINE="─"
  PROMPT='%F{cyan}%f%n%F{black}.%f%M %F{magenta}in%f %2~%F{cyan}%f %F{magenta}λ%f '
  RPROMPT=''
}

prompt_setup "$@"
