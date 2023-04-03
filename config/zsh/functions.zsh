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

function fc () {
  local projects=$HOME/.dotfiles/config

  if [[ ! -d $projects ]]; then
    echo -e "$projects dir does not exist"
    return 1
  fi

  local project=$(fd -t d --max-depth 1 . $projects | awk -F/ '{print $(NF-1)}' | fzf)

  [[ -z $project ]] && return

  cd $projects/$project
}

# Git Function

function fb(){
    if git rev-parse --git-dir > /dev/null 2>&1; then
        if [[ "$#" -eq 0 ]]; then
            local branches branch
            branches=$(git branch -a) &&
            branch=$(echo "$branches" |
            fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
            git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
        elif [ `git rev-parse --verify --quiet $*` ] || \
             [ `git branch --remotes | grep  --extended-regexp "^[[:space:]]+origin/${*}$"` ]; then
            echo "Checking out to existing branch"
            git checkout "$*"
        else
            echo "Creating new branch"
            git checkout -b "$*"
        fi
    else
        echo "Can't check out or create branch. Not in a git repo"
    fi
}

function glog () {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --toggle-sort=\` \
      --bind "ctrl-m:execute:
                echo '{}' | grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R'"
}

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

