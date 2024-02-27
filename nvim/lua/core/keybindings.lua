local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- save file
vim.keymap.set({ "i", "n" }, "<C-s>", "<cmd>w<cr>", { desc = "Save file" })

-- quit all
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- save and quit all
map("n", "<leader>wqq", "<cmd>wqa<cr>", { desc = "Save and quit all" })

-- NeoColumn
map("n", "<leader>h", "<cmd>ToggleNeoColumn<cr>", opts)

-- Barbar
-- Move to previous/next
map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)
-- Re-order to previous/next
map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)
-- Goto buffer in position...
map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
map("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)
-- Pin/unpin buffer
map("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)
-- Close buffer
map("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
map("n", "<C-p>", "<Cmd>BufferPick<CR>", opts)
-- Sort automatically by...
map("n", "<Space>bb", "<Cmd>BufferOrderByBufferNumber<CR>", opts)
map("n", "<Space>bd", "<Cmd>BufferOrderByDirectory<CR>", opts)
map("n", "<Space>bl", "<Cmd>BufferOrderByLanguage<CR>", opts)
map("n", "<Space>bw", "<Cmd>BufferOrderByWindowNumber<CR>", opts)

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used

-- nvim-autopairs
local npairs = require("nvim-autopairs")

-- npairs.setup({ map_bs = false, map_cr = false })

vim.g.coq_settings = { keymap = { recommended = false } }

-- these mappings are coq recommended mappings unrelated to nvim-autopairs
map("i", "<esc>", [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
map("i", "<c-c>", [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
map("i", "<tab>", [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
map("i", "<s-tab>", [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })

_G.MUtils = {}

MUtils.CR = function()
	if vim.fn.pumvisible() ~= 0 then
		if vim.fn.complete_info({ "selected" }).selected ~= -1 then
			return npairs.esc("<c-y>")
		else
			return npairs.esc("<c-e>") .. npairs.autopairs_cr()
		end
	else
		return npairs.autopairs_cr()
	end
end
map("i", "<cr>", "v:lua.MUtils.CR()", { expr = true, noremap = true })

MUtils.BS = function()
	if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ "mode" }).mode == "eval" then
		return npairs.esc("<c-e>") .. npairs.autopairs_bs()
	else
		return npairs.autopairs_bs()
	end
end
map("i", "<bs>", "v:lua.MUtils.BS()", { expr = true, noremap = true })

-- Formatter
map("n", "<leader>f", ":Format<CR>", { noremap = true, silent = true })
map("n", "<leader>F", ":FormatWrite<CR>", { noremap = true, silent = true })

vim.cmd([[
    augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost * FormatWrite
    augroup END
]])

-- nvim-dap
vim.keymap.set("n", "<leader>sd", function()
	require("dap").continue()
end)
vim.keymap.set("n", "<F10>", function()
	require("dap").step_over()
end)
vim.keymap.set("n", "<F11>", function()
	require("dap").step_into()
end)
vim.keymap.set("n", "<F12>", function()
	require("dap").step_out()
end)
vim.keymap.set("n", "<Leader>b", function()
	require("dap").toggle_breakpoint()
end)
vim.keymap.set("n", "<Leader>B", function()
	require("dap").set_breakpoint()
end)
vim.keymap.set("n", "<Leader>lp", function()
	require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end)
vim.keymap.set("n", "<Leader>dr", function()
	require("dap").repl.open()
end)
vim.keymap.set("n", "<Leader>dl", function()
	require("dap").run_last()
end)
map("n", "<leader>dt", ":lua require('dapui').toggle()<CR>", opts)
map("n", "<leader>dn", ":lua require('dap-python').test_method()<CR>", opts)
map("n", "<leader>df", ":lua require('dap-python').test_class()<CR>", opts)
map("n", "<leader>ds", ":lua require('dap-python').debug_selection()<CR>", opts)
map("n", "<leader>dh", ":lua require('dap-python').run_test_for_method()<CR>", opts)

-- Trouble.nvim diagnostics
local trouble = require("trouble")
vim.keymap.set("n", "<leader>xx", function()
	trouble.toggle()
end)
vim.keymap.set("n", "<leader>xw", function()
	trouble.toggle("workspace_diagnostics")
end)
vim.keymap.set("n", "<leader>xd", function()
	trouble.toggle("document_diagnostics")
end)
vim.keymap.set("n", "<leader>xq", function()
	trouble.toggle("quickfix")
end)
vim.keymap.set("n", "<leader>xl", function()
	trouble.toggle("loclist")
end)
vim.keymap.set("n", "gR", function()
	trouble.toggle("lsp_references")
end)

-- nvim-tmux-navigation
local nvim_tmux_nav = require("nvim-tmux-navigation")
vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
