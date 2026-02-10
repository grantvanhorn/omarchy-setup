# Neovim ESLint Auto-Format on Save Setup

This configuration automatically applies ESLint fixes and formatting when you save JavaScript/TypeScript files, similar to VS Code's "fix all on save" behavior.

## Features

- ✅ Automatic ESLint formatting on save
- ✅ Works with JavaScript, TypeScript, JSX, and TSX files
- ✅ Provides diagnostics (red squiggly lines) via ESLint LSP
- ✅ Code actions for ESLint issues

## Prerequisites

### 1. Install ESLint

You need ESLint installed in your project or globally:

```bash
# In your project
npm install eslint --save-dev

# Or globally
npm install -g eslint
```

### 2. Install eslint_d (Recommended for Performance)

`eslint_d` is a daemon that makes ESLint much faster:

```bash
# Globally
npm install -g eslint_d

# Or in your project
npm install eslint_d --save-dev
```

### 3. ESLint Configuration

Make sure you have an ESLint config file in your project:
- `.eslintrc.js`
- `.eslintrc.json`
- `.eslintrc.yml`
- `eslint.config.js` (newer format)
- `eslint.config.mjs`

### 4. Neovim Plugins

The configuration uses:
- `stevearc/conform.nvim` - For formatting
- `neovim/nvim-lspconfig` - For ESLint LSP (optional, but recommended for diagnostics)

These will be automatically installed by your plugin manager (lazy.nvim).

## How It Works

1. **conform.nvim** (`lua/plugins/conform.lua`):
   - Automatically formats your code on save using ESLint
   - Configured to use `eslint_d` for JavaScript/TypeScript files
   - Falls back to LSP formatting if the formatter fails

2. **ESLint LSP** (`lua/plugins/eslint-lsp.lua`):
   - Provides real-time diagnostics (error highlighting)
   - Enables code actions for ESLint issues
   - Also runs `EslintFixAll` on save as a backup

## Manual Formatting

You can also manually format a buffer using:
- `<leader>f` - Format the current buffer

## Troubleshooting

### ESLint not running

1. Make sure ESLint is installed and accessible in your PATH
2. Check that you have an ESLint config file in your project
3. Verify `eslint_d` is installed if you're using it

### Formatting not working

1. Check if conform.nvim is loaded: `:ConformInfo`
2. Verify ESLint can run: `npx eslint --version`
3. Check Neovim logs: `:messages`

### LSP not working

1. Make sure `nvim-lspconfig` is installed
2. Install the ESLint LSP server (usually via Mason or manually)
3. Check LSP status: `:LspInfo`

## Files

- `lua/plugins/conform.lua` - Main formatting configuration
- `lua/plugins/eslint-lsp.lua` - ESLint LSP server configuration (optional)
