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

# tmux with each login shell
if [[ $DISPLAY ]]; then
        # If not running interactively, do not do anything
        [[ $- != *i* ]] && return
        [[ -z "$TMUX" ]] && exec tmux
fi


export VISUAL=nvim

# User specific aliases and functions
alias bwapp="podman run -it --name=bwapp -p 8000:80 h0pp/bwapp"
alias sqli-labs="podman run -it --name=sqli-labs -p 8080:80 acgpiano/sqli-labs"
alias kalilinux="podman run -it --name=kalilinux toolisticon/kalilinux"
alias juiceshop="podman run -it --name=juiceshop -p 3000:3000 bkimminich/juice-shop"
alias dvwa="podman run -it --name=dvwa -p 8080:80 sagikazarmark/dvwa"
alias leftoff="xrandr --output eDP --off"
alias lefton="xrandr --output eDP --auto --right-of HDMI-A-0"
alias vim=nvim
alias vi=nvim
#Running podman with selinux
alias fedorapod="podman run --name=fedorapod -v /home/ins/podman/fedora:/home:Z -it fedora bash"
alias archpod="podman run --name=archpod -v /home/ins/podman/archlinux:/home:Z -it archlinux bash"
#Setting default editor
export EDITOR=nvim
export VISUAL="$VISUAL"

# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
