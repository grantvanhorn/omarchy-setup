-- ESLint LSP configuration for diagnostics and code actions
-- This provides red squiggly lines and code actions in addition to conform.nvim formatting
-- Note: This requires nvim-lspconfig to be installed. If you don't have it, conform.nvim alone will work.
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        eslint = {
          settings = {
            -- Helps eslint find the eslintrc when not in cwd
            workingDirectories = { mode = "auto" },
            -- Enable code actions
            codeAction = {
              disableRuleComment = {
                enable = true,
                location = "separateLine",
              },
              showDocumentation = {
                enable = true,
              },
            },
          },
          on_attach = function(client, bufnr)
            -- Enable format on save via ESLint LSP (works alongside conform.nvim)
            if client.name == "eslint" then
              vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                command = "EslintFixAll",
              })
            end
          end,
        },
      },
    },
  },
}
