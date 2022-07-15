local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local ram_bar = wibox.widget({
  max_value = 100,
  value = 0,
  forced_height = dpi(3),
  margins = dpi(8),
  color = beautiful.xcolor3,
  background_color = beautiful.xcolor0,
  widget = wibox.widget.progressbar,
})

local ram_text = wibox.widget({
  font = beautiful.font_name .. "14",
  align = "center",
  widget = wibox.widget.textbox,
})

awesome.connect_signal("signal::ram", function(used, total)
  local used_ram_percentage = (used / total) * 100
  ram_text.markup = "<span foreground='"
    .. beautiful.xcolor14
    .. "'>  "
    .. math.floor(used_ram_percentage)
    .. "%</span>"
  if used_ram_percentage > 80 then
    ram_text.markup = "<span foreground='"
      .. beautiful.xcolor9
      .. "'>  "
      .. math.floor(used_ram_percentage)
      .. "%</span>"
  end
end)

return wibox.widget({
  {
    ram_text,
    layout = wibox.layout.align.vertical,
  },
  margins = dpi(10),
  widget = wibox.container.margin,
})
