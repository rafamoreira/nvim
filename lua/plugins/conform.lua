return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = { "n", "v" },
      desc = "Format Buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "ruff" },
      rust = { "rustfmt" },
      typescript = { "prettier" },
      javascript = { "prettier" },
      html = { "prettier" },
      markdown = { "prettier" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      zig = { "zigfmt" },
      sh = { "shfmt" },
      bash = { "shfmt" },
    },
    format_on_save = {
      timeout_ms = 3000,
      lsp_fallback = true,
    },
  },
}
