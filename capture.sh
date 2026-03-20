#!/bin/bash

#cp ~/.bashrc ~/.config/alacritty/alacritty.toml ~/.tmux.conf ~/.config/nvim/init.lua ~/src/dotfiles/old/2026-01-10-aa/

files=(
	~/.bashrc
	~/.config/alacritty/alacritty.toml
	~/.tmux.conf
	~/.config/btop/btop.conf
	~/.config/nvim/init.lua
	~/.config/nvim/lua
	~/.scripts
)

cp -r "${files[@]}" ~/src/dotfiles/conf_captured
