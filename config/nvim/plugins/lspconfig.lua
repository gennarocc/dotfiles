local M = {}

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

M.setup_lsp = function(attach, capabilities)
  local lspconfig = require("lspconfig")

  -- lspservers wih default config
  local servers = { "html", "cssls", "pyright", "yamlls", "tsserver" }

  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
      on_attach = attach,
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 150,
      },
    })
  end

  lspconfig.yamlls.setup({
    on_attach = function(client, bufnr)
      attach(client, bufnr)
      if vim.bo[bufnr].buftype ~= "" or vim.bo[bufnr].filetype == "helm then" then
        vim.diagnostic.disable()
      end
    end,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  })

  lspconfig.sumneko_lua.setup({
    on_attach = attach,
    capabilities = capabilities,
    -- Install 'lua-language-server' from AUR
    cmd = { "/usr/bin/lua-language-server", "-E", "/usr/share/lua-language-server/main.lua" },
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          -- Setup your lua path
          path = runtime_path,
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  })
end

return M
