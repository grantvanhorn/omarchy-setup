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
        -- Use eslint_d if available (much faster), fallback to eslint
        javascript = { "eslint_d", "eslint" },
        javascriptreact = { "eslint_d", "eslint" },
        typescript = { "eslint_d", "eslint" },
        typescriptreact = { "eslint_d", "eslint" },
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
        -- Increase timeout for larger files (eslint_d should be fast, but give it time)
        timeout_ms = 2000,
        -- Use LSP formatting as a fallback if formatter fails
        lsp_fallback = false, -- Disable to avoid double formatting
      },
      -- Configure formatters
      formatters = {
        -- ESLint formatter configuration (using eslint_d for performance)
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
