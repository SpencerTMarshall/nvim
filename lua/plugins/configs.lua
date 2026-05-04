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
   {
      "goerz/jupytext.nvim",
      version = "0.2.0",
      opts = {}
   },
   {
      "matarina/pyrola.nvim",
      config = function()
         local pyrola = require("pyrola")

         pyrola.setup({
            kernel_map = {
              python = "py3", -- Jupyter kernel name
              r = "ir",
            },
            split_horizontal = false,
            split_ratio = 0.65, -- width of split REPL terminal
            image = {
              cell_width = 10, -- approximate terminal cell width in pixels
              cell_height = 20, -- approximate terminal cell height in pixels
              max_width_ratio = 0.5, -- image width as a fraction of editor columns
              max_height_ratio = 0.5, -- image height as a fraction of editor lines
              offset_row = 0, -- adjust image row position (cells)
              offset_col = 0, -- adjust image col position (cells)
            },
         })

         -- Send semantic code block under cursor
         vim.keymap.set("n", "<CR>", function()
            pyrola.send_statement_definition()
         end, { noremap = true })

         -- Send visual selection
         vim.keymap.set("v", "<leader>vs", function()
            pyrola.send_visual_to_repl()
         end, { noremap = true })

         -- Send entire buffer
         vim.keymap.set("n", "<leader>vb", function()
            pyrola.send_buffer_to_repl()
         end, { noremap = true })

         -- Open history image viewer
         vim.keymap.set("n", "<leader>im", function()
            pyrola.open_history_manager()
         end, { noremap = true })
      end
   }
}
