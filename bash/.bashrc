# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# FULL COLOR SUPPORT
export TERM=xterm-256color

# COMPLETION FEATURES
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

bind 'set completion-ignore-case on'

# HISTORY
export HISTSIZE=10000    # Number of lines saved in the history
export HISTFILESIZE=10000 # Maximum number of lines contained in the history file
export HISTCONTROL=ignoredups # Ignore duplicate commands
export HISTTIMEFORMAT="%F %T " # Add timestamp to history
shopt -s histappend # Append to the history file (don't overwrite it)

alias grep='grep --color=auto'

# LS ALIASES
alias ls='ls --color=never'
alias ll='ls -alF --color=never'
alias la='ls -A --color=never'
alias l='ls -CF --color=never'

# CD ALIASES
alias ..='cd ..'
alias ...='cd ../..'

# GIT ALIASES
alias gs='git status'
alias gl='git log'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gd='git diff'

# DIRECTORY ALIASES
alias docs='cd ~/Documents'
alias dl='cd ~/Downloads'
alias pics='cd ~/Pictures'
alias music='cd ~/Music'
alias vids='cd ~/Videos'
alias desktop='cd ~/Desktop'

alias etc='cd /etc' # System configuration files
alias var='cd /var' # Variable files like logs and databases
alias usr='cd /usr' # Read-only user data
alias opt='cd /opt' # Optional/add-on apps
alias lib='cd /lib' # Libraries essential for the binaries in /bin/ and /sbin/
alias srv='cd /srv' # Data for services provided by the system
alias tmp='cd /tmp' # Temporary files
alias root='cd /'   # Root of the filesystem

# EXTRACT FUNCTION
extract() {
    if [ -f "$1" ]; then
        case $1 in
            *.tar.bz2) tar xjf "$1" ;;
            *.tar.gz) tar xzf "$1" ;;
            *.tar.xz) tar xJf "$1" ;;
            *.bz2) bunzip2 "$1" ;;
            *.rar) rar x "$1" ;;
            *.gz) gunzip "$1" ;;
            *.tar) tar xf "$1" ;;
            *.tbz2) tar xjf "$1" ;;
            *.tgz) tar xzf "$1" ;;
            *.zip) unzip "$1" ;;
            *.Z) uncompress "$1" ;;
            *) echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

PS1='[\u@\h \W]\$ '

# PYENV SETUP
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"

# RUST SETUP
. "$HOME/.cargo/env"

# STARSHIP SETUP
eval "$(starship init bash)"
