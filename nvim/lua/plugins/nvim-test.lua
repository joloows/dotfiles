require("nvim-test").setup()

require("nvim-test.runners.pytest"):setup({
	args = { "-v" },
})
