require("config.lazy")

vim.g.mapleader = " "
vim.opt.relativenumber = true

-- Tabs
vim.keymap.set('n', '<leader>r', 'gt')
vim.keymap.set('n', '<leader>f', function()
    return vim.cmd('tabnew')
end)

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>o", builtin.find_files)
vim.keymap.set("n", "<leader>p", builtin.live_grep)

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

vim.keymap.set("n", "]z", "zj")
vim.keymap.set("n", "[z", function()
  local cur = vim.fn.line(".")
  for lnum = cur - 1, 1, -1 do
    local this_level = vim.fn.foldlevel(lnum)
    local prev_level = lnum > 1 and vim.fn.foldlevel(lnum - 1) or 0
    if this_level > prev_level and this_level > 0 then
      vim.fn.cursor(lnum, 1)
      return
    end
  end
end)

vim.cmd("set shiftwidth=3")
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local path = vim.fn.expand("%:p:h")
    local root = vim.fs.root(path, ".git")
    if root then
      vim.cmd("cd " .. vim.fn.fnameescape(root))
    end
  end,
})

local lsp_storage_dir = vim.fn.stdpath("data") .. "/lsp-storage"
vim.fn.mkdir(lsp_storage_dir, "p")

local function with_lspstorage(config)
	local storage_env = {
		TMPDIR = lsp_storage_dir,
		TEMP = lsp_storage_dir,
		TMP = lsp_storage_dir,
		XDG_CACHE_HOME = lsp_storage_dir,
	}
	
	return vim.tbl_deep_extend("force", {
		cmd_env = storage_env,
	}, config or {})
end
