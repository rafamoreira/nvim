return {
  -- Mason: portable LSP/formatter/linter installer
  {
    "mason-org/mason.nvim",
    opts = {},
  },

  -- Bridge between mason and lspconfig — auto-installs and enables servers
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "lua_ls",
        "basedpyright",
        "rust_analyzer",
        "ts_ls",
        "clangd",
        "zls",
        "bashls",
        "html",
      },
      automatic_enable = true,
    },
  },

  -- LSP server default configs (provides lsp/ runtime files)
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Keybindings on LspAttach (gd, gr, gI, gy, gD, etc. are in snacks.nvim)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("K", vim.lsp.buf.hover, "Hover Documentation")
          map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "v" })
          map("<leader>cr", vim.lsp.buf.rename, "Rename Symbol")
          map("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
          map("]d", vim.diagnostic.goto_next, "Next Diagnostic")
          map("<leader>cd", vim.diagnostic.open_float, "Line Diagnostics")
        end,
      })

      -- Server-specific overrides via vim.lsp.config()
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim", "Snacks" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            completion = { callSnippet = "Replace" },
          },
        },
      })

      vim.lsp.config("rust_analyzer", {
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = { command = "clippy" },
          },
        },
      })
    end,
  },
}
