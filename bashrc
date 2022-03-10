# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment 
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

### tmux with each login shell ###
if [[ $DISPLAY ]]; then
        [[ $- != *i* ]] && return
        [[ -z "$TMUX" ]] && exec tmux
fi

### Alias ###

# Containers #
alias bwapp="podman run -it --name=bwapp -p 8000:80 h0pp/bwapp"
alias sqli-labs="podman run -it --name=sqli-labs -p 8080:80 acgpiano/sqli-labs"
alias kalilinux="podman run -it --name=kalilinux toolisticon/kalilinux"
alias juiceshop="podman run -it --name=juiceshop -p 3000:3000 bkimminich/juice-shop"
alias dvwa="podman run -it --name=dvwa -p 8080:80 sagikazarmark/dvwa"

# xrandr #
alias leftoff="xrandr --output eDP --off"
alias lefton="xrandr --output eDP --auto --right-of HDMI-A-0"

# Applications # 
alias vim=nvim
alias vi=nvim
alias sudo='doas'
alias rr=ranger
alias pacsyu='sudo pacman -Syyu'
alias ..='cd ..'

# ls and grep color
alias exa='exa -lah --color=auto'
alias ls='exa'
alias grep='grep --color=auto'

# confirmations
alias mv='mv -i'
alias cp='cp -i'
#alias rm='rm -i'

# mkdir create parents
alias mkdir='mkdir -pv'

# vi mode in bash
set -o vi
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

#Setting default editor
export EDITOR=nvim
export VISUAL="$VISUAL"
export VISUAL=nvim

export PS1="\e[0;32m[\h \W]\$ \e[0m"


# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
