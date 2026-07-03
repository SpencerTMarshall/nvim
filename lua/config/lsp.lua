vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gd", function()
      vim.cmd("vsplit")
      vim.lsp.buf.definition()
    end, opts)
    vim.keymap.set("n", "K",          vim.lsp.buf.hover,       opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,      opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr",         vim.lsp.buf.references,  opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  end,
})

require("mason").setup()
require("mason-lspconfig").setup({
	automatic_installation = true,
	handlers = {
		function(server_name)
			require("lspconfig")[server_name].setup({
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			})
		end,
	},
})

local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
	snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"]     = cmp.mapping.abort(),
		["<CR>"]      = cmp.mapping.confirm({ select = true }),
		["<Tab>"]     = cmp.mapping(function(fallback)
			if cmp.visible() then cmp.select_next_item() else fallback() end
		end, { "i", "s" }),
		["<S-Tab>"]   = cmp.mapping(function(fallback)
			if cmp.visible() then cmp.select_prev_item() else fallback() end
		end, { "i", "s" }),
	}),
	sources = cmp.config.sources(
		{ { name = "nvim_lsp" }, { name = "luasnip" } },
		{ { name = "buffer" } }
	),
})
