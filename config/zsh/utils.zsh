source_file() {
  if [[ -f $ZDOTDIR/$1 ]]; then
    source $ZDOTDIR/$1
  else
    echo -e "\e[93m \e[97mFile $1 does not exist"
  fi
}

add_plugin() {
  if [[ -d $ZDOTDIR/plugins/$1 ]]; then
    source $ZDOTDIR/plugins/$1/$1.plugin.zsh
  else
    echo -e "\e[93m \e[97mPlugin $1 does not exist"
  fi
}
