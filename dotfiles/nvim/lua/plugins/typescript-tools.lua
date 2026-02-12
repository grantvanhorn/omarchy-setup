-- TypeScript/JavaScript LSP configuration
-- Provides autocomplete, auto-imports, go-to-definition, and project-wide code intelligence
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tsserver = {
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern("tsconfig.json", "jsconfig.json", "package.json")(fname)
              or require("lspconfig.util").root_pattern(".git")(fname)
          end,
          settings = {
            typescript = {
              -- Enable auto-imports (this is the key feature you wanted!)
              suggest = {
                autoImports = true,
              },
              -- Improve project-wide code intelligence
              inlayHints = {
                parameterNames = { enabled = "all" },
                variableTypes = { enabled = false },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
              },
              -- Better file discovery
              preferences = {
                includePackageJsonAutoImports = "on",
                importModuleSpecifierPreference = "relative",
              },
            },
            javascript = {
              suggest = {
                autoImports = true,
              },
              inlayHints = {
                parameterNames = { enabled = "all" },
                variableTypes = { enabled = false },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
              },
              preferences = {
                includePackageJsonAutoImports = "on",
                importModuleSpecifierPreference = "relative",
              },
            },
          },
          -- Disable formatting (let conform.nvim handle it)
          on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false

            -- Keybindings for LSP features
            local opts = { noremap = true, silent = true, buffer = bufnr }
            -- Go to definition
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
            -- Go to references
            vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Go to references" }))
            -- Hover documentation
            vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
            -- Code actions (including auto-import)
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code actions" }))
            -- Rename symbol
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
          end,
        },
      },
    },
  },
}
