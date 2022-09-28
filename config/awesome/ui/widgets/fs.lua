local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local M = {}

local dashboard = wibox({
  visible = false,
  height = 200,
  width = 200,
  x = 10,
  y = 410,
  ontop = true,
  bg = beautiful.xbackground .. "FA",
  fg = beautiful.xforeground,
  border_width = dpi(1),
  border_color = beautiful.xcolor0,
  type = "normal",
  screen = screen.primary,
})

M.create = function()
  local button = wibox.widget({
    text = "",
    font = beautiful.font_name .. "12",
    align = "center",
    widget = wibox.widget.textbox,
  })

  awesome.connect_signal("signal::fs_network", function(used, total)
    local space_available = string.format("%.1f", tonumber(total - used))
    button.markup = "<span foreground='"
      .. beautiful.xcolor8
      .. "'>[</span><span foreground='"
      .. beautiful.xcolor9
      .. "'> </span><span foreground='"
      .. beautiful.xcolor8
      .. "'>"
      .. space_available
      .. "GiG]</span>"
  end)

  -- Hanlde button click. Note nuahgty is toggled after.
  button:connect_signal("button::press", function()
    dashboard.toggle()
  end)

  return wibox.widget({
    {
      button,
      layout = wibox.layout.align.vertical,
    },
    right = dpi(15),
    left = dpi(15),
    top = dpi(7),
    bottom = dpi(5),
    widget = wibox.container.margin,
  })
end

return M
