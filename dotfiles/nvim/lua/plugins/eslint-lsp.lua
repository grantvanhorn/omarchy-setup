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
            -- Disable formatting via LSP - conform.nvim handles it faster with eslint_d
            -- ESLint LSP is only used for diagnostics (error highlighting)
            if client.name == "eslint" then
              client.server_capabilities.documentFormattingProvider = false
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
