-- FILE: plugins/main.lua
return {
	{
		"folke/trouble.nvim",
		opts = { use_diagnostic_signs = true },
		config = function(_, opts)
			require("trouble").setup(opts)
			vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<CR>")
		end,
	},
	{
		"folke/snacks.nvim",
		opts = {
			picker = {
				sources = {
					explorer = {
						hidden = true, -- Enable hidden files so .env can be seen
						exclude = {
							"**/.git",
							"**/node_modules",
							"**/.DS_Store",
							"**/.github",
						},
					},
				},
			},
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = { "hrsh7th/cmp-emoji" },
		opts = function(_, opts)
			opts.sources = opts.sources or {}
			table.insert(opts.sources, { name = "emoji" })
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"bash",
				"html",
				"javascript",
				"json",
				"tsx",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"tsx",
				"glsl",
				"typescript",
				"vim",
				"yaml",
				"go",
				"gomod",
			},
		},
	},

	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = function(_, opts)
			opts.sections = opts.sections or {}
			opts.sections.lualine_x = opts.sections.lualine_x or {}
			table.insert(opts.sections.lualine_x, function()
				return "👹"
			end)
		end,
	},

	{ import = "lazyvim.plugins.extras.lang.json" },

	{
		"mason-org/mason.nvim",
		opts = {
			ensure_installed = {
				"stylua",
				"shellcheck",
				"shfmt",
				"flake8",
				"typescript-language-server",
				"gopls",
				"golangci-lint",
				"goimports",
				"gofumpt",
			},
		},
	},
}
