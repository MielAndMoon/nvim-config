return {
	"f4z3r/gruvbox-material.nvim",
	name = "gruvbox-material",
	lazy = false,
	priority = 1000,
	config = function()
		require("gruvbox-material").setup({
			italics = true, -- enable italics in general
			contrast = "medium", -- set contrast, can be any of "hard", "medium", "soft"
			comments = {
				italics = true, -- enable italic comments
			},
			background = {
				transparent = true, -- set the background to transparent
			},
			float = {
				force_background = false, -- force background on floats even when background.transparent is set
				background_color = nil, -- set color for float backgrounds. If nil, uses the default color set
				-- by the color scheme
			},
			signs = {
				highlight = true, -- whether to highlight signs
			},
			customize = nil, -- customize the theme in any way you desire, see below what this
			-- configuration accepts
		})
	end,
	--
	-- "rebelot/kanagawa.nvim",
	-- priority = 1000, -- Ensure it loads first
	-- config = function()
	-- 	-- Default options:
	-- 	require("kanagawa").setup({
	-- 		transparent = true, -- do not set background color
	-- 		terminalColors = true, -- define vim.g.terminal_color_{0,17}
	-- 		theme = "wave", -- Load "wave" theme when 'background' option is not set
	-- 		background = { -- map the value of 'background' option to a theme
	-- 			dark = "wave", -- try "dragon" !
	-- 			light = "lotus",
	-- 		},
	-- 	})
	--
	-- 	vim.cmd("colorscheme kanagawa")
	-- end,
}
