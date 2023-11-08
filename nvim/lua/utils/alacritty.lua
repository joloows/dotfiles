function Sad(line_nr, from, to, fname)
	vim.cmd(string.format("silent !sed -i '%ss/%s/%s/' %s", line_nr, from, to, fname))
end

function IncreasePadding()
	Sad("06", 0, 15, "~/.config/alacritty/alacritty.yml")
	Sad("07", 0, 10, "~/.config/alacritty/alacritty.yml")
end

function DecreasePadding()
	Sad("06", 15, 0, "~/.config/alacritty/alacritty.yml")
	Sad("07", 10, 0, "~/.config/alacritty/alacritty.yml")
end

vim.cmd([[
  augroup ChangeAlacrittyPadding
   au!
   au VimEnter * lua DecreasePadding()
   au VimLeavePre * lua IncreasePadding()
  augroup END
]])
