local M = {}

local present, ts_config = pcall(require, "nvim-treesitter.configs")
if not present then
   return
end

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.org = {
   install_info = {
      url = "https://github.com/milisims/tree-sitter-org",
      revision = "main",
      files = { "src/parser.c", "src/scanner.cc" },
   },
   filetype = "org",
}

M.setup_treesitter = {
   ts_config.setup {
      ensure_installed = {
         "lua",
         "org",
      },
      highlight = {
         enable = true,
         disable = { "org" },
         use_languagetree = true,
         additional_vim_regex_highlighting = { "org" },
      },
   },
}

return M
