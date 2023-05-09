local awful = require("awful")
local gears = require("gears")
local gfs = gears.filesystem
local beautiful = require("beautiful")
local ruled = require("ruled")
require("awful.autofocus")

-- Bling Module
local bling = require("module.bling")

-- This is to slave windows' positions in floating layout
-- Not Mine
-- https://github.com/larkery/awesome/blob/master/savefloats.lua
require("module.savefloats")

-- Better mouse resizing on tiled
-- Not mine
-- https://github.com/larkery/awesome/blob/master/better-resize.lua
require("module.better-resize")

client.connect_signal("request::manage", function(c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  -- if not awesome.startup then awful.client.setslave(c) end
  if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end

  c.shape = function(cr, w, h)
    gears.shape.rounded_rect(cr, w, h, beautiful.border_radius)
  end

  -- Custom icons --------------------------------------------------------------
  if c.class == "Alacritty" then
     local new_icon = gears.surface(gfs.get_configuration_dir() .. "icons/utilities-terminal.png")
     c.icon = new_icon._native
  elseif c.class == "Scratchpad" then
    -- local new_icon = gears.surface(gfs.get_configuration_dir() .. "icons/term.png")
    -- c.icon = new_icon._native
  elseif c.class == "slack" or c.instance == "slack" then
    local new_icon = gears.surface(gfs.get_configuration_dir() .. "icons/xchat-gnome.png")
    c.icon = new_icon._native
  elseif c.class == "mumble" or c.instance == "mumble" then
    local new_icon = gears.surface(gfs.get_configuration_dir() .. "icons/mumble.png")
    c.icon = new_icon._native
  elseif c.class == "dota2" then
    local new_icon = gears.surface(gfs.get_configuration_dir() .. "icons/dota2.png")
    c.icon = new_icon._native
  elseif c.class == "Zathura" then
    local new_icon = gears.surface(gfs.get_configuration_dir() .. "icons/pdf.png")
    c.icon = new_icon._native
  elseif c.class == "Steam" or c.instance == "steam" then
    local new_icon = gears.surface(gfs.get_configuration_dir() .. "icons/steam.png")
    c.icon = new_icon._native
  elseif c.class == "Plex" or c.instance == "Plex" then
    local new_icon = gears.surface(gfs.get_configuration_dir() .. "icons/plex.png")
    c.icon = new_icon._native
  elseif c.class == "unityhub" or c.instance == "unityhub" then
    local new_icon = gears.surface(gfs.get_configuration_dir() .. "icons/unity.png")
    c.icon = new_icon._native
  end
end)

-- Enable sloppy focus ------------------------------------------------------
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c)
  c.border_color = beautiful.border_focus
end)

client.connect_signal("unfocus", function(c)
  c.border_color = beautiful.border_normal
end)

-- EOF ------------------------------------------------------------------------
