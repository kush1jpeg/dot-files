return {

  -- 🧪 Neotest with Vitest + Jest
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      {"marilari88/neotest-vitest",lazy = true},
      "nvim-neotest/neotest-jest",
      "nvim-neotest/nvim-nio",
    },
    opts = function()
      local adapters = {}

      local ok_jest, jest = pcall(require, "neotest-jest")
      if ok_jest then
        table.insert(adapters, jest({
          jestCommand = "npm test --",
          jestConfigFile = "jest.config.js",
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        }))
      end

      local ok_vitest, vitest = pcall(require, "neotest-vitest")
      if ok_vitest then
        table.insert(adapters, vitest({}))
      end

      return {
        adapters = adapters,
      }
    end,
  },

  -- 🌈 Treesitter for JS/TS/HTML/CSS/etc.
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "javascript",
        "typescript",
        "tsx",
        "json",
        "html",
        "css",
      },
    },
  },

  -- 🐞 DAP for Node debugging
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "theHamsta/nvim-dap-virtual-text",
        config = true,
      },
    },
    config = function()
      local ok, dap = pcall(require, "dap")
      if not ok then return end

      dap.adapters.node2 = {
        type = "executable",
        command = "node",
        args = {
          vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js",
        },
      }

      dap.configurations.javascript = {
        {
          name = "Launch file",
          type = "node2",
          request = "launch",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          console = "integratedTerminal",
        },
      }

      dap.configurations.typescript = dap.configurations.javascript
    end,
  },

  -- 🧰 Mason installer for dev tools
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "tsserver",
        "eslint-lsp",
        "prettier",
        "eslint_d",
        "node-debug2-adapter",
        "emmet-ls",
        "tailwindcss-language-server",
        "typescript-language-server",
      })
    end,
  },

  -- 💻 Emmet LSP + TS + Tailwind LSP
  {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      emmet_ls = {},
      tsserver = {},
      tailwindcss = {},
      -- 🔻 Add this to disable Deno
      denols = {
        autostart = false,
      },
    },
  },
},


  -- ✨ Snippets for React + more
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  -- 🔍 Null-ls for prettier/eslint format + lint
 {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      javascript = { "prettier" },
      typescript = { "prettier" },
      json = { "prettier" },
      css = { "prettier" },
    },
--func to format the text on exit brruh
format_on_save = function(bufnr)
  -- Disable autoformat for certain filetypes
  local ignore_filetypes = { "markdown" }
  return not vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype)
end,

  },
},
--themes
 {
    "Mofiqul/dracula.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      vim.cmd.colorscheme("dracula")
    end,
  },
 {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("kanagawa").setup({
        transparent = true,
        theme = "dragon", -- or dragon / lotus / default or wave
        background = {
          dark = "dragon",     -- try "dragon" or "lotus" or wave
          light = "lotus",
        },
      })
      vim.cmd("colorscheme kanagawa")
    end,
  },



}

