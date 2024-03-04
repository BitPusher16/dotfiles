# to activate on new system, append this to ~/.bashrc:
# . ~/src/dotfiles/.bashrc

echo 'in ~/src/dotfiles/.bashrc'

# 2023-09-22 fj
HISTSIZE=10000


# 2023-12-07 fj
set -o vi

function cl(){
	cd $1
	ls -a
}

# 2024-03-03 fj
# $- outputs builtin set flags. see man bash -> set subsection.
[[ $- == *i* ]] && echo 'interactive shell' || echo 'non-interactive shell' 
shopt -q login_shell && echo 'login shell' || echo 'non-login shell'

# set LESS to not issue bell sound
#export LESS="$LESS -Lqc --no-vbell"
