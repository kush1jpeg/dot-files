vim.diagnostic.config({
  virtual_text = {
    prefix = "", -- or any icon
    spacing = 2,
    source = "if_many",
    severity = { min = vim.diagnostic.severity.WARN },
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  float = { border = "rounded", focusable = false },
})


-- loading this for disablind the stupid err messg
vim.g.lazyvim_check_order = false

-- 🚀 Load LazyVim setup
require("config.lazy")
