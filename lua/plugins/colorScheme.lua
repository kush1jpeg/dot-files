return {
  {
    "Mofiqul/dracula.nvim",
    priority = 1000, -- must be high to load first
    lazy = false,    -- load it during startup
  },
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("kanagawa").setup({
        transparent = true,
        theme = "wave", -- or dragon / lotus / default
        background = {
          dark = "wave",     -- try "dragon" or "lotus"
          light = "lotus",
        },
      })
      vim.cmd("colorscheme kanagawa")
    end,
  },
}
