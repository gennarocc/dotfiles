local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local fs_share = require("ui.widgets.fs_share")
local fs_root = require("ui.widgets.fs_root")
local fs_mount = require("ui.widgets.fs_mount")

local M = {}

M.create = function(size, margin, bg, bg_hover)
  local expanded = false

  local button = wibox.widget({
    text = "<",
    font = beautiful.font_name .. "12",
    align = "center",
    forced_height = dpi(size),
    forced_width = dpi(size),
    widget = wibox.widget.textbox,
  })

  local container = wibox.widget({
    {
      fs_root.create(),
      fs_mount.create(),
      fs_share.create(),
      layout = wibox.layout.align.horizontal
    },
    visible = false,
    widget = wibox.container.margin
  })

  button:connect_signal("button::press", function()
    if (expanded == false) then
      container.visible = true
      button.text = ">"
      expanded = true
    else
      container.visible = false
      button.text = "<"
      expanded = false
    end
  end)

  button:connect_signal("button::leave", function() button.bg = bg end)
  button:connect_signal("mouse::enter", function() button.bg = bg_hover end)
  button:connect_signal("mouse::leave", function() button.bg = bg end)

  return wibox.widget({
    {
      button,
      container,
      layout = wibox.layout.align.horizontal,
    },
    left = dpi(margin),
    right = dpi(margin),
    widget = wibox.container.margin,
  })
end

return M
