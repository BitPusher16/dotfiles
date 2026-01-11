


# bash script to generate a new dev environment.
# assumes x86_64 architecture, linux OS, bash available.
# (other assumptions?)
#
# should be idempotent. re-running script should overwrite dev env configs with dotfile configs.

sudo apt install git tmux nvim ripgrep
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

cargo install alacritty --locked --root $INSTALL_DIR

# clone alacritty themes.
# copy config files from dotfiles repo to dev env.
# configure alacritty to start with augmented PATH?
