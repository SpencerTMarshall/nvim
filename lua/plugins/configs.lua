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
      "lewis6991/gitsigns.nvim",
      config = function()
         require("gitsigns").setup({
            on_attach = function(bufnr)
               local gs = require("gitsigns")
               local opts = { buffer = bufnr }
               vim.keymap.set("n", "]g", gs.next_hunk, opts)
               vim.keymap.set("n", "[g", gs.prev_hunk, opts)
            end,
         })
      end,
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
      branch = "main",
      lazy = false,
      build = ":TSUpdate",
      init = function()
         local ensure_installed = { "lua", "rust", "toml" }
         local installed = require("nvim-treesitter.config").get_installed()
         local to_install = vim.iter(ensure_installed)
            :filter(function(p) return not vim.tbl_contains(installed, p) end)
            :totable()
         if #to_install > 0 then
            require("nvim-treesitter").install(to_install)
         end

         vim.api.nvim_create_autocmd("FileType", {
            callback = function()
               pcall(vim.treesitter.start)
            end,
         })
      end,
   },
   {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = function()
         require("nvim-autopairs").setup()
         local cmp_autopairs = require("nvim-autopairs.completion.cmp")
         require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end,
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
