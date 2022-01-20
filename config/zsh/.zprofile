
if [[ ! ${DISPLAY} && ${XDG_VTNR} == 8 ]]; then
    exec startx
fi

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi
# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the list of directories that Zsh searches for programs.
path=(
  /usr/local/{bin,sbin}
  $path)

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

# Editors
export EDITOR='/usr/bin/nvim'
export VISUAL='/usr/bin/nvim'
export PAGER='less'
export LESS='-g -i -M -R -S -w -X -z-4'
# pfetch config
export PF_INFO="ascii title os kernel wm pkgs memory shell"
export FZF_DEFAULT_OPTS='--color fg:#ebdbb2,bg:#1d2021,hl:#d79921,fg+:#689d6a,bg+:#282828,hl+:#fabd2f,info:#83a598,prompt:#bdae93,spinner:#b16286,pointer:#689d6a,marker:#fe8019,header:#665c54 --border'
#geometry-zsh config
sep() {echo "➤"}
GEOMETRY_STATUS_SYMBOL="❃"
GEOMETRY_STATUS_SYMBOL_ERROR="❃"
GEOMETRY_PROMPT+=(sep)
GEOMETRY_STATUS_COLOR="magenta"
GEOMETRY_STATUS_COLOR_ERROR="red"
#LS Colors
alias ls='ls -F --color=auto'
alias ll='ls -lh --color=auto'
alias lt='ls --human-readable --size -1 -S --classify --color=auto'
#Config Files
alias zrc="nvim ~/.zprofile"
alias zp="nvim ~/.zpretzorc"
alias vrc="cd ~/.config/nvim && nvim ~/.config/nvim/lua/custom/chadrc.lua"
alias arc="cd ~/.config/awesome && nvim ~/.config/awesome/rc.lua"
# Quick Shortcuts
alias s="sudo"
alias x="clear"
alias r="ranger"
alias q="exit"
alias :q="exit"
alias :q!="exit"
alias ws="cd /home/gcc/workspace"
alias todo="nvim ~/org/refile.org"
# Paru 
alias paruconf="paru -Pg"
alias upgrade="paru -Syu"
alias up="paru -Syu"
alias install="paru -Slq | fzf --multi --preview 'paru -Si {1}' | xargs -ro paru -S"
alias in="paru -Slq | fzf --multi --preview 'paru -Si {1}' | xargs -ro paru -S"
alias uninstall="paru -Qq | fzf --multi --preview 'paru -Qi {1}' | xargs -ro paru -Rns"
alias un="paru -Qq | fzf --multi --preview 'paru -Qi {1}' | xargs -ro paru -Rns"
alias clean="paru -Rs $(paru -Qqtd)"
# Pi Server
alias pi="ssh pi@sftp.memeware.us -p 90"
alias pugshare="sftp -P 90 pug@sftp.memeware.us"
# Launch Project Zomboid Server
alias zomboid="cd /data/games/steam/steamapps/common/Project\ Zomboid\ Dedicated\ Server\/ && bash start-server.sh"
# Custom LS Colors
export LS_COLORS='no=00:fi=00:di=34:ow=34;40:ln=35:pi=30;44:so=35;44:do=35;44:bd=33;44:cd=37;44:or=05;37;41:mi=05;37;41:ex=01;31:*.cmd=01;31:*.exe=01;31:*.com=01;31:*.bat=01;31:*.reg=01;31:*.app=01;31:*.txt=32:*.org=32:*.md=32:*.mkd=32:*.h=32:*.c=32:*.C=32:*.cc=32:*.cpp=32:*.cxx=32:*.objc=32:*.sh=32:*.csh=32:*.zsh=32:*.el=32:*.vim=32:*.java=32:*.pl=32:*.pm=32:*.py=32:*.rb=32:*.hs=32:*.php=32:*.htm=32:*.html=32:*.shtml=32:*.erb=32:*.haml=32:*.xml=32:*.rdf=32:*.css=32:*.sass=32:*.scss=32:*.less=32:*.js=32:*.coffee=32:*.man=32:*.0=32:*.1=32:*.2=32:*.3=32:*.4=32:*.5=32:*.6=32:*.7=32:*.8=32:*.9=32:*.l=32:*.n=32:*.p=32:*.pod=32:*.tex=32:*.go=32:*.bmp=33:*.cgm=33:*.dl=33:*.dvi=33:*.emf=33:*.eps=33:*.gif=33:*.jpeg=33:*.jpg=33:*.JPG=33:*.mng=33:*.pbm=33:*.pcx=33:*.pdf=33:*.pgm=33:*.png=33:*.PNG=33:*.ppm=33:*.pps=33:*.ppsx=33:*.ps=33:*.svg=33:*.svgz=33:*.tga=33:*.tif=33:*.tiff=33:*.xbm=33:*.xcf=33:*.xpm=33:*.xwd=33:*.xwd=33:*.yuv=33:*.aac=33:*.au=33:*.flac=33:*.m4a=33:*.mid=33:*.midi=33:*.mka=33:*.mp3=33:*.mpa=33:*.mpeg=33:*.mpg=33:*.ogg=33:*.ra=33:*.wav=33:*.anx=33:*.asf=33:*.avi=33:*.axv=33:*.flc=33:*.fli=33:*.flv=33:*.gl=33:*.m2v=33:*.m4v=33:*.mkv=33:*.mov=33:*.MOV=33:*.mp4=33:*.mp4v=33:*.mpeg=33:*.mpg=33:*.nuv=33:*.ogm=33:*.ogv=33:*.ogx=33:*.qt=33:*.rm=33:*.rmvb=33:*.swf=33:*.vob=33:*.webm=33:*.wmv=33:*.doc=31:*.docx=31:*.rtf=31:*.dot=31:*.dotx=31:*.xls=31:*.xlsx=31:*.ppt=31:*.pptx=31:*.fla=31:*.psd=31:*.7z=1;35:*.apk=1;35:*.arj=1;35:*.bin=1;35:*.bz=1;35:*.bz2=1;35:*.cab=1;35:*.deb=1;35:*.dmg=1;35:*.gem=1;35:*.gz=1;35:*.iso=1;35:*.jar=1;35:*.msi=1;35:*.rar=1;35:*.rpm=1;35:*.tar=1;35:*.tbz=1;35:*.tbz2=1;35:*.tgz=1;35:*.tx=1;35:*.war=1;35:*.xpi=1;35:*.xz=1;35:*.z=1;35:*.Z=1;35:*.zip=1;35:*.ANSI-30-black=30:*.ANSI-01;30-brblack=01;30:*.ANSI-31-red=31:*.ANSI-01;31-brred=01;31:*.ANSI-32-green=32:*.ANSI-01;32-brgreen=01;32:*.ANSI-33-yellow=33:*.ANSI-01;33-bryellow=01;33:*.ANSI-34-blue=34:*.ANSI-01;34-brblue=01;34:*.ANSI-35-magenta=35:*.ANSI-01;35-brmagenta=01;35:*.ANSI-36-cyan=36:*.ANSI-01;36-brcyan=01;36:*.ANSI-37-white=37:*.ANSI-01;37-brwhite=01;37:*.log=01;32:*~=01;32:*#=01;32:*.bak=01;33:*.BAK=01;33:*.old=01;33:*.OLD=01;33:*.org_archive=01;33:*.off=01;33:*.OFF=01;33:*.dist=01;33:*.DIST=01;33:*.orig=01;33:*.ORIG=01;33:*.swp=01;33:*.swo=01;33:*,v=01;33:*.gpg=34:*.gpg=34:*.pgp=34:*.asc=34:*.3des=34:*.aes=34:*.enc=34:*.sqlite=34:'
