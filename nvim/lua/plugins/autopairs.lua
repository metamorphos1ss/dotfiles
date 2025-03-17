return {
  "windwp/nvim-autopairs",
  dependencies = { "hrsh7th/nvim-cmp" }, -- Убедитесь, что nvim-cmp загружен
  config = function()
    -- Ожидаем загрузки nvim-cmp
    local cmp_status, cmp = pcall(require, "cmp")
    if cmp_status then
      -- Настройка nvim-autopairs
      require("nvim-autopairs").setup({
        check_ts = true, -- Используем Treesitter для анализа синтаксиса
      })

      -- Интеграция с nvim-cmp для автодополнений
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    else
      print("Не удалось загрузить nvim-cmp.")
    end
  end,
}

