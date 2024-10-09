return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	config = function()
		require("ibl").setup({
			indent = {
				char = "¦",
			},
			scope = {
				enabled = false,
			},
			exclude = {
				filetypes = {
					"help",
					"git",
					"markdown",
					"text",
					"terminal",
					"lspinfo",
					"packer",
				},
				buftypes = {
					"terminal",
					"nofile",
				},
			},
		})
	end,
}
