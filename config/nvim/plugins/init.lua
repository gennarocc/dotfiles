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
      require("orgmode").setup({
        org_agenda_files = { "~/org/*", "~/my-orgs/**/*" },
        org_default_notes_file = "~/org/refile.org",
      })
    end,
  },
  {
    "ivyl/vim-bling",
  },
}
