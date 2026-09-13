# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

alias e='exit'

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

# this line was added during EVE Online debugging.
#export VKD3D_VULKAN_DEVICE_NAME="9070 XT"

. "$HOME/.cargo/env"

# >>> grok installer >>>
export PATH="$HOME/.grok/bin:$PATH"
[[ -r "$HOME/.grok/completions/bash/grok.bash" ]] && source "$HOME/.grok/completions/bash/grok.bash"
# <<< grok installer <<<

echo '----------------'
echo 'BEG ~/.bashrc'

export PATH="$HOME/bin/nvim/v0.12.4/bin:$PATH"
export PATH="$HOME/bin/zig/0.15.2:$PATH"

# make sort treat underscore as a regular symbol.
export LC_COLLATE=C

set -o vi
bind 'set bell-style none'

function cl(){
    cd $1
    ls -a
}

bg_job_count(){
    local count
    count=$(jobs -p | wc -l)
    if [ "$count" -gt 0 ]; then
        echo "[$count bg]"
    fi
}
# strip the trailing dollar sign from the current PS1, append job_count, and add dollar sign back
PS1="${PS1%\\\$ } \$(bg_job_count)\\\$ "


#alias cp='cp -n' # deprecated
alias cp='cp -i' # interactive. warn if about to overwrite.
alias mv='mv -n'
alias clear='clear -x' # preserves contents of scrollback buffer.

[[ $- == *i* ]] && echo 'interactive shell' || echo 'non-interactive shell' 
shopt -q login_shell && echo 'login shell' || echo 'non-login shell'
echo ''

# brave startup in .desktop file needs these args for hardware accel on wayland:
# /usr/bin/brave-browser-stable --ozone-platform-hint=wayland --start-maximized --render-node-override=/dev/dri/renderD128 --gpu-vaapi-driver-device-path=/dev/dri/renderD128 
# --ignore-gpu-blocklist --disable-gpu-driver-bug-workarounds --enable-features=VaapiVideoDecoder,AcceleratedVideoDecodeLinuxGL 
# --disable-features=Vulkan,DefaultANGLEVulkan,VulkanFromANGLE,UseChromeOSDirectVideoDecoder

echo "nix installed with apt"
echo 'alacritty installed with cargo install alacritty'
echo 'alacritty config at ~/.config/alacritty/alacritty.toml'
echo 'alacritty themes at ~/src/alacritty-theme/themes'
echo 'alacritty copy paste: ctrl+shift+c, ctrl+shift+v'
# echo "alacritty shortcut created with: "
# printf '%s\n' '[Desktop Entry]' 'Type=Application' 'Name=Alacritty' 'Exec=alacritty' 'org.gnome.Terminal-symbolic' 'Terminal=false' 'Categories=System;TerminalEmulator;' > ~/.local/share/applications/alacritty.desktop
# gsettings set org.cinnamon demands-attention-passthru-wm-classes "['gnome-screenshot', 'lxterminal', 'xfce4-terminal', 'firefox', 'libreoffice', 'soffice', 'Alacritty']"
#echo 'wezterm installed with apt'
#echo 'zellij installed with cargo install zellij --locked'
#echo 'zellij config at ~/.configs/zellij'
#echo 'zellij run with blank config: zellij --config-dir ~/'
echo 'tmux installed with apt install tmux'
echo 'tmux config at ~/.tmux.conf'
echo 'nvim downloaded from https://github.com/neovim/neovim/releases'
echo 'nvim config at ~/.config/nvim'
echo ''

echo 'monitor brightness up: ddcutil setvcp 10 + 5'
echo 'monitor brightness up, down: meta-f11, meta-f12'
echo "snapshot root and home: sudo snapper -c root create -d "manual" && sudo snapper -c home create -d \"manual\""
echo "sudo snapper-gui"
echo 'man, info, man man, info info, man -a intro'
echo 'man -k . | sort | less'
echo 'info -o - | grep \* | sort | less'
echo 'alacritty listkeys how??, nvim listkeys how??'
echo 'tmux list-keys'
echo 'tmux help: ctrl+b ?'
echo 'tmux capture pane: ctrl+space b'
echo 'tmux respawn pane (reload configs): ctrl+space R'
echo 'tmux start debug script: ctrl+space e'
echo 'END ~/.bashrc'
echo '----------------'

. "$HOME/.local/bin/env"
