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
  -- Create Button
  local function create_title_button(color_focus, img)
    local tb = wibox.widget({
      {
        {
          image = img,
          forced_width = dpi(30),
          forced_height = dpi(30),
          widget = wibox.widget.imagebox,
          shape = helpers.rrect(beautiful.border_radius),
        },
        margins = dpi(10),
        widget = wibox.container.margin,
      },
      forced_width = dpi(30),
      widget = wibox.container.background,
    })

    tb:connect_signal("mouse::enter", function()
      tb.bg = color_focus .. 55
    end)
    tb:connect_signal("mouse::leave", function()
      tb.bg = beautiful.xbackground .. "00"
    end)

    tb.visible = true
    return tb
  end

  -- Close Button
  local close_icon = beautiful.icon_path .. "close.png"
  local close_button = gears.color.recolor_image(close_icon, beautiful.xcolor9)
  local close = create_title_button(beautiful.xcolor8, close_button)
  close:connect_signal("button::press", function()
    c:kill()
  end)

  -- Minimize Button
  local min_icon = beautiful.icon_path .. "min.png"
  local min_button = gears.color.recolor_image(min_icon, beautiful.xcolor3)
  local min = create_title_button(beautiful.xcolor8, min_button)
  min:connect_signal("button::press", function()
    c:kill()
  end)

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

  awful.titlebar(c, {size = beautiful.titlebar_size}):setup({
    {
      helpers.horizontal_pad(4),
      {
        awful.titlebar.widget.iconwidget (c),
        top = dpi(6),
        bottom = dpi(6),
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
        awful.titlebar.widget.minimizebutton(c),
        margins = dpi(10),
        widget = wibox.container.margin,
      },
      close,
      layout = wibox.layout.fixed.horizontal,
    },

    layout = wibox.layout.align.horizontal,
  })
end)
