# dotfiles

## setup

```
  299  man ssh-keygen
  300  ssh-keygen -t ed25519 -C "fj@somedomain.com"
  301  man ssh-add
  302  ssh-add ~/.ssh/id_ed25519
  303  cat ~/.ssh/id_ed25519.pub 
  305  echo https://github.com/settings/ssh/new
  306  git clone git@github.com:BitPusher16/dotfiles.git
  307  ls
  308  cd dotfiles/
  309  ls
  310  vi README.md 
  311  man history 
  312  history | tail -n 20

  317  git config --global user.name fj
  318  git config --global user.email fj@somedomain.com
  319  git add -A && git commit -m 'foo' && git push
```



## notes

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
If I source from `~/.config/neovim/init.lua`, further "require" statements break.
I also have the option to use $XDG_CONFIG_HOME,
but if I set this to my dotfiles dir, other programs may write there.
Update: Maybe I was just sourcing incorrectly.
I can now call vim-plug from `~/src/dotfiles/nvim/misc.lua`.

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
We would like `~/.bashrc` and `~/.profile` to be loaded in both cases.
Unfortunately, this may be difficult, because `~/.profile sources` `~/.bashrc`,
so if we call `~/.profile` from `~/.bashrc`, we get an infinite loop.

Note about `~/.bashrc`, `~/.profile`:
`~/.profile` loads `~/bin`, `~/.local/bin`, but it only runs if shell is login shell.
Need to have configs such that everything works same for login and non-login shell.
Tried sourcing `~/.profile` from `~/.bashrc`, but this creates an infinite loop.
So instead, just load `~/bin` and `~/.local/bin` from `~/.bashrc` 
(if they've not been added to path already).

2025-01-12
Very close to a clean setup.
Kitty, Zellij, and Neovim all have downloadable binaries that can be versioned by adding to PATH.
(Note: Kitty is better with Nerd fonts. Need some notes on how to do this on Pop OS. Involves copying .ttf files to ~/.fonts)
Neovim can be "upgraded" to AstroNvim by cloning the AstroNvim template to ~/.config/nvim.
So far, seems likely that all configs can be kept in source control and "installed" by adding a src or equivalent to a home dir dotfile.
Need to make sure copy-paste works with Kitty, Zellij, and Neovim.
Todo: Find out how to make all tools use the 16 ANSI terminal colors?

2025-01-14
It's going to be very difficult to avoid apt installs.
Just tried to get a copy-paste tool for neovim. 
Without apt, would need to build something from source. (And build tools will again likely need apt.)
Installed wl-clipboard, and astronvim copy paste started working immediately.
So which tools do I install by downloading bin and adding to path, and which do I install with apt?

Also, the convenience of using Astronvim means that it becomes harder to do any customization.

Maybe found a workaround.
https://github.com/neovim/neovim/discussions/28010
(copy paste using osc52 in neovim >v10)

Also found a way to run non-plugin code in Astronvim: polish.lua.
The polish.lua file can also source something from my dotfiles.

Kitty author's recommendation for Kitty select-copy-paste:
https://github.com/kovidgoyal/kitty/issues/1698

2025-04-25
Problem I am working on today is trying to make system setup a bit cleaner.
Different programs look for configs in different places.
For example, bash looks for confic in ~/.bashrc, but Kitty looks for config in ~/.config/kitty/kitty.conf.
Would be nice if a bash script could control which configs are turned on and off.
Tried looking for a way to do per-session symbolic links, but didn't find anything.
Another option would be if each binary looked for an environment variable that defined config location.
Kitty does support this apparently. KITTY_CONFIG_DIRECTORY.
Neovim also supports? https://docs.astronvim.com/reference/alt_install/
Ah wait, the NVIM_APPNAME variable only controls where nvim looks inside the $XDG_CONFIG_HOME directory.
I do have the option to set $XDG_CONFIG_HOME, but this may cause other programs to write in my config repo.

2025-04-26
Upgraded Kitty to 0.41.1. Hoping that the newer version has better handling of paste warning messages.
Completely forgot how to add Kitty to Pop OS applications list.
Put the follwing lines in ~/.local/share/applications/kitty.desktop:

[Desktop Entry]
Version=1.0
Name=kitty
Comment=kitty
Exec=/home/fj/bin/kitty/kitty-0.41.1-x86_64/bin/kitty
Icon=/home/fj/bin/kitty/kitty-0.41.1-x86_64/share/icons/hicolor/256x256/apps/kitty.png
Type=Application
Terminal=false
Categories=System;TerminalEmulator;

Note: For some reason, the .desktop file provided with the Kitty binary download doesn't work.

https://rrethy.github.io/book/colorscheme.html
Keeping Neovim and Kitty Terminal Colorschemes Consistent

2026-01-10

nice trick to make btop use terminal colors:
#color_theme = "Default"
color_theme = "TTY"

2026-01-10-b

persisted a copy of configs for alacritty, tmux, nvim that give nice copy paste behavior and unified colors.
