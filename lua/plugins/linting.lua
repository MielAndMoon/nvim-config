return {
	"mfussenegger/nvim-lint",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		local lint = require("lint")

		lint.linter_by_ft = {
			javascript = {
				"biome",
			},
			typescript = {
				"biome",
			},
			javascriptreact = {
				"biome",
			},
			lua = {
				"selene",
			},
			python = {
				"flake8",
			},
			json = {
				"jsonlint",
			},
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", {
			clear = true,
		})

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<Leader>l", function()
			lint.try_lint()
		end, { desc = "Trigger linting the current file" })
	end,
}
