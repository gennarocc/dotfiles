local awful = require("awful")
local beautiful = require("beautiful")

local rules = {
  {
    id = "global",
    rule = {},
    properties = {
      focus = awful.client.focus.filter,
      size_hints_honor = false,
      screen = awful.screen.preferred,
      placement = awful.placement.centered + awful.placement.no_offscreen,
      maximized = false,
      above = false,
      below = false,
      ontop = false,
      sticky = false,
      maximized_horizontal = false,
      maximized_vertical = false,
    },
  },
  {
    id = "tasklist_order",
    rule = {},
    properties = {},
    callback = awful.client.setslave,
  },
  {
    rule = { name = "Launcher" },
    properties = {
      floating = true,
      width = 685,
      height = 300,
      above = true,
      x = 937,
      y = 934,
      ontop = true,
      screen = screen.primary,
    },
  },
  {
    rule_any = { type = { "normal", "dialog" } },
    except_any = {
      class = {
        "Steam",
        "Scratchpad",
        "com.bitwig.BitwigStudio",
        "battle.net.exe"
      },
      name = { "Launcher" }
    },
    properties = { titlebars_enabled = true },
  },
}

awful.rules.rules = rules
