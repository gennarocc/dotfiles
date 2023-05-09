local beautiful = require("beautiful")
local gears = require("gears")
local awful = require("awful")

local update_interval = 300
local update_script = [[
  sh -c "
    checkupdates | wc -l
  "]]

local update_widget = awful.widget.watch(update_script, update_interval, function(widget, stdout)
  local output = stdout:gsub("\n", "")
  widget.markup = "<span foreground='" .. beautiful.xcolor6 .. "'>[P " .. output .. "]</span>"
  widget.font = beautiful.font_name .. "10"
end)

update_widget:buttons(gears.table.join(
  awful.button({}, 1, function()
    awful.spawn("alacritty --title Terminal -e paru -Syu --sudoloop")
  end)
))

return update_widget
