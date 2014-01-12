ZSH=$HOME/.oh-my-zsh
ZSH_THEME="prose"

# better cd
. ~/workshop/other/z/z.sh

# autoenv
source ~/.autoenv/activate.sh

# editor settings
export EDITOR=vim
export GRAPHIC_EDITOR="gvim"

# reload zsh configurations
alias ev='vim ~/.zshrc'
alias sv='source ~/.zshrc'

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git battery)

source $ZSH/oh-my-zsh.sh


# --------------------------------
# CUSTOMIZE STARTS HERE
# --------------------------------

# --------------------------------
# PATH SETTINGS
# --------------------------------

LOCAL_APP=$HOME/workshop/app
LOCAL_APP_BIN=$LOCAL_APP/bin

export PATH=$LOCAL_APP_BIN:$PATH

WORKSHOP=$HOME/workshop

# --------------------------------
# ALIAS
# --------------------------------

# monitor brightness
alias bu='xbacklight -inc 10'
alias bd='xbacklight -dec 10'

alias sd='sudo'  # not please, please!

# tmux
alias tl='tmux list-sessions'
alias ta='tmux attach-session -t'

alias gcc="gcc -Wall"  # always use Wall

# virtualwrapper
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$WORKSHOP
source ~/.local/bin/virtualenvwrapper.sh

# go
export GOPATH=$WORKSHOP/go
export PATH=$PATH:$GOPATH/bin
