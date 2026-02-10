return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      -- Define your formatters
      formatters_by_ft = {
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        -- Fallback to prettier if eslint_d is not available
        -- You can also use both: { "eslint_d", "prettier" }
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        lua = { "stylua" },
        -- Add more file types as needed
      },
      -- Set up format on save (this is the key feature!)
      format_on_save = {
        -- Enable format on save
        enabled = true,
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        -- Use LSP formatting as a fallback if formatter fails
        lsp_fallback = true,
      },
      -- Configure formatters
      formatters = {
        -- ESLint formatter configuration
        eslint_d = {
          condition = function(ctx)
            -- Only run if eslint is available
            return vim.fs.find({ "eslint.config.js", "eslint.config.mjs", ".eslintrc.js", ".eslintrc.json", ".eslintrc.yml", ".eslintrc.yaml" }, { path = ctx.filename, upward = true })[1]
          end,
        },
        prettier = {
          prepend_args = { "--print-width", "100" },
        },
      },
    },
  },
}
