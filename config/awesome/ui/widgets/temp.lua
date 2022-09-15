local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local temp_text = wibox.widget({
  font = beautiful.font_name .. "12",
  align = "center",
  widget = wibox.widget.textbox,
})

awesome.connect_signal("signal::temp", function(value)
  temp_text.markup = "<span foreground='" .. beautiful.xcolor8.. "'>" .. value .. "C°]</span>"
  if value > 60 then
    temp_text.markup = "<span foreground='" .. beautiful.xcolor11 .. "'>" .. value .. "C°]</span>"
  end
  if value > 80 then
    temp_text.markup = "<span foreground='" .. beautiful.xcolor9 .. "'>" .. value .. "C°</span>"
  end
end)

return wibox.widget({
  {
    temp_text,
    layout = wibox.layout.align.vertical,
  },
  top = dpi(12),
  left = dpi(5),

  widget = wibox.container.margin,
})
