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
		"hrsh7th/nvim-cmp",
		dependencies = { "hrsh7th/cmp-emoji" },
		opts = function(_, opts)
			opts.sources = opts.sources or {}
			table.insert(opts.sources, { name = "emoji" })
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		keys = {
			{
				"<leader>fp",
				function()
					require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
				end,
				desc = "Find Plugin File",
			},
		},
		opts = {
			defaults = {
				layout_strategy = "horizontal",
				layout_config = { prompt_position = "top" },
				sorting_strategy = "ascending",
				winblend = 0,
			},
		},
	},

	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				clangd = {
					cmd = { "clangd" },
					filetypes = { "c", "cpp", "objc", "objcpp" },
				},
				pyright = {},
				emmet_ls = {},
				tailwindcss = {},
				denols = { autostart = false },
				tsserver = {},
				gopls = {
					cmd = { "gopls" },
					filetypes = { "go", "gomod" },
					root_dir = require("lspconfig.util").root_pattern("go.mod", ".git"),
					settings = {
						gopls = {
							analyses = {
								unusedparams = true,
								unusedwrite = true,
								nilness = true,
								shadow = true,
							},
							staticcheck = true,
						},
					},
				},
			},
			setup = {
				tsserver = function(_, opts)
					require("typescript").setup({ server = opts })
					return true
				end,
			},
		},
		dependencies = {
			"jose-elias-alvarez/typescript.nvim",
		},
		config = function(_, opts)
			local lspconfig = require("lspconfig")
			for server, server_opts in pairs(opts.servers) do
				lspconfig[server].setup(server_opts)
			end

			-- Diagnostics config goes here
			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = true,
			})
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
