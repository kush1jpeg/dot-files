-- FILE: plugins/extras.lua
return {
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    ui = {
      border = "rounded",
      colors = {
        normal_bg = "#1f1f28",
        title_bg = "#e0af68",
      },
    },
  },

  config = function()
    require("lspsaga").setup({})
    vim.keymap.set("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", { desc = "Line Diagnostics" })
    vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "Code Action" })
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-lspconfig",
  },
  {
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover (Native)" })
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      { "marilari88/neotest-vitest", lazy = true },
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

      return { adapters = adapters }
    end,
  },

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

  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        json = { "prettier" },
        css = { "prettier" },
        c = { "clang_format" },
        cpp = { "clang_format" },
      },
      format_on_save = function(bufnr)
        local ignore_filetypes = { "markdown" }
        return not vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype)
      end,
    },
  },

  ---@diagnostic disable: missing-fields
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("kanagawa").setup({
        transparent = true,
        theme = "dragon",
        background = {
          dark = "wave",
          light = "lotus",
        },
      })
      vim.cmd("colorscheme kanagawa")
    end,
  },
}
