-- ~/.config/nvim/lua/plugins/vue.lua
return {
  -- LSP 配置
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        volar = {
          filetypes = { "vue", "javascript", "typescript", "javascriptreact", "typescriptreact" },
          init_options = {
            vue = {
              hybridMode = false, -- 使用 Volar 的 Take Over 模式
            },
          },
        },
      },
      setup = {
        volar = function()
          require("lspconfig").volar.setup({
            filetypes = { "vue", "javascript", "typescript", "javascriptreact", "typescriptreact" },
          })
        end,
      },
    },
  },

  -- Treesitter 语法高亮
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "vue", "javascript", "typescript", "html", "css" })
    end,
  },

  -- 格式化 (Prettier)
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        vue = { "prettier" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
      },
    },
  },

  -- Linting (ESLint)
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        vue = { "eslint" },
        javascript = { "eslint" },
        typescript = { "eslint" },
      },
    },
  },

  -- Tailwind CSS 补全
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          filetypes = { "vue", "html", "css", "javascript", "typescript" },
        },
      },
    },
  },

  -- 调试支持 (DAP)
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "mxsdev/nvim-dap-vscode-js",
    },
    config = function()
      require("dap").adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "js-debug-adapter",
          args = { "${port}" },
        },
      }
      require("dap").configurations.vue = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch Vue App",
          program = "${file}",
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          skipFiles = { "<node_internals>/**" },
          protocol = "inspector",
          console = "integratedTerminal",
        },
      }
    end,
  },
}
