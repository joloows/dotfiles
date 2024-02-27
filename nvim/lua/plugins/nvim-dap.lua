require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")

table.insert(require("dap").configurations.python, {
	type = "python",
	request = "launch",
	name = "Run all tests with pytest",
	module = "pytest",
	console = "integratedTerminal",
})

table.insert(require("dap").configurations.python, {
	type = "python",
	request = "launch",
	name = "Run with input file",
	program = "${file}",
	args = { "<", "$fileDirname" .. "/input.in" },
	console = "integratedTerminal",
})

-- local function get_input_file()
-- 	input_file = vim.fn.input("Enter input file", "", "file")
-- 	return {
-- 		input_file,
-- 	}
--
-- table.insert(require("dap").configurations.python, {
-- 	type = "python",
-- 	request = "launch",
-- 	name = "My custom launch configuration",
-- 	program = "${file}",
-- 	args = { "<", "input.in" },
-- 	cwd = vim.fn.getcwd(),
-- })
