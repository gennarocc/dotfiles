# Shows projects in workspace.
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


# Fuzzy find branch in current repo.
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

# Git log viewer with fuzzy find.
function glog () {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --toggle-sort=\` \
      --bind "ctrl-m:execute:
                echo '{}' | grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R'"
}


# View files changed / git status
function gstat() {
  git rev-parse HEAD > /dev/null 2>&1 || { echo "Not in a git repo"; return 1; }

  local preview='git diff --no-ext-diff --color=always -- {-1} 2>/dev/null'
  if command -v delta > /dev/null; then
    preview="$preview | delta"
  fi
  if command -v bat > /dev/null; then
    preview="$preview; bat --style=plain --color=always {-1} 2>/dev/null"
  elif command -v batcat > /dev/null; then
    preview="$preview; batcat --style=plain --color=always {-1} 2>/dev/null"
  else
    preview="$preview; cat {-1} 2>/dev/null"
  fi

  git -c color.status=always status --short --no-branch |
  fzf --ansi -m --nth 2..,.. \
    --layout=reverse --height=80% --min-height=20 \
    --preview-window='right,55%' \
    --bind "alt-e:execute:${EDITOR:-vim} {-1} > /dev/tty" \
    --bind 'ctrl-/:change-preview-window(down,50%|hidden|)' \
    --header 'ALT-E (open in editor)' \
    --preview "$preview" "$@" |
  cut -c4- | sed 's/.* -> //'
}

# Interactive ripgrep
# ripgrep->fzf->vim [QUERY]
function rfv() (
  RELOAD='reload:rg --column --color=always --smart-case {q} || :'
  OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
            vim {1} +{2}     # No selection. Open the current line in Vim.
          else
            vim +cw -q {+f}  # Build quickfix list for the selected items.
          fi'
  fzf --disabled --ansi --multi \
      --bind "start:$RELOAD" --bind "change:$RELOAD" \
      --bind "enter:become:$OPENER" \
      --bind "ctrl-o:execute:$OPENER" \
      --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
      --delimiter : \
      --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
      --preview-window '~4,+{2}+4/3,<80(up)' \
      --query "$*"
)

alias fw="fw"
alias fdrc="fdrc"
alias fdri="fdri"
alias gb="gb"
alias glog="glog"
alias rfv="rfv"
alias gstat="gstat"
