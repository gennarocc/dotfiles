local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local cpu_text = wibox.widget({
  text = "",
  font = beautiful.font_name .. "12",
  align = "center",
  widget = wibox.widget.textbox,
})

awesome.connect_signal("signal::cpu", function(value)
  local formatted_value = string.format("%02d", value)
  cpu_text.markup = "<span foreground='" .. beautiful.xcolor8 .. "'>[ " .. formatted_value .. "%</span>"
  cpu_text.color = beautiful.xcolor8
  if value > 80 then
    cpu_text.markup = "<span foreground='" .. beautiful.xcolor9 .. "'>[ " .. formatted_value .. "%</span>"
  end
end)

return wibox.widget({
  {
    cpu_text,
    -- cpu_bar,
    layout = wibox.layout.align.vertical,
  },
  right = dpi(10),
  left = dpi(15),
  top = dpi(10),
  bottom = dpi(10),
  widget = wibox.container.margin,
})
