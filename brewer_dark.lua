-- to enable this file, add the following line to
-- /home/<user>/.local/share/nvim/lazy/astrotheme/lua/astrotheme/palettes/astrodark.lua
-- and comment out the rest of the file.
-- (note: i'm not sure what happens if nvim updates its plugins. may overwrite this change.)
-- return dofile("/home/<user>/src/dotfiles/brewer_dark.lua")

local color = require("astrotheme.lib.color")

---@class AstroThemePalette
local c = {
	none = "NONE",
	syntax = {},
	ui = {},
	term = {},
	icon = {},
}

--------------------------------
--- Syntax
--------------------------------

local black = "#0c0d0e"
local white = "#b7b8b9"

--c.syntax.red = "#e31a1c" -- brewer_dark red is a little intense.
c.syntax.red = "#F8747E" -- this is the original from astronvim config.
c.syntax.orange = "#dca060"
c.syntax.yellow = "#dca060"
c.syntax.green = "#31a354"
c.syntax.cyan = "#80b1d3"
c.syntax.blue = "#3182bd"
c.syntax.purple = "#756bb1"
--c.syntax.text = "#ADB0BB"
--c.syntax.comment = "#696C76"
--c.syntax.mute = "#595C66"
c.syntax.text = white
c.syntax.comment = white
c.syntax.mute = white

--------------------------------
--- UI
--------------------------------
c.ui.red = "#f8747e"
c.ui.orange = "#dca060"
c.ui.yellow = "#dca060"
c.ui.green = "#31a354"
c.ui.cyan = "#80b1d3"
c.ui.blue = "#3182bd"
c.ui.purple = "#756bb1"

c.ui.accent = "#50A4E9"

c.ui.tabline = "#111317"
c.ui.winbar = "#797D87"
c.ui.tool = "#16181D"
c.ui.base = "#1A1D23"
c.ui.inactive_base = "#16181D"
c.ui.statusline = "#111317"
c.ui.split = "#111317"
c.ui.float = "#14161B"
c.ui.title = c.ui.accent
c.ui.border = "#3A3E47"
c.ui.current_line = "#1E222A"
c.ui.scrollbar = c.ui.accent
c.ui.selection = "#26343F"
-- TODO: combine menu_selection and selection
c.ui.menu_selection = c.ui.selection
c.ui.highlight = "#23272F"
c.ui.none_text = "#3A3E47"
c.ui.text = "#9B9FA9"
c.ui.text_active = "#ADB0BB"
c.ui.text_inactive = "#494D56"
c.ui.text_match = "#E0E0Ee"

c.ui.prompt = "#21242A"

--------------------------------
--- terminal
--------------------------------
c.term.black = c.ui.tabline
c.term.bright_black = color.new(c.ui.tabline):lighten(35):tohex()

c.term.red = c.syntax.red
c.term.bright_red = color.new(c.syntax.red):lighten(35):tohex()

c.term.green = c.syntax.green
c.term.bright_green = color.new(c.syntax.green):lighten(35):tohex()

c.term.yellow = c.syntax.yellow
c.term.bright_yellow = color.new(c.syntax.yellow):lighten(35):tohex()

c.term.blue = c.syntax.blue
c.term.bright_blue = color.new(c.syntax.blue):lighten(35):tohex()

c.term.purple = c.syntax.purple
c.term.bright_purple = color.new(c.syntax.purple):lighten(35):tohex()

c.term.cyan = c.syntax.cyan
c.term.bright_cyan = color.new(c.syntax.cyan):lighten(35):tohex()

c.term.white = c.ui.text
c.term.bright_white = color.new(c.syntax.text):lighten(35):tohex()

c.term.background = c.ui.base
c.term.foreground = c.ui.text

--------------------------------
--- Icons
--------------------------------
c.icon.c = "#519aba"
c.icon.css = "#61afef"
c.icon.deb = "#a1b7ee"
c.icon.docker = "#384d54"
c.icon.html = "#de8c92"
c.icon.jpeg = "#c882e7"
c.icon.jpg = "#c882e7"
c.icon.js = "#ebcb8b"
c.icon.jsx = "#519ab8"
c.icon.kt = "#7bc99c"
c.icon.lock = "#c4c720"
c.icon.lua = "#51a0cf"
c.icon.mp3 = "#d39ede"
c.icon.mp4 = "#9ea3de"
c.icon.out = "#abb2bf"
c.icon.png = "#c882e7"
c.icon.py = "#a3b8ef"
c.icon.rb = "#ff75a0"
c.icon.robots = "#abb2bf"
c.icon.rpm = "#fca2aa"
c.icon.rs = "#dea584"
c.icon.toml = "#39bf39"
c.icon.ts = "#519aba"
c.icon.ttf = "#abb2bf"
c.icon.vue = "#7bc99c"
c.icon.woff = "#abb2bf"
c.icon.woff2 = "#abb2bf"
c.icon.zip = "#f9d71c"
c.icon.md = "#519aba"
c.icon.pkg = "#d39ede"

return c
