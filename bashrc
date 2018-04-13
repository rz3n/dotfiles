## functions
## ----------------------------------------------------------------------------

# function to extract files
extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)  tar xvjf $1 && cd $(basename "$1" .tar.bz2) ;;
      *.tar.gz)   tar xvzf $1 && cd $(basename "$1" .tar.gz) ;;
      *.tar.xz)   tar Jxvf $1 && cd $(basename "$1" .tar.xz) ;;
      *.bz2)    bunzip2 $1 && cd $(basename "$1" /bz2) ;;
      *.rar)    unrar x $1 && cd $(basename "$1" .rar) ;;
      *.gz)     gunzip $1 && cd $(basename "$1" .gz) ;;
      *.tar)    tar xvf $1 && cd $(basename "$1" .tar) ;;
      *.tbz2)   tar xvjf $1 && cd $(basename "$1" .tbz2) ;;
      *.tgz)    tar xvzf $1 && cd $(basename "$1" .tgz) ;;
      *.zip)    unzip $1 && cd $(basename "$1" .zip) ;;
      *.Z)    uncompress $1 && cd $(basename "$1" .Z) ;;
      *.7z)     7z x $1 && cd $(basename "$1" .7z) ;;
      *)      echo "don't know how to extract '$1'..." ;;
    esac
  else
    echo "'$1' is not a valid file!"
  fi
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

# function to get ip's from asn
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
# sudo apt-get -o Dpkg::Options::="--force-confmiss" install --reinstall $1
  sudo apt-get --reinstall -o Dpkg::Options::="--force-confask" install $1
}

# update
update() {
  sudo apt update
  sudo apt dist-upgrade
}

reloadrc() {
  source ~/.bashrc
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


## defaults
## ----------------------------------------------------------------------------

# history config
export HISTTIMEFORMAT="%F %T "
export HISTFILESIZE=3000
export HISTSIZE=1000
export HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  # We have color support; assume it's compliant with Ecma-48
  # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
  # a case would tend to support setf rather than setaf.)
  color_prompt=yes
  else
  color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*)
  ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
  fi
fi
