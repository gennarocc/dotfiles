-- wibar.lua
-- Wibar (top bar)
local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")
local notif = require("ui.widgets.notif")
local ram = require("ui.widgets.ram")
local cpu = require("ui.widgets.cpu")
local updates = require("ui.widgets.updates")
local fs = require("ui.widgets.fs")

-- Awesome Panel -----------------------------------------------------------
local awesome_icon = wibox.widget({
  {
    {
      widget = wibox.widget.imagebox,
      image = beautiful.distro_logo,
      resize = true,
    },
    margins = dpi(4),
    widget = wibox.container.margin,
  },
  shape = helpers.rrect(beautiful.border_radius),
  bg = beautiful.wibar_bg,
  widget = wibox.container.background,
})

awesome_icon:connect_signal("mouse::enter", function()
  awesome_icon.bg = beautiful.lighter_bg
end)

awesome_icon:connect_signal("mouse::leave", function()
  awesome_icon.bg = beautiful.wibar_bg
end)

-- Time Widget ----------------------------------------------------------------

local time_text = wibox.widget({
  font = beautiful.font_name .. "12",
  format = "%b %d, %T",
  align = "center",
  valign = "center",
  refresh = 1,
  widget = wibox.widget.textclock,
})

time_text.markup = "<span foreground='" .. beautiful.xcolor8 .. "'>" .. time_text.text .. "</span>"

time_text:connect_signal("widget::redraw_needed", function()
  time_text.markup = "<span foreground='" .. beautiful.xcolor8 .. "'>" .. time_text.text .. "</span>"
end)

local time_widget = wibox.widget({
  {
    { time_text, widget = wibox.container.margin },
    layout = wibox.layout.fixed.horizontal,
  },
  left = dpi(10),
  right = dpi(10),
  bottom = dpi(1),
  widget = wibox.container.margin,
})

-- Systray Widget -------------------------------------------------------------

local mysystray = wibox.widget.systray()
mysystray:set_base_size(beautiful.systray_icon_size)

local mysystray_container = {
  mysystray,
  left = dpi(8),
  right = dpi(8),
  widget = wibox.container.margin,
}

local final_systray = wibox.widget({
  {
    mysystray_container,
    top = dpi(5),
    bottom = dpi(4),
    left = dpi(2),
    right = dpi(2),
    layout = wibox.container.margin,
  },
  bg = beautiful.bg_systray,
  -- shape = helpers.rrect(beautiful.border_radius),
  widget = wibox.container.background,
})

local wrap_widget = function(w)
  local wrapped = wibox.widget({
    w,
    top = dpi(4),
    left = dpi(3),
    bottom = dpi(4),
    right = dpi(3),
    widget = wibox.container.margin,
  })
  return wrapped
end

screen.connect_signal("request::desktop_decoration", function(s)
  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  -- Create layoutbox widget
  s.mylayoutbox = awful.widget.layoutbox(s)

  -- Create the wibox
  s.mywibox = awful.wibar({
    position = "top",
    screen = s,
    type = "dock",
    ontop = true,
  })

  -- Remove wibar on full screen
  local function remove_wibar(c)
    if c.fullscreen then
      c.screen.mywibox.visible = false
    else
      c.screen.mywibox.visible = true
    end
  end

  -- Remove wibar on full screen
  local function add_wibar(c)
    if c.fullscreen then
      c.screen.mywibox.visible = true
    end
  end

  -- Hide bar when a splash widget is visible
  awesome.connect_signal("widgets::splash::visibility", function(vis)
    screen.primary.mywibox.visible = not vis
  end)

  client.connect_signal("property::fullscreen", remove_wibar)

  client.connect_signal("request::unmanage", add_wibar)

  -- Create the taglist widget
  s.mytaglist = require("ui.widgets.taglist")(s)

  -- Create a tasklist widget

  local tasklist_buttons = gears.table.join(
    awful.button({}, 1, function(c)
      if c == client.focus then
        c.minimized = true
      else
        c:emit_signal("request::activate", "tasklist", { raise = true })
      end
    end),
    awful.button({}, 3, function()
      awful.menu.client_list({ theme = { width = 250 } })
    end),
    awful.button({}, 4, function()
      awful.client.focus.byidx(1)
    end),
    awful.button({}, 5, function()
      awful.client.focus.byidx(-1)
    end)
  )

  s.mytasklist = awful.widget.tasklist({
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    bg = beautiful.xbackground .. "00",
    buttons = tasklist_buttons,
    layout = { spacing = dpi(8), layout = wibox.layout.fixed.horizontal },
    widget_template = {
      {
        {
          {
            awful.widget.clienticon,
            left = dpi(5),
            widget = wibox.container.margin,
            layout = wibox.layout.fixed.vertical,
          },
          id = "icon",
          bg = beautiful.xcolor8 .. "00",
          forced_width = dpi(20),
          forced_height = dpi(20),
          shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, beautiful.border_radius)
          end,
          widget = wibox.container.background,
        },
        top = dpi(5),
        bottom = dpi(5),
        left = dpi(2),
        right = dpi(2),
        widget = wibox.container.margin,
      },
      id = "background_role",
      widget = wibox.container.background,
      create_callback = function(self, c, index, clients)
        c:connect_signal("focus", function()
          -- self:get_children_by_id("indicator")[1].visible = true
          -- self:get_children_by_id("icon")[1].bg = beautiful.xcolor8 .. "73"
        end)
        c:connect_signal("unfocus", function()
          -- self:get_children_by_id("indicator")[1].visible = false
          -- self:get_children_by_id("icon")[1].bg = beautiful.xcolor8 .. "00"
        end)
        self:connect_signal("mouse::enter", function()
          awesome.emit_signal("bling::task_preview::visibility", s, true, c)
        end)
        self:connect_signal("mouse::leave", function()
          awesome.emit_signal("bling::task_preview::visibility", s, false, c)
        end)
      end,
    },
  })
  -- Add widgets to the wibox

  s.mywibox:setup({
    layout = wibox.layout.align.vertical,
    nil,
    {
      layout = wibox.layout.align.horizontal,
      expand = "none",
      {
        layout = wibox.layout.fixed.horizontal,
        -- awesome_icon,
        helpers.horizontal_pad(20),
        s.mytaglist,
      },
      {
        s.mytasklist,
        widget = wibox.container.constraint,
      },
      {
        awful.widget.only_on_screen(fs.create("/", beautiful.xcolor9), screen[1]),
        helpers.horizontal_pad(20),
        awful.widget.only_on_screen(fs.create("/data", beautiful.xcolor9), screen[1]),
        helpers.horizontal_pad(20),
        awful.widget.only_on_screen(fs.create("~/Public", beautiful.xcolor9), screen[1]),
        helpers.horizontal_pad(20),
        updates,
        cpu,
        awful.widget.only_on_screen(notif.create(16, 8, beautiful.wibar_bg, beautiful.xcolor0), screen[1]),
        awful.widget.only_on_screen(final_systray, screen[0]),
        helpers.horizontal_pad(4),
        wrap_widget({
          s.mylayoutbox,
          top = dpi(3),
          bottom = dpi(3),
          right = dpi(3),
          left = dpi(6),
          widget = wibox.container.margin,
        }),
        wrap_widget(time_widget),
        helpers.horizontal_pad(4),
        layout = wibox.layout.fixed.horizontal,
      },
    },
  })
end)

-- EOF ------------------------------------------------------------------------
