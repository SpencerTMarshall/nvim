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
   { "williamboman/mason.nvim" },
   {
      "williamboman/mason-lspconfig.nvim",
      dependencies = { "williamboman/mason.nvim" },
   },
   {
      "neovim/nvim-lspconfig",
      dependencies = { "williamboman/mason-lspconfig.nvim" },
   },
   { "hrsh7th/cmp-nvim-lsp" },
   { "L3MON4D3/LuaSnip" },
   { "saadparwaiz1/cmp_luasnip" },
   {
      "hrsh7th/nvim-cmp",
      dependencies = {
         "hrsh7th/cmp-nvim-lsp",
         "L3MON4D3/LuaSnip",
         "saadparwaiz1/cmp_luasnip",
      },
      config = function()
         require("config.lsp")
      end,
   },
}
