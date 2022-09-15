-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- Theme library
local beautiful = require("beautiful")

-- Ruled
local ruled = require("ruled")

-- Widget library
local wibox = require("wibox")

-- Helpers
local helpers = require("helpers")

--
-- Decorations
----------------

local music_art = wibox.widget({
  image = gears.filesystem.get_configuration_dir() .. "icons/no-music.png",
  resize = true,
  widget = wibox.widget.imagebox,
})

local music_art_container = wibox.widget({
  music_art,
  shape = helpers.rrect(dpi(5)),
  widget = wibox.container.background,
})

-- Playerctl
---------------

local playerctl = require("module.bling").signal.playerctl.lib()

playerctl:connect_signal("metadata", function(_, title, artist, album_path, album, ___, player_name)
  if player_name == "mpd" then
    music_art:set_image(gears.surface.load_uncached(album_path))
  end
end)

playerctl:connect_signal("position", function(_, interval_sec, length_sec, player_name)
  if player_name == "mpd" then
    music_art:set_image(gears.surface.load_uncached(album_path))
  end
end)

local music_create_decoration = function(c)
  -- Sidebar
  awful.titlebar(c, { position = "left", size = dpi(250), bg = beautiful.xbackground }):setup({
    {
      nil,
      {
        music_art_container,
        bottom = dpi(20),
        left = dpi(25),
        right = dpi(15),
        widget = wibox.container.margin,
      },
      nil,
      expand = "none",
      layout = wibox.layout.align.vertical,
    },
    bg = beautiful.bg_accent,
    shape = helpers.prrect(dpi(10), false, true, false, false),
    widget = wibox.container.background,
  })

  -- Set custom decoration flags
  c.custom_decoration = { left = true }
end

-- Add the titlebar whenever a new music client is spawned
ruled.client.connect_signal("request::rules", function()
  ruled.client.append_rule({
    id = "music",
    rule = { instance = "music" },
    callback = music_create_decoration,
  })
end)
