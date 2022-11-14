-- autostart.lua
-- Autostart Stuff Here
local awful = require("awful")

local function run_once(cmd)
  local findme = cmd
  local firstspace = cmd:find(" ")
  if firstspace then
    findme = cmd:sub(0, firstspace - 1)
  end
  awful.spawn.easy_async_with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, cmd))
end

-- Add apps to autostart here
autostart_apps = {

  -- Set Resolution
  "xrandr --output DisplayPort-0 --mode 2560x1440 --rate 143.86 --primary --pos 0x0 --output DisplayPort-1 --mode 2560x1440 --rate 143.86 --pos 2560x-350 --rotate right",
  -- Redshift
  "redshift",
  -- Bluetooth Tray Icon
  "blueman-applet",
  -- Compositor
  "picom -b --experimental-backends --config ~/.config/picom/picom.conf",
  -- MPD
  "[ ! -s ~/.config/mpd/pid ] && mpd ~/.config/mpd/mpd.conf",
  "[[ -z $(pgrep -xU $UID mpdas) ]] && mpdas",
  "mpd-mpdas",
  "[[ -z $(pgrep -xu $UID mpdscribble) ]] && mpdscribble",
}

for app = 1, #autostart_apps do
  run_once(autostart_apps[app])
end
