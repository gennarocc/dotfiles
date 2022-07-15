local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local cpu_bar = wibox.widget({
  max_value = 100,
  value = 0,
  margins = dpi(8),
  forced_height = dpi(3),
  color = beautiful.xcolor5,
  background_color = beautiful.xcolor0,
  widget = wibox.widget.progressbar,
})

local cpu_text = wibox.widget({
  text = "",
  font = beautiful.font_name .. "14",
  align = "center",
  widget = wibox.widget.textbox,
})

awesome.connect_signal("signal::cpu", function(value)
  cpu_bar.value = value
  cpu_text.markup = "<span foreground='" .. beautiful.xcolor14 .. "'> " .. value .. "%</span>"
  cpu_text.color = beautiful.xcolor5
  if value > 80 then
    cpu_text.markup = "<span foreground='" .. beautiful.xcolor9 .. "'> " .. value .. "%</span>"
  end
end)

return wibox.widget({
  {
    cpu_text,
    -- cpu_bar,
    layout = wibox.layout.align.vertical,
  },
  margins = dpi(10),
  widget = wibox.container.margin,
})
