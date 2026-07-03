return {
   {
      "catppuccin/nvim",
      name = "catppuccin",
      config = function()
         vim.cmd("colorscheme catppuccin-mocha")
      end
   },
   {
      "nvim-lua/plenary.nvim"
   },
   {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-lua/plenary.nvim" }
   },
   {
      "lewis6991/gitsigns.nvim"
   },
   {
      "rmagatti/goto-preview",
      dependencies = { "rmagatti/logger.nvim" },
      branch = "fix-lsp-handler-nvim-010",
      event = "BufEnter",
      config = function()
         require("goto-preview").setup()
         vim.keymap.set("n", "gp", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", {noremap=true})
         return true
      end
   },
   {
      "nvim-treesitter/nvim-treesitter",
      lazy=false
   },
}
