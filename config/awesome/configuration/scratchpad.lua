local bling = require("module.bling")
local rubato = require("module.rubato")
local awful = require("awful")

-- Anitmations
local top_drawer = rubato.timed({
  pos = -400,
  rate = 144,
  intro = 0.1,
  easing = rubato.quadratic,
  duration = 0.2,
  awestore_compat = true,
})

local bottom_drawer = rubato.timed({
  pos = 2560,
  rate = 144,
  intro = 0.1,
  easing = rubato.quadratic,
  duration = 0.2,
  awestore_compat = true,
})

local music_control = bling.module.scratchpad({
  command = "alacritty --title music --class music,Scratchpad --command 'ncmpcpp'",
  rule = { instance = "music" },
  sticky = true,
  autoclose = false,
  floating = true,
  geometry = {
    x = 20,
    y = 400,
    height = 275,
    width = 800,
  },
  reapply = true,
  dont_focus_before_close = true,
  rubato = { y = top_drawer},
})

awesome.connect_signal("scratch::music", function()
  music_control:toggle()
end)

local drop_term = bling.module.scratchpad({
  command = "alacritty --title term --class drop_term,Scratchpad",
  rule = { instance = "drop_term" },
  sticky = true,
  autoclose = false,
  floating = true,
  geometry = { x = (awful.screen.focused().geometry.width / 3), y = 400, height = 275, width = (awful.screen.focused().geometry.width / 3) - 20 },
  reapply = true,
  dont_focus_before_close = true,
  rubato = { y = top_drawer },
})

awesome.connect_signal("scratch::term", function()
  drop_term:toggle()
end)

local launcher = bling.module.scratchpad({
  command = "alacritty --title launcher --class launcher -e /home/gcc/.config/awesome/scripts/launcher.sh",
  rule = { instance = "launcher" },
  sticky = true,
  autoclose = false,
  floating = true,
  geometry = {
    x = ((awful.screen.focused().geometry.width / 2) - (685 / 2)),
    y = ((awful.screen.focused().geometry.height / 2) - (300 / 2)),
    height = 300,
    width = 685,
  },
  reapply = true,
  dont_focus_before_close = false,
})

awesome.connect_signal("scratch::launcher", function()
  launcher:toggle()
end)

local games = bling.module.scratchpad({
  command = "alacritty --title games --class games,Scratchpad -e /home/gcc/.config/awesome/scripts/games-launcher.sh",
  rule = { instance = "games" },
  sticky = true,
  autoclose = false,
  floating = true,
  geometry = {
    x = ((awful.screen.focused().geometry.width / 2) - (685 / 2)),
    y = ((awful.screen.focused().geometry.height / 2) - (600 / 2)),
    height = 600,
    width = 685,
  },
  reapply = true,
  dont_focus_before_close = false,
})

awesome.connect_signal("scratch::games", function()
  games:toggle()
end)

local doomwad = bling.module.scratchpad({
  command = "alacritty --title doomwad --class doomwad,Scratchpad -e /home/gcc/.config/awesome/scripts/doomwad.sh",
  rule = { instance = "doomwad" },
  sticky = true,
  autoclose = true,
  floating = true,
  geometry = {
    x = ((awful.screen.focused().geometry.width / 2) - (685 / 2)),
    y = ((awful.screen.focused().geometry.height / 2) - (600 / 2)),
    height = 600,
    width = 685,
  },
  reapply = true,
  dont_focus_before_close = false,
})

awesome.connect_signal("scratch::doomwad", function()
  doomwad:toggle()
end)

-- music_control.connect_signal("toggle", function(c) c.screen = screen.primary end)
music_control:connect_signal("turn_on", function(c) c.screen = screen.primary end)
