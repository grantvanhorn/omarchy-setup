-- ESLint LSP configuration
-- TypeScript support is handled by typescript-tools.nvim (see typescript-tools.lua)
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
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
  -- Mason for managing LSP servers
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {
      ensure_installed = {
        "typescript-language-server", -- TypeScript LSP (used by typescript-tools.nvim)
        "eslint-lsp", -- ESLint LSP
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      automatic_installation = true, -- Auto-install LSP servers
    },
  },
}
