return {
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Load early to ensure colors are available
    lazy = false, -- Load immediately, not on demand
    init = function()
      -- Set background to dark before theme loads
      vim.o.background = "dark"
    end,
    config = function()
      require("onedarkpro").setup({
        options = {
          transparency = false, -- Ensure background is not transparent
          terminal_colors = true, -- Use theme colors for terminal
          cursorline = true, -- Enable cursorline highlighting
        },
      })

      vim.cmd("colorscheme onedark_dark")

      -- Enable cursorline
      vim.opt.cursorline = true

      -- Override the transparency script that sets bg = "none"
      -- Create an autocmd that runs after VimEnter to restore theme background
      vim.api.nvim_create_autocmd("VimEnter", {
        once = true,
        callback = function()
          -- Wait a bit for all scripts to load, then restore background
          vim.defer_fn(function()
            -- Re-apply colorscheme to override transparency settings
            vim.cmd("colorscheme onedark_dark")

            -- Customize cursorline to be a different color than background
            -- Get the theme's background color
            local normal_bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
            if normal_bg then
              -- Set cursorline to a slightly lighter/darker shade
              -- For onedark_dark, we'll use a slightly lighter gray
              -- You can adjust this color to your preference
              vim.api.nvim_set_hl(0, "CursorLine", {
                bg = "#2c313c", -- Slightly lighter than typical onedark_dark background
                ctermbg = 236, -- Dark gray in terminal
              })
            else
              -- Fallback: use a subtle highlight
              vim.api.nvim_set_hl(0, "CursorLine", {
                bg = "#2c313c",
                ctermbg = 236,
              })
            end
          end, 50)
        end,
      })
    end,
  },
}
