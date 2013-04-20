# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="r"

# some config stuffs
export EDITOR=vim
export GRAPHIC_EDITOR="gvim"

# basic paths
export dot_file="~/workshop/dot-laptop/"
export notes="/home/hbc/Documents/Notes/"
export thoughts="/home/hbc/Documents/Randoms/"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias gcc="gcc -Wall"  # always use Wall
alias vv="source venv/bin/activate"
alias dv="deactivate"
alias python='python2'
#alias pip='pip2'
alias virtualenv='virtualenv2'
alias tm=${dot_file}tmuxen
alias goagent='python ~/workshop/goagent/local/proxy.py'
alias pasteit='xclip -o'
alias pi=pasteit
alias px='proxychains'
alias ev='vim ~/.zshrc'
alias sv='source ~/.zshrc'
alias sd='sudo'
alias gip='git clone `pi`'
alias gj_solve='python ~/workshop/dsibh/gj_elimination/main.py'
alias tellme='apropos'
alias vbox='sd modprobe vboxdrv && sd modprobe vboxnetflt && sd modprobe vboxnetadp'
alias lx='python ~/workshop/other/xunlei-lixian/lixian_cli.py'
alias t='python ~/workshop/misc/t/t.py --task-dir ~/Documents/tasks --list tasks'
alias ohnotes='python ~/workshop/ohnotes/run.py'
alias upnotes='ohnotes update -p $notes'
alias ss='killall ssh & sleep 1s && ssh -p223 -qTfnN -D7777 jp.fanhe.org'
alias extract='dtrx'
alias ssocks='python ~/workshop/other/shadowsocks/local.py'
alias fmc='~/workshop/other/fmc/fmc'
alias fmd='~/workshop/fmd/fmd'

# a bit awkward :)
alias wee='ln -s ~/workshop/wee/*.less . && rm variables.less && cp ~/workshop/wee/variables.less .'
alias tdark='feh --bg-center ~/Documents/Pictures/dark'
alias tlight='feh --bg-tile ~/Documents/Pictures/light'
alias b='acpi'
alias vsheep='source ~/workshop/other/sheep/venv/bin/activate'
alias xon='xrandr --output LVDS1 --auto --output VGA1 --mode 1440x900_60.00 --left-of LVDS1'
alias xoff='xrandr --output VGA1 --off --output LVDS1 --auto'
alias chromium-browser='chromium'

# for fun
alias csf='fortune linux science definitions | cowsay -f small'
alias poem='fortune song100 tang300'
alias music='mplayer -shuffle -playlist ~hbc/Documents/Music/all -vo null'

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

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

compctl -g '~/.teamocil/*(:t:r)' teamocil

# Customize to your needs...
export PATH=/home/hbc/.gem/ruby/2.0.0/bin:/var/lib/gems/2.0.0/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/bin/core_perl:/home/hbc/.local/bin:/home/hbc/bin:/home/hbc/workshop/misc:/usr/bin/npm:/usr/bin/node:/usr/local/lib:$PATH

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

# startup
# csf
