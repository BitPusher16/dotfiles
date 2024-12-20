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
This seems suboptimal initially, because the ideal is to set up a new machine with one script.
However, realistically, no two systems will accept installation paths identically,
so arguably it is better to allow for gradually enabling configs when setting up new system.

2024-03-10
I am having trouble referring to dotfiles neovim config.
Neovim assumes an existing directory structure at ~/.config/neovim.
If I source from ~/.config/neovim/init.lua, further "require" statements break.
I also have the option to use $XDG_CONFIG_HOME,
but if I set this to my dotfiles dir, other programs may write there.
Update: Maybe I was just sourcing incorrectly.
I can now call vim-plug from ~/src/dotfiles/nvim/misc.lua.

2024-10-11
Have been trying AstroNvim for a while. I like it.
I haven't integrated the AstroNvim configs into my dotfiles repo.
For now, configs live in ~/.config/nvim.

NOTE: To get neovim to use terminal colors, set notermguicolors, and then set colorscheme default.
https://github.com/neovim/neovim/issues/11974
https://github.com/neovim/neovim/issues/26385


2024-10-12
May abandon AstroNvim for a bit.
Stack: Intel CPU -> Pop!_os -> uxterm -> bash -> tmux -> neovim -> astronvim.

- uxterm installed with apt.
- bash comes as preinstalled binary.
- nvim compiled from repo.
- astronvim (neovim settings) cloned from repo into ~/.config/nvim (and then .git dir was deleted).

2024-12-19
Trying kitty terminal. Seems good. Source is on github. x86_64 build is available in github releases.

Note about login vs non-login shells:
https://unix.stackexchange.com/questions/38175/difference-between-login-shell-and-non-login-shell
https://unix.stackexchange.com/questions/119627/why-are-interactive-shells-on-osx-login-shells-by-default
Logging in through SSH will give a login shell. Logging in with an X terminal application will give a non-login shell.
We would like ~/.bashrc and ~/.profile to be loaded in both cases.
Unfortunately, this may be difficult, because ~/.profile sources ~/.bashrc,
so if we call ~/.profile from ~/.bashrc, we get an infinite loop.

Note about ~/.bashrc, ~/.profile:
~/.profile loads ~/bin, ~/.local/bin, but it only runs if shell is login shell.
Need to have configs such that everything works same for login and non-login shell.
Tried sourcing ~/.profile from ~/.bashrc, but this creates an infinite loop.
So instead, just load ~/bin and ~/.local/bin from ~/.bashrc 
(if they've not been added to path already).
