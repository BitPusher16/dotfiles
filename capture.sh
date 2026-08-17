#!/bin/bash

#cp ~/.bashrc ~/.config/alacritty/alacritty.toml ~/.tmux.conf ~/.config/nvim/init.lua ~/src/dotfiles/old/2026-01-10-aa/

# some complications when setting up a new system...
# copy paste will not be configured. so using neovim and tmux to migrate will be troublesome.
# possible to do neovim only?

# to set up new system, recommend install neovim and use that to incrementally migrate.
# ctrl-w v (new pane split right)
# :lcd ~/ (sets new pane directory to home)
# ctrl-w w (switch to other pane)
# ctrl-w c (close pane) (or just :q ?)

files=(
	~/.bashrc
	~/.config/alacritty/alacritty.toml
	~/.tmux.conf
	~/.config/btop/btop.conf
	~/.config/nvim/init.lua
	~/.config/nvim/lua
	~/.scripts
        ~/".local/state/Beyond All Reason/uikeys.txt"
)

#cp -r "${files[@]}" ~/src/dotfiles/conf_captured

host="$(hostname -s | tr '-' '_')"
dest="$HOME/src/dotfiles/conf_captured/$host"
mkdir -p "$dest"
cp -r "${files[@]}" "$dest"
