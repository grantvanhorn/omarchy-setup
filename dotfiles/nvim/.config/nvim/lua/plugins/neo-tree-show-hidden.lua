return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true, -- This is what you want: If true, then all files are visible by default
          hide_dotfiles = false, -- This is the key setting: show dotfiles
          hide_gitignored = false, -- Also show gitignored files
        },
      },
    },
  },
}
