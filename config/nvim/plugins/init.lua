return {
  {
    "karb94/neoscroll.nvim",
    opt = true,
    config = function()
      require("neoscroll").setup()
    end,
    setup = function()
      require("core.utils").packer_lazy_load("neoscroll.nvim")
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    after = "nvim-lspconfig",
    config = function()
      require("custom.plugins.null-ls").setup()
    end,
  },
  {
    "kristijanhusak/orgmode.nvim",
    after = "nvim-treesitter",
    config = function()
      require("orgmode").setup_ts_grammar({
        org_agenda_files = { "~/org/*", "~/my-orgs/**/*" },
        org_default_notes_file = "~/org/refile.org",
      })
    end,
  },
  {
    "ivyl/vim-bling",
  },
  {
    "towolf/vim-helm",
  },
  "AckslD/nvim-neoclip.lua",
  config = function()
    require("neoclip").setup({
      history = 1000,
      enable_persistent_history = false,
      continious_sync = false,
      db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
      filter = nil,
      preview = true,
      default_register = '"',
      default_register_macros = "q",
      enable_macro_history = true,
      content_spec_column = false,
      on_paste = {
        set_reg = false,
      },
      on_replay = {
        set_reg = false,
      },
      keys = {
        telescope = {
          i = {
            select = "<cr>",
            paste = "<c-p>",
            paste_behind = "<c-k>",
            replay = "<c-q>", -- replay a macro
            delete = "<c-d>", -- delete an entry
            custom = {},
          },
          n = {
            select = "<cr>",
            paste = "p",
            paste_behind = "P",
            replay = "q",
            delete = "d",
            custom = {},
          },
        },
        fzf = {
          select = "default",
          paste = "ctrl-p",
          paste_behind = "ctrl-k",
          custom = {},
        },
      },
    })
  end,
}
