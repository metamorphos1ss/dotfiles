return {
  -- Настройка LSP и менеджера серверов
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = { "pyright", "lua_ls", "html", "cssls", "ts_ls" },
      }
      local lspconfig = require("lspconfig")

      -- Настройки для каждого LSP-сервера
      local servers = {
        pyright = {}, -- Python
        lua_ls = {    -- Lua
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } }, -- Устранение ошибки Undefined global vim
              workspace = { library = vim.api.nvim_get_runtime_file("", true) },
              telemetry = { enable = false },
            },
          },
        },
        html = {}, -- HTML
        cssls = {}, -- CSS
        ts_ls = {}, -- JavaScript/TypeScript (исправлено с "ts_ls" на "tsserver")
      }

      for server, config in pairs(servers) do
        lspconfig[server].setup(config)
      end
    end,
  },
}

