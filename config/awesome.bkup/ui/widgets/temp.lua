local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local temp_text = wibox.widget({
  text = "TEMP",
  font = beautiful.font_name .. "14",
  color = beautiful.xforeground,
  align = "center",
  widget = wibox.widget.textbox,
})

awesome.connect_signal("signal::temp", function(value)
  temp_text.markup = "<span foreground='" .. beautiful.xcolor14 .. "'> " .. value .. "C°</span>"
  if value > 60 then
    temp_text.markup = "<span foreground='" .. beautiful.xcolor11 .. "'> " .. value .. "C°</span>"
  end
  if value > 80 then
    temp_text.markup = "<span foreground='" .. beautiful.xcolor9 .. "'> " .. value .. "C°</span>"
  end
end)

return wibox.widget({
  {
    temp_text,
    layout = wibox.layout.align.vertical,
  },
  margins = dpi(10),
  widget = wibox.container.margin,
})
