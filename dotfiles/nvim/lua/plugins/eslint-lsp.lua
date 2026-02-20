-- ESLint LSP configuration
-- TypeScript support is handled by typescript-tools.nvim (see typescript-tools.lua)

-- Fix all function using native LSP API (no dependencies on lspconfig.util)
local function fix_all(opts)
  opts = opts or {}

  local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()
  vim.validate({ bufnr = { bufnr, "number" } })

  local client = opts.client or vim.lsp.get_clients({ bufnr = bufnr, name = "eslint" })[1]

  if not client then
    return
  end

  local request

  if opts.sync then
    request = function(buf, method, params)
      return client:request_sync(method, params, nil, buf)
    end
  else
    request = function(buf, method, params)
      client:request(method, params, nil, buf)
    end
  end

  request(bufnr, "workspace/executeCommand", {
    command = "eslint.applyAllFixes",
    arguments = {
      {
        uri = vim.uri_from_bufnr(bufnr),
        version = vim.lsp.util.buf_versions[bufnr],
      },
    },
  })
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
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
          on_init = function(client)
            -- Create EslintFixAll command using the fix_all function
            vim.api.nvim_create_user_command("EslintFixAll", function()
              fix_all({ client = client, sync = true })
            end, {})
          end,
          on_attach = function(client, bufnr)
            -- Disable formatting via LSP - conform.nvim handles it faster with eslint_d
            -- ESLint LSP is used for diagnostics (error highlighting) and auto-fixing
            if client.name == "eslint" then
              client.server_capabilities.documentFormattingProvider = false

              -- Set up autocommand to run ESLint Fix All on save
              -- This runs before conform.nvim's formatting
              local eslint_fix_group = vim.api.nvim_create_augroup("eslint_fix", { clear = true })
              vim.api.nvim_create_autocmd("BufWritePre", {
                group = eslint_fix_group,
                buffer = bufnr,
                callback = function()
                  fix_all({ client = client, bufnr = bufnr, sync = true })
                end,
              })
            end
          end,
        },
      },
    },
  },
  -- Mason for managing LSP servers
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    opts = {
      ensure_installed = {
        "typescript-language-server", -- TypeScript LSP (used by typescript-tools.nvim)
        "eslint-lsp", -- ESLint LSP
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      automatic_installation = true, -- Auto-install LSP servers
    },
  },
}
