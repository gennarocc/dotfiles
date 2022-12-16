local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local animation = require("module.animation")
local dpi = xresources.apply_dpi

local get_taglist = function(s)
  -- Taglist buttons
  local taglist_buttons = gears.table.join(
    awful.button({}, 1, function(t)
      t:view_only()
    end),
    awful.button({ modkey }, 1, function(t)
      if client.focus then
        client.focus:move_to_tag(t)
      end
    end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
      if client.focus then
        client.focus:toggle_tag(t)
      end
    end),
    awful.button({}, 4, function(t)
      awful.tag.viewnext(t.screen)
    end),
    awful.button({}, 5, function(t)
      awful.tag.viewprev(t.screen)
    end)
  )

  local taglist = awful.widget.taglist({
    screen = s,
    filter = awful.widget.taglist.filter.all,
    style = { shape = gears.shape.rectangle },
    layout = { spacing = 20, layout = wibox.layout.fixed.horizontal },
    widget_template = {
      id = "background_role",
      widget = wibox.container.background,
      create_callback = function(self, c3, _)
        local indicator = wibox.widget({
          widget = wibox.container.place,
          valign = "center",
          {
            widget = wibox.container.background,
            forced_height = dpi(4),
            shape = gears.shape.rounded_bar,
          },
        })

        self.indicator_animation = animation:new({
          duration = 0.125,
          easing = animation.easing.linear,
          update = function(self, pos)
            indicator.children[1].forced_width = pos
          end,
        })

        self:set_widget(indicator)

        if c3.selected then
          self.widget.children[1].bg = beautiful.accent
          self.indicator_animation:set(dpi(64))
        elseif #c3:clients() == 0 then
          self.widget.children[1].bg = beautiful.xcolor8
          self.indicator_animation:set(dpi(16))
        elseif c3.urgent then
          self.widget.children[1].bg = beautiful.xcolor8
          self.indicator_animation:set(dpi(32))
        else
          self.widget.children[1].bg = beautiful.xcolor11
          self.indicator_animation:set(dpi(32))
        end

        --- Tag preview
        self:connect_signal("mouse::enter", function()
          if #c3:clients() > 0 then
            awesome.emit_signal("bling::tag_preview::update", c3)
            awesome.emit_signal("bling::tag_preview::visibility", s, true)
          end
        end)

        self:connect_signal("mouse::leave", function()
          awesome.emit_signal("bling::tag_preview::visibility", s, false)
        end)
      end,
      update_callback = function(self, c3, _)
        if c3.selected then
          self.widget.children[1].bg = beautiful.accent
          self.indicator_animation:set(dpi(64))
        elseif #c3:clients() == 0 then
          self.widget.children[1].bg = beautiful.xcolor8
          self.indicator_animation:set(dpi(16))
        else
          self.widget.children[1].bg = beautiful.xcolor11
          self.indicator_animation:set(dpi(32))
        end
      end,
    },
    buttons = taglist_buttons,
  })

  return taglist
end

return get_taglist
