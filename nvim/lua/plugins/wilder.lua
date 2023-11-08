local wilder = require("wilder")
wilder.setup({ modes = { ":", "/", "?" } })
wilder.set_option("pipeline", {
	wilder.branch(wilder.cmdline_pipeline(), wilder.vim_search_pipeline()),
})

wilder.set_option(
	"renderer",
	wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
		highlighter = wilder.basic_highlighter(),
		highlights = {
			accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "#7bd88f" } }),
			border = "Normal",
		},
		border = "single",
		reverse = 1,
		max_height = "25%",
	}))
)
