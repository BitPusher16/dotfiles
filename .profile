# 2024-12-18 fj
# note that ~/.profile will not be loaded if the shell is non-login.
# best practice is to load it from .bashrc?
# but note! this means that starting a login shell may load .profile multiple times.
# update: no, it is not best practice to load this from .bashrc. creates a loop because ~/.profile loads .bashrc.
# update: i think these commands have to go in .bashrc. i can't call ~/.profile from ~/.bashrc.

# 2023-09-22 fj
# the following lines, which came with my system, contain bugs.
# these lines will reload paths repeatedly if ~/.profile is sourced repeatedly.
# edit: wait, i understand the intent.
# this means to make sure that the path exists.
# it makes no attempt to check whether the dir is already part of path.
# todo: move the dir-checking command into source control somehow.

# set PATH so it includes user's private bin if it exists
#if [ -d "$HOME/bin" ] ; then
#    PATH="$HOME/bin:$PATH"
#fi

# set PATH so it includes user's private bin if it exists
#if [ -d "$HOME/.local/bin" ] ; then
#    PATH="$HOME/.local/bin:$PATH"
#fi

# --------

# set PATH so it includes user's private bin if it exists
#if [ ! -d "$HOME/bin" ] ; then
#    PATH="$HOME/bin:$PATH"
#fi

# set PATH so it includes user's private bin if it exists
#if [ ! -d "$HOME/.local/bin" ] ; then
#    PATH="$HOME/.local/bin:$PATH"
#fi

# --------

# set PATH so it includes user's private bin if it exists
#if [ ! -d "$HOME/bin" ] && [ ! ":$PATH:" == *":$HOME/bin:"* ] ; then
#    PATH="$HOME/bin:$PATH"
#fi

# set PATH so it includes user's private bin if it exists
if [ ! -d "$HOME/.local/bin" ] && [ ! ":$PATH:" == *":$HOME/.local/bin:"* ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

