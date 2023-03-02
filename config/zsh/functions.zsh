fw() {
  local projects=$HOME/Workspace

  if [[ ! -d $projects ]]; then
    echo -e "$projects dir does not exist"
    return 1
  fi

  local project=$(fd -t d --max-depth 1 . $projects | awk -F/ '{print $(NF-1)}' | fzf)

  [[ -z $project ]] && return

  cd $projects/$project
}

fc() {
  local projects=$HOME/.dotfiles/config

  if [[ ! -d $projects ]]; then
    echo -e "$projects dir does not exist"
    return 1
  fi

  local project=$(fd -t d --max-depth 1 . $projects | awk -F/ '{print $(NF-1)}' | fzf)

  [[ -z $project ]] && return

  cd $projects/$project
}

alias fw="fw"
alias fc="fc"
alias calc="calc"
