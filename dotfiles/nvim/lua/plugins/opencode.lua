-- OpenCode.nvim: Integrate OpenCode AI assistant with Neovim
-- Uses Ollama for local, free AI models
-- Note: This plugin uses the OpenCode CLI configuration from ~/.config/opencode/opencode.json
return {
  {
    "NickvanDyke/opencode.nvim",
    event = "VeryLazy", -- Load after startup
    keys = {
      -- Ask OpenCode a question (opens prompt input)
      { "<leader>oa", function() require("opencode").ask() end, desc = "Ask OpenCode" },
      -- Select from OpenCode actions (prompts, commands, etc.)
      { "<leader>os", function() require("opencode").select() end, desc = "OpenCode Select" },
      -- Toggle OpenCode provider
      { "<leader>ot", function() require("opencode").toggle() end, desc = "Toggle OpenCode" },
    },
    config = function()
      -- The plugin automatically uses your OpenCode CLI config
      -- from ~/.config/opencode/opencode.json (which has Ollama configured)

      -- Enable autoread for buffer reloading (required for buffer reloading)
      vim.o.autoread = true

      -- Create OpenCode command (similar to <leader>ot)
      vim.api.nvim_create_user_command("OpenCode", function()
        require("opencode").toggle()
      end, { desc = "Toggle OpenCode" })

      -- Optional: Set global options if needed
      -- vim.g.opencode_opts = {
      --   -- Add custom options here if needed
      -- }
    end,
  },
}
