local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi  

local ram_text = wibox.widget({
  font = beautiful.font_name .. "12",
  align = "center",
  widget = wibox.widget.textbox,
})

awesome.connect_signal("signal::ram", function(used, total)
  local used_ram_percentage = (used / total) * 100
  ram_text.markup = "<span foreground='"
    .. beautiful.xcolor8
    .. "'>[  "
    .. math.floor(used_ram_percentage)
    .. "%]</span>"
  if used_ram_percentage > 80 then
    ram_text.markup = "<span foreground='"
      .. beautiful.xcolor9
      .. "'>[  "
      .. math.floor(used_ram_percentage)
      .. "%]</span>"
  end
end)

return wibox.widget({
  {
    ram_text,
    layout = wibox.layout.align.vertical,
  },
  right = dpi(10),
  left = dpi (10),
  top = dpi(7),
  bottom = dpi(5),
  widget = wibox.container.margin,
})
