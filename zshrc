
## oh-my-zsh folder
  export ZSH=~/.oh-my-zsh

## history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

## add timestamps to history
setopt EXTENDED_HISTORY
setopt PROMPT_SUBST
setopt CORRECT
setopt COMPLETE_IN_WORD

## adds history
setopt APPEND_HISTORY

## adds history incrementally and share it across sessions
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

## don't record dupes in history
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt HIST_EXPIRE_DUPS_FIRST

## themes
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE="nerdfont-complete"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user dir rbenv)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status vcs host)
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_STRATEGY=truncate_folders

CASE_SENSITIVE="true"
# COMPLETION_WAITING_DOTS="true"
# ENABLE_CORRECTION="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
# ZSH_CUSTOM=/path/to/new-custom-folder

## Plugins
plugins=(
  git
#  github
#  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

## User configuration
## --------------------------------------------------------
# export LANG=en_US.UTF-8
export LANG=en_CA.UTF-8

## Preferred editor for local and remote sessions
export EDITOR='vim'


## functions
## --------------------------------------------------------

## function to extract files
extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)  tar xvjf $1 && cd $(basename "$1" .tar.bz2) ;;
      *.tar.gz)   tar xvzf $1 && cd $(basename "$1" .tar.gz) ;;
      *.tar.xz)   tar Jxvf $1 && cd $(basename "$1" .tar.xz) ;;
      *.bz2)      bunzip2 $1 && cd $(basename "$1" /bz2) ;;
      *.rar)      unrar x $1 && cd $(basename "$1" .rar) ;;
      *.gz)       gunzip $1 && cd $(basename "$1" .gz) ;;
      *.tar)      tar xvf $1 && cd $(basename "$1" .tar) ;;
      *.tbz2)     tar xvjf $1 && cd $(basename "$1" .tbz2) ;;
      *.tgz)      tar xvzf $1 && cd $(basename "$1" .tgz) ;;
      *.zip)      unzip $1 && cd $(basename "$1" .zip) ;;
      *.Z)        uncompress $1 && cd $(basename "$1" .Z) ;;
      *.7z)       7z x $1 && cd $(basename "$1" .7z) ;;
      *)          echo "don't know how to extract '$1'..." ;;
    esac
  else
    echo "'$1' is not a valid file!"
  fi
}

## function to generate secure password
password () {
  date +%s | sha256sum | base64 | head -c 32 ; echo
  date +%s | sha512sum | base64 | head -c 15 ; echo
  date | sha512sum | base64 | head -c 10 ; echo
  </dev/urandom tr -dc '12345!@*)%qwertQWERTasdfgASDFGzxcvbZXCVB' | head -c15; echo ""
}

## function to generate puppet passwords
password-puppet () {
  mkpasswd -m sha-512 $1
}

## function to show all facebook asn's
facebook-asn () {
  whois -h whois.radb.net -- '-i origin AS32934' | grep -Eo "([0-9.]+){4}/[0-9]+"
}
get-asn () {
  whois -h whois.radb.net -- "-i origin $1" | grep -Eo "([0-9.]+){4}/[0-9]+"
}

## remove all comments from file
rmcomment () {
  cp $1 ${1}.bak
  grep -v "#" $1 > ${1}.nocomment
}

## history with grep
h() {
  if [ -z "$1" ]
  then
    history
  else
    history | grep "$@"
  fi
}

## apt-clean
apt-clean() {
  sudo apt-get clean
  sudo apt-get autoclean
  sudo apt-get autoremove
  sudo apt-get clean cache
}

## apt-rebuild
apt-rebuild() {
  sudo apt-get --reinstall -o Dpkg::Options::="--force-confask" install $1
}

## update
update() {
  sudo snap refresh
  sudo apt update
  sudo apt dist-upgrade
}

## reload rc configurations
reloadrc() {
  source ~/.zshrc
}


## aliases
## ----------------------------------------------------------------------------
alias docker='sudo docker'
alias docker-compose='sudo docker-compose'

alias apt-get='apt'
alias apt='sudo apt'

alias which='type -all'
alias mkdir='mkdir -pv'

alias less='less -FSRXc'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
