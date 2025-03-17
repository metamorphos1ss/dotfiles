return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- Загрузка сниппетов из VS Code
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm({ select = true }) -- Подтверждает первое предложение
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump() -- Разворачивает сниппеты или перемещается по ним
            else
              fallback() -- Выполняет стандартное действие Tab
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item() -- Переход к предыдущему элементу
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1) -- Возврат в предыдущую позицию сниппета
            else
              fallback() -- Выполняет стандартное действие Shift+Tab
            end
          end, { "i", "s" }),

          -- Замена Shift + Tab на стрелочки вверх и вниз
          ["<Up>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item() -- Переход к предыдущему элементу
            else
              fallback() -- Выполняет стандартное действие стрелки вверх
            end
          end, { "i", "s" }),

          ["<Down>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item() -- Переход к следующему элементу
            else
              fallback() -- Выполняет стандартное действие стрелки вниз
            end
          end, { "i", "s" }),

          ["<CR>"] = cmp.mapping.confirm { select = true }, -- Подтверждает текущий выбор
          ["<C-Space>"] = cmp.mapping.complete(), -- Вручную открывает автодополнение
        },
        sources = cmp.config.sources {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
        formatting = {
          format = function(entry, vim_item)
            -- Значки как в VS Code
            local kind_icons = {
              Text = "",
              Method = "",
              Function = "",
              Constructor = "",
              Field = "ﰠ",
              Variable = "",
              Class = "ﴯ",
              Interface = "",
              Module = "",
              Property = "ﰠ",
              Unit = "",
              Value = "",
              Enum = "",
              Keyword = "",
              Snippet = "",
              Color = "",
              File = "",
              Reference = "",
              Folder = "",
              EnumMember = "",
              Constant = "",
              Struct = "פּ",
              Event = "",
              Operator = "",
              TypeParameter = "",
            }
            vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]
            return vim_item
          end,
        },
      }

      -- Настройка автодополнения для командной строки
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "path" },
          { name = "cmdline" },
        },
      })
    end,
  },
}
