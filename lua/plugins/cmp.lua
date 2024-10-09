return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"saadparwaiz1/cmp_luasnip",
		"onsails/lspkind.nvim",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-git",
	},
	config = function()
		local cmp = require("cmp")
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")

		--local servers = { "lua_ls", "tsserver", "pyright", "html", "cssls", "emmet_ls", "cssmodules_ls" }
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

		-- Setup cmp
		local lspkind = require("lspkind")

		lspkind.init()

		local function border(hl_name)
			return {
				{ "╭", hl_name },
				{ "─", hl_name },
				{ "╮", hl_name },
				{ "│", hl_name },
				{ "╯", hl_name },
				{ "─", hl_name },
				{ "╰", hl_name },
				{ "│", hl_name },
			}
		end

		local cmp_window = require("cmp.utils.window")

		cmp_window.info_ = cmp_window.info
		cmp_window.info = function(self)
			local info = self:info_()
			info.scrollable = false
			return info
		end

		cmp.setup({
			mapping = {
				["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-e>"] = cmp.mapping.abort(),
				["<c-j>"] = cmp.mapping(
					cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
						select = true,
					}),
					{ "i", "c" }
				),
				["<c-space>"] = cmp.mapping({
					i = cmp.mapping.complete(),
					c = function(
						_ --[[fallback]]
					)
						if cmp.visible() then
							if not cmp.confirm({ select = true }) then
								return
							end
						else
							cmp.complete()
						end
					end,
				}),
			},

			sources = {
				--{ name = "supermaven" },
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path" },
				{ name = "buffer" },
			},

			sorting = {
				priority_weight = 2,
				comparators = {
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.score,
					cmp.config.compare.kind,
					cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
			},

			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},

			formatting = {
				format = lspkind.cmp_format({
					with_text = true,
					menu = {
						buffer = "[buf]",
						nvim_lsp = "[lsp]",
						path = "[path]",
						luasnip = "[snip]",
						--supermaven = "[sm]",
					},
				}),
			},

			experimental = {
				ghost_text = true,
				native_menu = false,
			},

			window = {
				documentation = {
					border = border("CmpBorderColor"),
					winhighlight = "Normal:CmpNormalColor",
				},
				completion = {
					border = border("CmpBorderColor"),
					--winhighlight = "Normal:None,FloatBorder:MyColors,kaly:PmenuSel,Search:None",
					winhighlight = "Normal:CmpNormalColor,CursorLine:PmenuSel,Search:None",
				},
			},
		})

		-- cmp.setup.filetype("gitcommit", {
		--     sources = cmp.config.sources({
		--         { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
		--     }, {
		--         { name = "buffer" },
		--     }),
		-- })
		--
		-- -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
		-- cmp.setup.cmdline({ "/", "?" }, {
		--     mapping = cmp.mapping.preset.cmdline(),
		--     sources = {
		--         { name = "buffer" },
		--         { name = "buffer-lines" }
		--     },
		-- })
		--
		-- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		-- cmp.setup.cmdline(":", {
		--     mapping = cmp.mapping.preset.cmdline(),
		--     sources = cmp.config.sources({
		--         { name = "path" },
		--     }, {
		--         { name = "cmdline" },
		--     }),
		-- })
	end,
}
