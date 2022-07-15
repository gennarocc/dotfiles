-- panel.lua
-- Panel Widget
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local cpu = require("ui.widgets.cpu")
local ram = require("ui.widgets.ram")
local root = require("ui.widgets.root")
local data = require("ui.widgets.data")
local share = require("ui.widgets.share")
local temp = require("ui.widgets.temp")
local kernal = require("ui.widgets.kernal")
local pkgs = require("ui.widgets.packages")
local pkg_updates = require("ui.widgets.updates")
local helpers = require("helpers")
local rubato = require("module.rubato")

local w = dpi(300)
local h = dpi(250)

local dashboard = wibox({
  visible = false,
  height = h,
  width = w,
  x = 10,
  y = -410,
  ontop = true,
  bg = beautiful.xbackground .. "FA",
  fg = beautiful.xforeground,
  border_width = dpi(1),
  border_color = beautiful.xcolor0,
  type = "normal",
  screen = screen.primary,
})

local header = function(text, bar_color, text_color)
  local header_bar = wibox.widget({
    max_value = 100,
    value = 100,
    forced_height = dpi(3),
    color = beautiful.xcolor8,
    background_color = beautiful.xcolor0,
    widget = wibox.widget.progressbar,
  })

  return wibox.widget({
    {
      header_bar,
      layout = wibox.layout.align.vertical,
    },
    bottom = dpi(10),
    widget = wibox.container.margin,
  })
end

local dash_timed = rubato.timed({
  intro = 0.1,
  duration = 0.2,
  easing = rubato.quadratic,
  rate = 144,
  subscribed = function(pos)
    if pos < (h * -1) then
      dashboard.visible = false
    end
    dashboard.y = pos
  end,
})

function dashboard:toggle(screen)
  -- self.screen = screen
  if dashboard.y < 0 then
    self.visible = true
    dash_timed.target = 400
  else
    dash_timed.target = (h * -1)
  end
end

dashboard:setup({
  {
    {
      nil,
      kernal,
      {
        pkgs,
        helpers.horizontal_pad(5),
        pkg_updates,
        layout = wibox.layout.align.horizontal,
      },
      layout = wibox.layout.align.horizontal,
    },
    header(""),
    {
      cpu,
      ram,
      temp,
      layout = wibox.layout.align.horizontal,
    },
    root,
    data,
    share,
    layout = wibox.layout.fixed.vertical,
  },
  top = dpi(40),
  left = dpi(30),
  right = dpi(30),
  bottom = dpi(40),
  widget = wibox.container.margin,
})

return dashboard

-- EOF -------------------------------------------------------------------------
