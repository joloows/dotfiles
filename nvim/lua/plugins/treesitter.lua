require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"python",
		"javascript",
		"typescript",
		"json",
		"bash",
		"gitignore",
		"html",
		"java",
		"markdown",
		"php",
		"regex",
		"typescript",
		"yaml",
		"toml",
		"c",
		"lua",
		"vim",
		"vimdoc",
		"query",
	},

	auto_install = true,

	highlight = {
		enable = true,
	},

	indent = {
		enable = true,
	},
})
