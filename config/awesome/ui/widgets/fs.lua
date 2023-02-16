local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local awful = require("awful")
local dpi = beautiful.xresources.apply_dpi

local M = {}
local update_interval = 60

M.create = function(path, fg)

  local disk_script = [[
    sh -c "
    df -kh -B 1MB ]] .. path .. [[ | tail -1 | awk '{printf \"%d@%d\", $4, $3}'
    "
]]

  -- Widget Template
  local progress_bar = wibox.widget({
    max_value = 100,
    forced_height = dpi(4),
    forced_width = dpi(64),
    color = fg,
    shape = gears.shape.rounded_bar,
    background_color = beautiful.xcolor8,
    widget = wibox.widget.progressbar,
  })

  local tooltip = awful.tooltip({})
  tooltip:add_to_object(progress_bar)

  local fs_widget = awful.widget.watch(disk_script, update_interval, function(widget, stdout)
    -- Update Values
    local available = tonumber(stdout:match("^(.*)@")) / 1000
    local used = tonumber(stdout:match("@(.*)$")) / 1000
    local total = available + used
    widget.value = tonumber(100 * used / total)

    -- Tootlip
    local space_available = string.format("%.1f", tonumber(available))
    widget:connect_signal("mouse::enter", function()
      tooltip.text = path .. " " .. space_available .. " GiG"
    end)

  end, progress_bar)

  return wibox.widget({
    widget = wibox.container.place,
    valign = "center",
    {
      fs_widget,
      layout = wibox.layout.align.vertical,
    },
  })
end

return M
