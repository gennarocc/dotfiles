function fw () {
  local projects=$HOME/Workspace

  if [[ ! -d $projects ]]; then
    echo -e "$projects dir does not exist"
    return 1
  fi

  local project=$(fd -t d --max-depth 1 . $projects | awk -F/ '{print $(NF-1)}' | fzf)

  [[ -z $project ]] && return

  cd $projects/$project
}

# function fc () {
#   local projects=$HOME/.dotfiles/config
#
#   if [[ ! -d $projects ]]; then
#     echo -e "$projects dir does not exist"
#     return 1
#   fi
#
#   local project=$(fd -t d --max-depth 1 . $projects | awk -F/ '{print $(NF-1)}' | fzf)
#
#   [[ -z $project ]] && return
#
#   cd $projects/$project
# }

# DOCKER FUNCTIONS

function fdrc () {
  local containers=$(docker ps | tail -n +2 | awk '{print $1" "$NF}' | fzf -m | cut -d " " -f 1 | tr "\n" " ")

  [[ -z $containers ]] && return

  docker rm $(echo $containers) -f
}

function fdri () {
  local images=$(docker images | tail -n +2 | awk '{print $1" "$3}' | fzf -m |  cut -d " " -f 2 | tr "\n" " ")

  [[ -z $images ]] && return

  docker rmi $(echo $images) -f
}


alias fdrc="fdrc"
alias fdri="fdri"
alias fw="fw"
alias fc="fc"
alias gc="gb"
alias glog="glog"

