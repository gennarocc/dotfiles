local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local bling = require("module.bling")
local gears = require("gears")
local gfs = require("gears.filesystem")
local wibox = require("wibox")

-- Set Autostart Applications
require("configuration.autostart")

-- Default Applications
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " start " .. editor
browser = "firefox"
filemanager = terminal .. "-e ranger"
music = terminal .. " start --class music ncmpcpp"

-- Default modkey.
modkey = "Mod4"
altkey = "Mod1"
shift = "Shift"
ctrl = "Control"

screen.connect_signal("request::wallpaper", function(s)
  if s == screen[1] then
    awful.wallpaper({
      screen = s,
      widget = {
        horizontal_fit_policy = "fit",
        vertical_fit_policy = "fit",
        image = beautiful.wallpaper,
        widget = wibox.widget.imagebox,
      },
    })
  else
    awful.wallpaper({
      screen = s,
      widget = {
        horizontal_fit_policy = "fit",
        vertical_fit_policy = "fit",
        image = beautiful.wallpaper_vert,
        widget = wibox.widget.imagebox,
      },
    })
  end
end)

bling.widget.tag_preview.enable({
  show_client_content = true,
  x = dpi(10),
  y = dpi(10) + beautiful.wibar_height,
  scale = 0.25,
  honor_padding = true,
  honor_workarea = false,
})

bling.widget.window_switcher.enable({
  type = "none", -- set to anything other than "thumbnail" to disable client previews
  vim_previous_key = "j", -- Alternative key on which to select the previous client
  vim_next_key = "k", -- Alternative key on which to select the next client
})

screen.connect_signal("request::desktop_decoration", function(s)
  -- Screen padding
  screen[s].padding = { left = 0, right = 0, top = 0, bottom = 0 }

  -- Each screen has its own tag table.
  if s.index == 1 then
    awful.tag.add("i", {
      layout = awful.layout.suit.floating,
      layouts = { awful.layout.suit.tile, awful.layout.suit.floating },
      screen = s,
      selected = true,
    })
    awful.tag.add("ii", {
      layout = awful.layout.suit.floating,
      layouts = { awful.layout.suit.tile, awful.layout.suit.floating },
      screen = s,
    })
    awful.tag.add("iii", {
      layout = awful.layout.suit.floating,
      layouts = { awful.layout.suit.tile, awful.layout.suit.floating },
      screen = s,
    })
    awful.tag.add("iv", {
      layout = awful.layout.suit.floating,
      layouts = { awful.layout.suit.tile, awful.layout.suit.floating },
      screen = s,
    })
    awful.tag.add("v", {
      layout = awful.layout.suit.floating,
      layouts = { awful.layout.suit.tile, awful.layout.suit.floating },
      screen = s,
    })
  end
  if s.index == 2 then
    awful.tag.add("i", {
      layout = bling.layout.horizontal,
      layouts = { awful.layout.suit.floating, bling.layout.horizontal },
      screen = s,
      selected = true,
    })
    awful.tag.add("ii", {
      layout = bling.layout.horizontal,
      layouts = { awful.layout.suit.floating, bling.layout.horizontal },
      screen = s,
    })
    awful.tag.add("iii", {
      layout = bling.layout.horizontal,
      layouts = { awful.layout.suit.floating, bling.layout.horizontal },
      screen = s,
    })
    awful.tag.add("iv", {
      layout = bling.layout.horizontal,
      layouts = { awful.layout.suit.floating, bling.layout.horizontal },
      screen = s,
    })
    awful.tag.add("v", {
      layout = bling.layout.horizontal,
      layouts = { awful.layout.suit.floating, bling.layout.horizontal },
      screen = s,
    })
  end
end)

-- Get Keybinds
require("configuration.keys")

-- Get Rules
require("configuration.ruled")

-- Layouts, Titlebars, and other Window configs
require("configuration.window")
