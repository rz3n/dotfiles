## If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

## Path to your oh-my-zsh installation.
  export ZSH=~/.oh-my-zsh

## themes
## See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
## ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE="nerdfont-complete"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user dir rbenv vcs)

CASE_SENSITIVE="true"
# ENABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
# ZSH_CUSTOM=/path/to/new-custom-folder

## Plugins
plugins=(
  aws
  docker
  docker-compose
  docker-machine
  git
  github
  nmap
  sudo
  systemd
  tmux
  ubuntu
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

## User configuration
## --------------------------------------------------------
# export LANG=en_US.UTF-8

## Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

## ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"


## functions
## --------------------------------------------------------

# function to extract files
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

# function to show external ip address
meuip () {
  curl 'meuip.gtek.com.br'
  echo
}

# function to generate secure password
password () {
  date +%s | sha256sum | base64 | head -c 32 ; echo
  date +%s | sha512sum | base64 | head -c 15 ; echo
  date | sha512sum | base64 | head -c 10 ; echo
  </dev/urandom tr -dc '12345!@*)%qwertQWERTasdfgASDFGzxcvbZXCVB' | head -c15; echo ""
}

# function to generate puppet passwords
password-puppet () {
  mkpasswd -m sha-512 $1
}

# function to show all facebook asn's
facebook-asn () {
  whois -h whois.radb.net -- '-i origin AS32934' | grep -Eo "([0-9.]+){4}/[0-9]+"
}
get-asn () {
  whois -h whois.radb.net -- "-i origin $1" | grep -Eo "([0-9.]+){4}/[0-9]+"
}


# history with grep
h() {
  if [ -z "$1" ]
  then
    history
  else
    history | grep "$@"
  fi
}

# sync
sync() {
  echo "rsync --exclude '*.abc' -avz -e ssh myname@servername:foldertocpy ."
}

# apt-clean
apt-clean() {
  sudo apt-get clean
  sudo apt-get autoclean
  sudo apt-get autoremove
  sudo apt-get clean cache
}

# apt-rebuild
apt-rebuild() {
#   sudo apt-get -o Dpkg::Options::="--force-confmiss" install --reinstall $1
  sudo apt-get --reinstall -o Dpkg::Options::="--force-confask" install $1
}

# youtube-playlist
music-yt() {
  mpsyt
}

# youtube-dl
youtube-dl-pl-mp3() {
  youtube-dl --extract-audio --audio-format mp3 -o %\(title\)s.%\(ext\)s $1
}

# update
update() {
  sudo snap refresh
  sudo apt update
  sudo apt dist-upgrade
}

reloadrc() {
  source ~/.zshrc
}

isodd() {
  sudo dd bs=4M if=$1 of=$2
}


## aliases
## ----------------------------------------------------------------------------

alias apt-get='apt'
alias apt='sudo apt'

alias which='type -all'
alias mkdir='mkdir -pv'

alias less='less -FSRXc'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
