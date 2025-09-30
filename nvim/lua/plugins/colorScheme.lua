---@diagnostic disable: missing-fields

return {
	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
		lazy = false,
		config = function()
			require("kanagawa").setup({
				transparent = true,
				theme = "wave", -- or dragon / lotus / default
				background = {
					dark = "wave",
					light = "lotus",
				},
			})
			vim.cmd("colorscheme kanagawa-wave")
		end,
	},

	{
		"nvimdev/dashboard-nvim",
		priority = 100,
		lazy = false,
		config = function()
			local db = require("dashboard")

			-- Only load dashboard if no files/folders are passed
			if vim.fn.argc() == 0 then
				db.setup({
					theme = "doom",
					config = {
						header = {
							"  ██                                                                        ",
							" ███                       ███      ███     ███                             ",
							" ███  ███ ███  ███  █████  ███       ███        ██ ███      ███      █████  ",
							" ███ ███  ███  ███ ███     █████     ███    ███ ██  ███   ██   ███  ███  ███",
							" █████    ███  ███   ████  ███  ██   ███    ███ ██   ███ █████████  ██   ███",
							" ███ ███  ███  ███     ███ ██   ███  ███    ███ ███ ███  ██         ████ ███",
							" ███  ███   ██████ ██████  ██   ███ █████   ███ ███        █████        ███ ",
							"                                          ████  ███                   ████  ",
							"",
							"",
						},
						center = {
							{
								icon = "  ",
								desc = "Lazy: Manage Plugins",
								key = "l",
								key_format = " [%s]",
								action = "Lazy",
							},
							{
								icon = "  ",
								desc = "Lazy: Plugin Updates",
								key = "u",
								key_format = " [%s]",
								action = "Lazy update",
							},
							{ icon = "  ", desc = "Mason:", key = "m", key_format = " [%s]", action = "Mason" },
							{
								icon = "  ",
								desc = "checkhealth",
								key = "h",
								key_format = " [%s]",
								action = "checkhealth",
							},
							{ icon = "  ", desc = "New File", key = "n", key_format = " [%s]", action = "enew" },
							{ icon = "  ", desc = "Quit?", key = "q", key_format = " [%s]", action = "qa" },
						},
						footer = { "https://github.com/kush1jpeg/" },
						vertical_center = true,
					},
				})

				vim.cmd("Dashboard")
			end
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
}
