ZSH=$HOME/.oh-my-zsh
ZSH_THEME="prose"

# better cd
. ~/workshop/other/z/z.sh

# some basic stuffs
export EDITOR=vim
export GRAPHIC_EDITOR="gvim"

# basic paths
export dot_file="~/workshop/dot-laptop/"
export notes="/home/hbc/Documents/Notes/"
export thoughts="/home/hbc/Documents/Randoms/"
export snippets="/home/hbc/workshop/snippets/"

# reloaded!
alias ev='vim ~/.zshrc'
alias sv='source ~/.zshrc'

# always use Wall
alias gcc="gcc -Wall"

# for virtualvenv
alias vv="source venv/bin/activate"
alias dv="deactivate"

# still stick to python2...
alias python='python2'
# alias pip='pip2'
alias virtualenv='virtualenv2'

# shortcuts
alias tm=${dot_file}tmuxen
alias pasteit='xclip -o'
alias pi=pasteit
alias px='proxychains'
alias sd='sudo'
alias gip='git clone `pi`'
alias gj_solve='python ~/workshop/dsibh/gj_elimination/main.py'
alias tellme='apropos'
alias vbox='sd modprobe vboxdrv && sd modprobe vboxnetflt && sd modprobe vboxnetadp'
alias lx='python ~/workshop/other/xunlei-lixian/lixian_cli.py'
alias t='python ~/workshop/misc/t/t.py --task-dir ~/Documents/tasks --list tasks'
alias ohnotes='python ~/workshop/ohnotes/run.py'
alias upnotes='ohnotes update -p $notes'
alias extract='dtrx'
alias ssocks='python ~/workshop/other/shadowsocks/local.py'
alias fmc='~/workshop/other/fmc/fmc'
alias fmd='~/workshop/fmd/fmd'
alias pod_cut='~/workshop/podcast/cut.sh'
alias vs='~/workshop/podcast/crop.sh'
alias sass='sass --no-cache' # no cache directory
alias tdark='feh --bg-center ~/Documents/Pictures/dark'
alias tlight='feh --bg-tile ~/Documents/Pictures/light'
alias b='acpi' # for battery
alias xon='xrandr --output LVDS1 --auto --output VGA1 --mode 1440x900_60.00 --left-of LVDS1'
alias xoff='xrandr --output VGA1 --off --output LVDS1 --auto'
alias chromium-browser='chromium'
alias alert_helper='history|tail -n1|sed -e "s/^\s*[0-9]\+\s*//" -e "s/;\s*alert$//"'
alias alert='if [ $? -eq 0 ];then msgq "[$?] $(alert_helper)" -m cli -t ret.success; else msgq "[$?] $(alert_helper)" -m cli -t ret.fail; fi'
alias glcc='gcc -L/usr/X11R6/lib -lglut -lGLU -lGL -lGLEW -lX11 -lXmu -lXi'
# just for fun
alias csf='fortune linux science definitions | cowsay -f small'
alias poem='fortune song100 tang300'
alias music='mplayer -shuffle -playlist ~hbc/Documents/Music/all -vo null'

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

compctl -g '~/.teamocil/*(:t:r)' teamocil

# Customize to your needs...
export PATH=/home/hbc/.gem/ruby/2.0.0/bin:/var/lib/gems/2.0.0/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/bin/core_perl:/home/hbc/.local/bin:/home/hbc/bin:/home/hbc/workshop/misc:/usr/bin/npm:/usr/bin/node:/usr/local/lib:/usr/local/heroku/bin:$PATH

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

export GOROOT=$HOME/workshop/temp/go
export PATH=$PATH:$GOROOT/bin:/usr/bin/vendor_perl:/usr/bin/site_perl:$snippets

# for android
export ANDROID_SDK_ROOT="/home/hbc/workshop/android/adt-bundle-linux-x86_64-20130729/sdk"
export PATH="$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools:$PATH"

# for sml
export SMLNJ_HOME="/usr/lib/smlnj"
export PATH="/usr/bin/smlnj/bin:$PATH"


# for wayland
WLD=$HOME/workshop/temp/wayland
LD_LIBRARY_PATH=$WLD/lib
PKG_CONFIG_PATH=$WLD/lib/pkgconfig/:$WLD/share/pkgconfig/
ACLOCAL="aclocal -I $WLD/share/aclocal"
