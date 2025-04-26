# to activate on new system, append the following to ~/.bashrc:
# . ~/src/dotfiles/.bashrc

# useful binaries: xclip, fuzzy finder, ripgrep.

echo 'BEG ~/src/dotfiles/.bashrc'

# note that $- outputs builtin set flags. see man bash -> set subsection.
[[ $- == *i* ]] && echo 'interactive shell' || echo 'non-interactive shell' 
shopt -q login_shell && echo 'login shell' || echo 'non-login shell'

#echo '| find startup files: PS4='\''+$BASH_SOURCE> '\'' BASH_XTRACEFD=7 bash -x 1>/dev/null 7>bash_env.txt -i <(echo "exit")      |'
#echo '| copy:           ctrl-shift-c                | paste:                    ctrl-shift-v                                |'
#echo '| move win:       command + shift + arrow     | maximize win:             command + m                                 |'
#echo '| tmux help:      ctrl-b ?                    | tmux kill other sess:     ctrl-b s x y                                |'
#echo '| tmux new sess:  ctrl-b :new -s <name>       | exit neovim terminal:     ctrl-\ ctrl-n                               |'
#echo '| list env vars:  env | sort | pr -3t -w 180  | list path vars:           echo $PATH | tr : '\''\n'\'' | sort               |'

# start tmux immediately.
# https://unix.stackexchange.com/a/113768/604574
# NOTE: this may need modified if alacritty conf or tmux conf changes TERM.

#if command -v tmux &> /dev/null && \
#    [ -n "$PS1" ] && \
#    [[ ! "$TERM" =~ screen ]] && \
#    [[ ! "$TERM" =~ tmux ]] && \
#    [[ ! "$TERM" =~ tmux-256color ]] && \
#    [ -z "$TMUX" ]; then
#
#    exec tmux # also see below.
#
#    # if terminal emulator is closed while tmux is running, session remains,
#    # and tmux will create a new session next start.
#    # this can cause conflicts with neovim, etc.
#    # to fix, when starting a new session, attempt to attach to default
#    # session name first, per this reply:
#    # https://unix.stackexchange.com/questions/103898/how-to-start-tmux-with-attach-if-a-session-exists
#    # update: command below causes problems if user needs multiple terminals.
#    # causes all terminals to mirror each other.
#    #exec tmux new -As0
#fi

#HISTSIZE=100000
#HISTFILESIZE=100000
#shopt -s histappend

set -o vi

function cl(){
    cd $1
    ls -a
}

function pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

# TODO: modify this to check the output of dry run and proceed if it succeeds.
function install_defaults() {
    apt install --dry-run htop
}

# cargo bin contains neovide, may contain other bins as well.
#PATH=$PATH:~/.cargo/bin


#alias nv='nvim'
#alias dt='nv ~/src/dotfiles'
#alias dt='cd ~/src/dotfiles && nvim .'

# reload .Xresources on terminal exit.
#xrdb ~/.Xresources
#trap "xrdb ~/src/dotfiles/.Xresources" EXIT


# the following assumes that fzf is installed.
# https://github.com/junegunn/fzf?tab=readme-ov-file#usage
# Set up fzf key bindings and fuzzy completion
#eval "$(fzf --bash)" # this is not working... update: found out old version of fzf

# set LESS to not issue bell sound
#export LESS="$LESS -Lqc --no-vbell"

#export XDG_CONFIG_HOME=/home/fj/src/dotfiles

#set enable-bracketed-paste off

# bash history is not shared between tmux windows.
# fix this. 
# https://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows/1292#1292

#HISTCONTROL=ignoredups:erasedups
#shopt -s histappend
#PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# define a function that copies current bash line to system clipboard.
# note, in vi enabled, this only works if you are in edit mode.
# https://askubuntu.com/questions/413436/copy-current-terminal-prompt-to-clipboard
# confirmed this does not interfere with vim ctrl-y when vim is open.
# appears that tmux does not use control y.
# may be able to get this functionality with tmux alone?
# update: can get almost same functionality with tmux copy mode ctrl-b, [.
#if [[ -n $DISPLAY ]]; then
#  copy_line_to_x_clipboard () {
#    printf %s "$READLINE_LINE" | xclip -selection CLIPBOARD
#  }
#  bind -x '"\C-y": copy_line_to_x_clipboard' # binded to ctrl-y
#fi

# if shell is non-login, then .profile will not be loaded.
# load it here.
# update: no, can't do this. ~/.profile loads .bashrc, creating loop.
#. ~/.profile

# if ~/.profile runs, it will attempt to load private ~/bin and ~/.local/bin.
# load those here in case we are in non-login shell.
# take care that the paths exist and also that they have not been added already.

if [[ -d ~/bin ]] ; then
    pathadd ~/bin
fi

if [[ -d ~/.local/bin ]] ; then
    pathadd ~/.local/bin
fi

#export PATH="$PATH:$HOME/bin/kitty/kitty-0.38.0-x86_64/bin"
#export PATH="$PATH:$HOME/bin/nvim/nvim-linux64_10_2/bin"
#export PATH="$PATH:$HOME/bin/zellij/0.41.2"

#export PATH="$PATH:$HOME/bin/cmake/cmake-3.31.6-linux-x86_64/bin"

# set default editor to nvim. this will allow copy paste in browse mode with Ctrl-s e
# https://www.reddit.com/r/zellij/comments/17s9hm7/is_there_any_way_to_copypaste_text_using_only_the/
export EDITOR="nvim"
export VISUAL="nvim"

# start zellij when bash starts.
# attach to an existing session if it exists.
# close bash if zellij closes.
# todo: stop zellij server if client shell closes. (possible with config)

#export ZELLIJ_AUTO_ATTACH="true"
#export ZELLIJ_AUTO_EXIT="true"
#export ZELLIJ_CONFIG_FILE="$HOME/src/dotfiles/zellij.kdl"
#if [[ -z "$ZELLIJ" ]]; then
#    if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
#        zellij attach -c
#    else
#        zellij
#    fi
#
#    if [[ "$ZELLIJ_AUTO_EXIT" == "true" ]]; then
#        exit
#    fi
#fi

# this is only for playing Beyond All Reason.
# maps side mouse button to middle.
# does not take effect system wide, but doesn't need to 
# because i launch BAR from shell.
#xinput set-button-map 7 1 2 3 4 5 6 7 2 9 10

echo 'END ~/src/dotfiles/.bashrc'
