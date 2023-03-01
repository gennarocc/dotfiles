function calc() {
  bc -l <<< $@
}

function weather () {
  local options="${2:-1}"
  curl https://wttr.in/"${1}"\?"${options}"
}

alias exp="exp"
alias calc="calc"
alias weather="weather"
alias matrix="matrix"
