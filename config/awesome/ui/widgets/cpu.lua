local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local helpers = require("helpers")

local cpu_text = wibox.widget({
  font = beautiful.font_name .. "12",
  align = "center",
  widget = wibox.widget.textbox,
})

local temp_text = wibox.widget({
  font = beautiful.font_name .. "12",
  align = "center",
  widget = wibox.widget.textbox,
})

awesome.connect_signal("signal::cpu", function(value)
  local formatted_value = string.format("%02d", value)
  cpu_text.markup = "<span foreground='" .. beautiful.xcolor8 .. "'> " .. formatted_value .. "%</span>"
  cpu_text.color = beautiful.xcolor8
  if value > 80 then
    cpu_text.markup = "<span foreground='" .. beautiful.xcolor9 .. "'> " .. formatted_value .. "%  </span>"
  end
end)

awesome.connect_signal("signal::temp", function(value)
  temp_text.markup = "<span foreground='" .. beautiful.xcolor8 .. "'>  " .. value .. "C°</span>"
  if value > 60 then
    temp_text.markup = "<span foreground='" .. beautiful.xcolor11 .. "'>  " .. value .. "C°</span>"
  end
  if value > 80 then
    temp_text.markup = "<span foreground='" .. beautiful.xcolor9 .. "'>  " .. value .. "C°</span>"
  end
end)

return wibox.widget({
  {
    {
      text = "[",
      font = beautiful.font_name .. "12",
      align = "center",
      widget = wibox.widget.textbox,
    },
    cpu_text,
    temp_text,
    {
      text = "]",
      font = beautiful.font_name .. "12",
      align = "center",
      widget = wibox.widget.textbox,
    },
    layout = wibox.layout.fixed.horizontal,
  },
  right = dpi(5),
  left = dpi(15),
  top = dpi(5),
  bottom = dpi(5),
  widget = wibox.container.margin,
})
