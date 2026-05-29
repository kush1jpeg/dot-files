-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<S-Tab>", function()
	vim.notify("opening image with tiv", vim.log.levels.INFO)

	local file = vim.fn.expand("%:p")
	vim.cmd("terminal tiv " .. vim.fn.shellescape(file))
end, { silent = true })
