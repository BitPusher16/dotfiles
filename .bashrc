# to activate on new system, append this to ~/.bashrc:
# . ~/src/dotfiles/.bashrc

echo 'in ~/src/dotfiles/.bashrc'

# start tmux immediately.
# NOTE: this may need modified if alacritty conf or tmux conf changes TERM.
if command -v tmux &> /dev/null && \
	[ -n "$PS1" ] && \
	[[ ! "$TERM" =~ screen ]] && \
	[[ ! "$TERM" =~ tmux ]] && \
	[[ ! "$TERM" =~ tmux-256color ]] && \
	[ -z "$TMUX" ]; then
  exec tmux
fi

HISTSIZE=10000

set -o vi

function cl(){
	cd $1
	ls -a
}

# $- outputs builtin set flags. see man bash -> set subsection.
[[ $- == *i* ]] && echo 'interactive shell' || echo 'non-interactive shell' 
shopt -q login_shell && echo 'login shell' || echo 'non-login shell'

# set LESS to not issue bell sound
#export LESS="$LESS -Lqc --no-vbell"

#export XDG_CONFIG_HOME=/home/fj/src/dotfiles

#set enable-bracketed-paste off
