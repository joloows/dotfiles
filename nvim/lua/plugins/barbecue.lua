-- triggers CursorHold event faster
vim.opt.updatetime = 200

require("barbecue").setup({
	create_autocmd = false,
})

vim.api.nvim_create_autocmd({
	"WinScrolled", -- or WinResized on NVIM-v0.9 and higher
	"BufWinEnter",
	"CursorHold",
	"InsertLeave",

	-- include this if you have set `show_modified` to `true`
	"BufModifiedSet",
}, {
	group = vim.api.nvim_create_augroup("barbecue.updater", {}),
	callback = function()
		require("barbecue.ui").update()
	end,
})

require("barbecue").setup({
	attach_navic = false, -- prevent barbecue from automatically attaching nvim-navic
})

local function commons(client, bufnr)
	-- and more callbacks above.

	if client.server_capabilities.documentSymbolProvider then -- this guard prevents the error.
		require("nvim-navic").attach(client, bufnr)
	end

	-- and more callbacks below.
end
