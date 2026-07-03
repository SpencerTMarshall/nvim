vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)

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
