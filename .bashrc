# to activate on new system, append the following to ~/.bashrc:
# . ~/src/dotfiles/.bashrc

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

function cl(){
    cd $1
    ls -a
}

# TODO: modify this to check the output of dry run and proceed if it succeeds.
# useful binaries: xclip, fuzzy finder, ripgrep.
function install_defaults() {
    apt install --dry-run htop git make unzip ripgrep fd-find build-essential
}

# if shell is non-login, then .profile will not be loaded.
# load it here.
# update: no, can't do this. ~/.profile loads .bashrc, creating loop.
#. ~/.profile

# if ~/.profile runs, it will attempt to load private ~/bin and ~/.local/bin.
# load those here in case we are in non-login shell.
# take care that the paths exist and also that they have not been added already.

function pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

if [[ -d ~/bin ]] ; then
    pathadd ~/bin
fi

if [[ -d ~/.local/bin ]] ; then
    pathadd ~/.local/bin
fi

set -o vi
bind 'set bell-style none' # normally this is done in .inputrc. possible to do in .bashrc with bind.

# set default editor to nvim. this will allow copy paste in browse mode with Ctrl-s e
# https://www.reddit.com/r/zellij/comments/17s9hm7/is_there_any_way_to_copypaste_text_using_only_the/
#export EDITOR="nvim"
#export VISUAL="nvim"
#export EDITOR="vi"
#export VISUAL="vi"

# cargo bin contains neovide, may contain other bins as well.
#PATH=$PATH:~/.cargo/bin


#alias nv='nvim'
#alias dt='nv ~/src/dotfiles'
#alias dt='cd ~/src/dotfiles && nvim .'

# reload .Xresources on terminal exit.
# update: this is for xterm?
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

#export PATH="$PATH:$HOME/bin/kitty/kitty-0.38.0-x86_64/bin"
#export PATH="$PATH:$HOME/bin/kitty/kitty-0.41.1-x86_64/bin"
#export PATH="$PATH:$HOME/bin/nvim/nvim-linux64_10_2/bin"
#export PATH="$PATH:$HOME/bin/zellij/0.41.2"
export PATH="/home/fj/bin/zig/zig-x86_64-linux-0.14.1:$PATH"
export PATH="/home/fj/bin/nvim/nvim-linux-x86_64/bin:$PATH"

#export PATH="$PATH:$HOME/bin/cmake/cmake-3.31.6-linux-x86_64/bin"

# it is convenient to store dotfiles in a single repository directory.
# however, depending on the program being configured, a dotfile may need to live
# at an arbitrary location in the file system.
# rather than relocate the file,
# we will append a "source" statement to a config stub file.
# further, we wish to manage the creation and deletion of this "source" statement
# from our .bashrc.
# otherwise, we would need to manually remember everywhere we had set up configs.
# TODO: it would be better if this function searched for a contiguous sequence of lines,
# rather than search for and delete each line individually.
# as written, this may break for config files that already have lots of content.
# NOTE: this requires restarting the terminal twice.
# once to run the function to append lines to stub files,
# and a second time to pick up the newly appended lines.

append_to_stub() {
    local stub_file="$1"
    local -n source_lines="$2"
    local enable="$3"

    if [[ "$enable" == "true" ]]; then
        echo "enabling $stub_file"
        if [[ ! -f "$stub_file" ]]; then
            exit 1
        fi
        for line in "${source_lines[@]}"; do
            if ! grep -F -q -x "$line" "$stub_file"; then
                echo "$line" >> "$stub_file"
            fi
        done
    elif [[ "$enable" == "false" ]]; then
        echo "disabling $stub_file"
        if [[ -f "$stub_file" ]]; then
            for line in "${source_lines[@]}"; do
                local temp_file
                temp_file=$(mktemp)
                grep -F -v -x "$line" "$stub_file" > "$temp_file"
                mv "$temp_file" "$stub_file"
            done
        fi
    fi
}

lines=("[general]" "import = [\"$HOME/src/dotfiles/alacritty.toml\"]")
append_to_stub "$HOME/.config/alacritty/alacritty.toml" lines "true"

lines=("dofile ('$HOME/src/dotfiles/kickstart.lua')")
append_to_stub "$HOME/.config/nvim/init.lua" lines "true"

echo 'END ~/src/dotfiles/.bashrc'
