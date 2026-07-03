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

vim.cmd("set shiftwidth=3")
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")

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
