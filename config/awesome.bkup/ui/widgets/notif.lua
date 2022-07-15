local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local gears = require("gears")
local gfs = require("gears.filesystem")
local naughty = require("naughty")

local M = {}
local notif_on_icon = gears.color.recolor_image(gears.surface.load_uncached(gfs.get_configuration_dir() .. "icons/notification.png"), beautiful.xcolor7)
local notif_off_icon = gears.color.recolor_image(gears.surface.load_uncached(gfs.get_configuration_dir() .. "icons/notification.png"), beautiful.xcolor9)

-- Create a button which can toggle the state of naughty
M.create = function(size, margin, bg, bg_hover)
    -- Create Icon
    local button_image = wibox.widget {
        -- image = notif_on_icon,
        forced_height = size,
        forced_width = size,
        widget = wibox.widget.imagebox
    }
    -- Initialize Icon to correct state 
    if (naughty.is_suspended() == true) then
      button_image.image = notif_off_icon
    else
      button_image.image = notif_on_icon
    end

    -- Create Button
    local button = wibox.widget {
        {
          button_image,
          margins = dpi(margin),
          widget = wibox.container.margin
        },
        bg = bg,
        widget = wibox.container.background
    }

    -- Hanlde button click. Note nuahgty is toggled after.
    button:connect_signal("button::press", function()
      if (naughty.is_suspended() == true) then
        button_image.image = notif_on_icon
      else
        naughty.notify({
          title = "Do Not Distrub Active",
          text = "Notifcations will be paused during this time."
        })
        button_image.image = notif_off_icon
      end
      naughty.toggle()
    end)

    -- Handle color changes
    button:connect_signal("button::leave", function() button.bg = bg end)
    button:connect_signal("mouse::enter", function() button.bg = bg_hover end)
    button:connect_signal("mouse::leave", function() button.bg = bg end)

  return button
end

return M
