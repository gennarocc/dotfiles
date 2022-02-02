-- IMPORTANT NOTE : This is the user config, can be edited. Will be preserved if updated with internal updater
-- This file is for NvChad options & tools, custom settings are split between here and 'lua/custom/init.lua'
local M = {}
M.options, M.ui, M.mappings, M.plugins = {}, {}, {}, {}

--------------------------------------------------------------------
-- To use this file, copy the strucutre of `core/default_config.lua`,
-- examples of setting relative number & changing theme:

-- M.options = {
--    relativenumber = true,
-- }
M.mappings = {
   window_nav = {
      moveLeft = "<leader>wh",
      moveRight = "<leader>wl",
      moveUp = "<leader>wk",
      moveDown = "<leadaer>wj",
   },
   terminal = {
      new_window = "<C-w>",
      new_horizontal = "<C-h>",
      new_vertical = "<C-v>",
   },
}

M.ui = { theme = "gruvchad", transparency = true }

-- NvChad included plugin options & overrides
M.plugins = {
   status = {
      truzen = true,
      colorizer = true,
      orgmode = true,
      neoformat = true,
      neoscroll = true,
   },
   options = {
      lspconfig = {
         --    path of file containing setups of different lsps (ex : "custom.plugins.lspconfig"), read the docs for more info
         setup_lspconf = "custom.plugins.lspconfig",
      },
      statusline = { style = "block" },
   },
   -- To change the Packer `config` of a plugin that comes with NvChad,
   -- add a table entry below matching the plugin github name
   --              '-' -> '_', remove any '.lua', '.nvim' extensions
   -- this string will be called in a `require`
   --              use "(custom.configs).my_func()" to call a function
   --              use "custom.blankline" to call a file
   default_plugin_config_replace = {
      nvim_treesitter = "custom.plugins.treesitter",
      nvim_tree = "custom.plugins.nvimtree",
   },
}

return M
