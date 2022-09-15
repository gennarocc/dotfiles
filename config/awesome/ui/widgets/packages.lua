local beautiful = require("beautiful")
local wibox = require("wibox")
local awful = require("awful")
local dpi = beautiful.xresources.apply_dpi

local update_interval = 300
local package_script = [[
  sh -c "
    paru -Q | wc -l
  "]]

local pkgs = awful.widget.watch(package_script, update_interval, function(widget, stdout)
  widget.markup = "<span foreground='" .. beautiful.xcolor14 .. "'> " .. stdout .. "</span>"
  widget.font = beautiful.font_name .. "14"
end)

return wibox.widget({
  {
    pkgs,
    layout = wibox.layout.align.vertical,
  },
  right = dpi(15),
  left = dpi(15),
  top = dpi(10),
  bottom = dpi(10),
  widget = wibox.container.margin,
})
