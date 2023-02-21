local awful = require("awful")
local gears = require("gears")
local gfs = gears.filesystem
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")

-- Add a `titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
  local last_left_click
  local buttons = gears.table.join(
    awful.button({}, 1, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      if os.time() - (last_left_click or 0) < 1 then
        -- Assume to be double click
        c.maximized = not c.maximized
      else
        awful.mouse.client.move(c)
      end
      last_left_click = os.time()
    end),
    awful.button({}, 3, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.resize(c)
    end)
  )

  awful.titlebar(c, { size = beautiful.titlebar_size }):setup({
    {
      helpers.horizontal_pad(4),
      {
        awful.titlebar.widget.iconwidget(c),
        margins = dpi(10),
        widget = wibox.container.margin,
      },
      {
        awful.titlebar.widget.titlewidget(c),
        bottom = dpi(2),
        widget = wibox.container.margin,
      },
      buttons = buttons,
      layout = wibox.layout.fixed.horizontal,
    },
    {
      buttons = buttons,
      layout = wibox.layout.flex.horizontal,
    },
    {
      {
        awful.titlebar.widget.closebutton(c),
        margins = dpi(14),
        widget = wibox.container.margin,
      },
      layout = wibox.layout.fixed.horizontal,
    },

    layout = wibox.layout.align.horizontal,
  })
end)
