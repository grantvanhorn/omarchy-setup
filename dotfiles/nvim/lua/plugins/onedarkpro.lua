return {
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Load early to ensure colors are available
    lazy = false, -- Load immediately, not on demand
    config = function()
      require("onedarkpro").setup({})
      vim.cmd("colorscheme onedark_dark")
    end,
  },
}
