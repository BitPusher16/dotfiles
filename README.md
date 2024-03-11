# dotfiles

mv <FILE/DIR> ./
ln -sr <FILE/DIR> <LINK> # s for symbolic, r for relative (to current dir)

2024-03-03
Today, attempted to use symlinks for some config files (e.g., ~/.Xresources).
However, this doesn't work well for ~/.bashrc, because that file has existing configs
which I don't want to tamper with.
Temporarily tried using symlinks for some files, and appending includes to .bashrc and similar.
This is messy and inconsistent.

Switched approaches. Keeping all config files in git repo, not using symlinks,
and just manually figuring out how to insert "include" statements in each system config.

2024-03-10
I am having trouble referring to dotfiles neovim config.
Neovim assumes an existing directory structure at ~/.config/neovim.
If I source from ~/.config/neovim/init.lua, further "require" statements break.
I also have the option to use $XDG_CONFIG_HOME,
but if I set this to my dotfiles dir, other programs may write there.
Update: Maybe I was just sourcing incorrectly.
I can now call vim-plug from ~/src/dotfiles/nvim/misc.lua.
