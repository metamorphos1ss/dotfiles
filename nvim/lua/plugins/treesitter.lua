return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate", -- Автообновление
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "lua", "python", "javascript", "html", "css", "json" },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    })
  end,
}
