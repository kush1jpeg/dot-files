---@diagnostic disable: missing-fields

return {
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("kanagawa").setup({
        transparent = true,
        theme = "wave",  -- or dragon / lotus / default
        background = {
          dark = "wave", -- try "dragon" or "lotus"
          light = "lotus",
        },
      })
      vim.cmd("colorscheme kanagawa-wave")
    end,
  },
}
