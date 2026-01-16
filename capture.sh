#!/bin/bash

#cp ~/.bashrc ~/.config/alacritty/alacritty.toml ~/.tmux.conf ~/.config/nvim/init.lua ~/src/dotfiles/old/2026-01-10-aa/

files=(
	~/.bashrc
	~/.config/alacritty/alacritty.toml
	~/.tmux.conf
	~/.config/nvim/init.lua
	~/.scripts/start_debugger.sh
	~/.scripts/generate_breakpoints.sh
	~/.scripts/generate_breakpoints.py
)

cp "${files[@]}" ~/src/dotfiles/old/2026-01-10-aa/
