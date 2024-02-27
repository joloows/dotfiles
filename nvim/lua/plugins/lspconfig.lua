require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"pyright",
		"tsserver",
		"intelephense",
		"marksman",
		"cssls",
		"jsonls",
		"jdtls",
		"taplo",
		"yamlls",
		"prismals",
		"cssmodules_ls",
	},
})

local signs = {
	Error = "",
	Warn = "",
	Hint = "",
	Info = "",
}

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "<space>K", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "<space>f", vim.lsp.buf.formatting, bufopts)
	vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<space>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})

local lsp = require("lspconfig")
local coq = require("coq")
local servers = {
	"lua_ls",
	"pyright",
	"tsserver",
	"intelephense",
	"marksman",
	"cssls",
	"jsonls",
	"jdtls",
	"taplo",
	"yamlls",
	"prismals",
	"cssmodules_ls",
	"emmet_language_server",
}

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true

-- lsp.emmet_ls.setup({
--     on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	filetypes = {
-- 		"css",
-- 		"eruby",
-- 		"html",
-- 		"javascriptreact",
-- 		"less",
-- 		"sass",
-- 		"scss",
-- 		"svelte",
-- 		"pug",
-- 		"typescriptreact",
-- 		"vue",
-- 	},
-- })

for _, l in pairs(servers) do
	lsp[l].setup(coq.lsp_ensure_capabilities({
		on_attach = on_attach,
	}))
end

lsp.pyright.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "off",
			},
		},
	},
})

lsp.emmet_language_server.setup({
	filetypes = {
		"css",
		"eruby",
		"html",
		"javascript",
		"javascriptreact",
		"less",
		"sass",
		"scss",
		"pug",
		"typescriptreact",
	},
	-- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
	-- **Note:** only the options listed in the table are supported.
	init_options = {
		--- @type string[]
		excludeLanguages = {},
		--- @type string[]
		extensionsPath = {},
		--- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
		preferences = {},
		--- @type boolean Defaults to `true`
		showAbbreviationSuggestions = true,
		--- @type "always" | "never" Defaults to `"always"`
		showExpandedAbbreviation = "always",
		--- @type boolean Defaults to `false`
		showSuggestionsAsSnippets = false,
		--- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
		syntaxProfiles = {},
		--- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
		variables = {},
	},
})

-- lsp.lua_ls.setup({
-- 	on_attach = on_attach,
-- })
-- lsp.tsserver.setup({
-- 	on_attach = on_attach,
-- })
-- lsp.intelephense.setup({
-- 	on_attach = on_attach,
-- })
-- lsp.marksman.setup({
-- 	on_attach = on_attach,
-- })
-- lsp.cssls.setup({
-- 	on_attach = on_attach,
-- })
-- lsp.jsonls.setup({
-- 	on_attach = on_attach,
-- })
-- lsp.jdtls.setup({
-- 	on_attach = on_attach,
-- })
-- lsp.taplo.setup({
-- 	on_attach = on_attach,
-- })
-- lsp.yamlls.setup({
-- 	on_attach = on_attach,
-- })
