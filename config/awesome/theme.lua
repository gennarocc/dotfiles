--  _   _
-- | |_| |__   ___ _ __ ___   ___
-- | __| '_ \ / _ \ '_ ` _ \ / _ \
-- | |_| | | |  __/ | | | | |  __/
--  \__|_| |_|\___|_| |_| |_|\___|
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()
local gears = require("gears")
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local helpers = require("helpers")

-- Inherit default theme
--
local theme = dofile(themes_path .. "default/theme.lua")

theme.wallpaper = gfs.get_configuration_dir() .. "images/landscape.jpg"
theme.wallpaper_vert = gfs.get_configuration_dir() .. "images/landscape-vert.png"

-- Icon Path
theme.icon_theme = "Numix"
theme.icon_path = gfs.get_configuration_dir() .. "icons/"
theme.notification_icon = gears.color.recolor_image(theme.icon_path .. "notification.png", theme.xcolor8)

-- Load ~/.Xresources colors and set fallback colors
--
theme.xbackground = xrdb.background or "#1d2021"
theme.xforeground = xrdb.foreground or "#ebdbb2"
theme.xcolor0 = xrdb.color0 or "#282828"
theme.xcolor1 = xrdb.color1 or "#cc241d"
theme.xcolor2 = xrdb.color2 or "#98971a"
theme.xcolor3 = xrdb.color3 or "#d79921"
theme.xcolor4 = xrdb.color4 or "#458588"
theme.xcolor5 = xrdb.color5 or "#b16286"
theme.xcolor6 = xrdb.color6 or "#689d6a"
theme.xcolor7 = xrdb.color7 or "#a89984"
theme.xcolor8 = xrdb.color8 or "#928374"
theme.xcolor9 = xrdb.color9 or "#ec6b64"
theme.xcolor10 = xrdb.color10 or "#b8bb26"
theme.xcolor11 = xrdb.color11 or "#fabd2f"
theme.xcolor12 = xrdb.color12 or "#83a598"
theme.xcolor13 = xrdb.color13 or "#d3869b"
theme.xcolor14 = xrdb.color14 or "#83c07c"
theme.xcolor15 = xrdb.color15 or "#ebdbb2"
theme.accent = theme.xcolor14

-- Fonts
--
theme.font_name = "TerminessTTF Nerd Font Bold "
theme.font = theme.font_name .. "12"
theme.icon_font_name = theme.font_name
theme.icon_font = theme.icon_font_name .. "16"
theme.font_taglist = "Terminus 8"

-- Background Colors
--
theme.bg_dark = theme.xcolor0
theme.bg_normal = theme.xbackground
theme.bg_focus = theme.xcolor0
theme.bg_urgent = theme.xcolor9
theme.bg_minimize = theme.xcolor8

-- Foreground Colors
--
theme.fg_normal = theme.xcolor7
theme.fg_focus = theme.xcolor4
theme.fg_urgent = theme.xcolor3
theme.fg_minimize = theme.xcolor8
theme.button_close = theme.xcolor1

-- Borders
--
theme.border_width = dpi(1)
theme.oof_border_width = dpi(2)
theme.border_normal = theme.xcolor0
theme.border_focus = theme.xcolor0
theme.border_radius = dpi(4)
theme.client_radius = dpi(0)
theme.widget_border_width = dpi(0)
theme.widget_border_color = theme.xcolor0
theme.notif_border_color = theme.xbackground

-- Taglist
--
-- Generate taglist squares:
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)
theme.taglist_font = theme.font_taglist
theme.taglist_bg = theme.xbackground
theme.taglist_bg_focus = theme.xbackground
theme.taglist_fg_focus = theme.xcolor14
theme.taglist_bg_urgent = theme.xbackground
theme.taglist_fg_urgent = theme.xcolor9
theme.taglist_bg_occupied = theme.wibar_bg
theme.taglist_fg_occupied = theme.xcolor11
theme.taglist_bg_empty = theme.wibar_bg
theme.taglist_fg_empty = theme.xcolor8 .. "CC"
theme.taglist_bg_volatile = theme.wibar_bg
theme.taglist_fg_volatile = theme.xcolor11
theme.taglist_disable_icon = true
theme.taglist_shape_focus = helpers.rrect(theme.border_radius)

-- Tasklist
--
theme.tasklist_font = theme.font
theme.tasklist_plain_task_name = true
theme.tasklist_bg_focus = theme.xbackground .. "00"
theme.tasklist_bg_minimize = theme.xbackground .. "00"
theme.tasklist_bg_normal = theme.xbackground .. "00"
theme.tasklist_bg_urgent = theme.xcolor9
theme.tasklist_align = "center"

-- Titlebars
--
theme.titlebar_size = dpi(40)
theme.titlebar_bg_focus = theme.xcolor0
theme.titlebar_bg_normal = theme.xbackground
theme.titlebar_fg_normal = theme.xcolor8 .. "CC"
theme.titlebar_fg_focus = theme.xcolor8
theme.titlebar_minimize_button_normal = gears.color.recolor_image(gfs.get_configuration_dir() .. "icons/min.png", theme.xcolor3)
theme.titlebar_minimize_button_focus = gears.color.recolor_image(gfs.get_configuration_dir() .. "icons/min.png", theme.xcolor3)
theme.titlebar_close_button_normal = gears.color.recolor_image(gfs.get_configuration_dir() .. "icons/close.png", theme.xcolor9)
theme.titlebar_close_button_focus = gears.color.recolor_image(gfs.get_configuration_dir() .. "icons/close.png", theme.xcolor9)

-- Edge snap
--
theme.snap_bg = theme.xcolor8 .. "66"
theme.snap_shape = helpers.rrect(theme.border_radius)

-- Prompts
--
theme.prompt_bg = theme.xbackground
theme.prompt_fg = theme.xforeground

-- Tooltips
--
theme.tooltip_bg = theme.xbackground
theme.tooltip_fg = theme.xforeground
theme.tooltip_font = theme.font_name .. "12"
theme.tooltip_border_width = theme.widget_border_width
theme.tooltip_border_color = theme.xcolor0
theme.tooltip_opacity = 1
theme.tooltip_align = "left"

-- Menu
--
theme.menu_font = theme.font
theme.menu_bg_focus = theme.xcolor4
theme.menu_fg_focus = theme.xcolor7
theme.menu_bg_normal = theme.xbackground
theme.menu_fg_normal = theme.xcolor7
theme.menu_submenu_icon = gears.filesystem.get_configuration_dir() .. "theme/icons/submenu.png"
theme.menu_height = dpi(20)
theme.menu_width = dpi(130)
theme.menu_border_color = "#0000000"
theme.menu_border_width = theme.border_width

-- Hotkeys Pop Up
--
theme.hotkeys_font = theme.font
theme.hotkeys_border_color = theme.xcolor0
theme.hotkeys_group_margin = dpi(40)
theme.hotkeys_shape = helpers.rrect(theme.border_radius)

-- Recolor Layout icons:
theme = theme_assets.recolor_layout(theme, theme.xcolor8)

-- Gaps
theme.useless_gap = dpi(10)

-- Exit Screen
--
theme.exit_screen_fg = theme.xforeground
theme.exit_screen_bg = theme.xcolor0 .. "70"

-- Wibar
--
theme.wibar_height = dpi(30) + theme.widget_border_width
theme.wibar_margin = dpi(6)
theme.wibar_spacing = dpi(6)
theme.wibar_bg = theme.xbackground .. "fd"

-- Systray
--
theme.systray_icon_spacing = dpi(10)
theme.bg_systray = theme.xcolor0
theme.systray_icon_size = dpi(20)

-- Collision
--
theme.collision_focus_bg = theme.xcolor8
theme.collision_focus_fg = theme.xcolor6
theme.collision_focus_shape = helpers.rrect(theme.border_radius)
theme.collision_focus_border_width = theme.border_width
theme.collision_focus_border_color = theme.border_normal

theme.collision_focus_bg_center = theme.xcolor8
theme.collision_shape_width = dpi(50)
theme.collision_shape_height = dpi(50)
theme.collision_focus_shape_center = gears.shape.circle

theme.collision_max_bg = theme.xbackground
theme.collision_max_fg = theme.xcolor8
theme.collision_max_shape = helpers.rrect(theme.border_radius)
theme.bg_urgent = theme.xcolor9

theme.collision_resize_width = dpi(20)
theme.collision_resize_shape = theme.collision_focus_shape
theme.collision_resize_border_width = theme.collision_focus_border_width
theme.collision_resize_border_color = theme.collision_focus_border_color
theme.collision_resize_padding = dpi(5)
theme.collision_resize_bg = theme.collision_focus_bg
theme.collision_resize_fg = theme.collision_focus_fg

theme.collision_screen_shape = theme.collision_focus_shape
theme.collision_screen_border_width = theme.collision_focus_border_width
theme.collision_screen_border_color = theme.collision_focus_border_color
theme.collision_screen_padding = dpi(5)
theme.collision_screen_bg = theme.xbackground
theme.collision_screen_fg = theme.xcolor4
theme.collision_screen_bg_focus = theme.xcolor8
theme.collision_screen_fg_focus = theme.xcolor4

-- Notifs
--
theme.notification_spacing = dpi(10)
theme.notification_border_width = dpi(0)

-- Tag Preview
--
theme.tag_preview_widget_border_radius = dpi(theme.border_radius)
theme.tag_preview_client_border_radius = dpi(theme.border_radius)
theme.tag_preview_client_opacity = 0.5
theme.tag_preview_client_bg = theme.xcolor0 .. "33"
theme.tag_preview_client_border_color = theme.xcolor8
theme.tag_preview_client_border_width = theme.widget_border_width
theme.tag_preview_widget_bg = theme.xbackground
theme.tag_preview_widget_border_color = theme.widget_border_color
theme.tag_preview_widget_border_width = theme.widget_border_width
theme.tag_preview_widget_margin = dpi(0)

theme.fade_duration = 250

-- Window Switcher
theme.window_switcher_widget_bg = theme.xbackground
theme.window_switcher_name_font = theme.font_name .. "12"
theme.window_switcher_widget_border_width = dpi(1)
theme.window_switcher_widget_border_color = theme.xcolor0 -- The border color of the widget
theme.window_switcher_name_normal_color = theme.xforeground
theme.window_switcher_name_focus_color = theme.xcolor14
theme.window_switcher_icon_width = dpi(30)

return theme
