return {
	"neovim/nvim-lspconfig",
	event = "VeryLazy",
	config = function()
		local lspconfig = require("lspconfig")
		require("lspconfig.ui.windows").default_options.border = "rounded"

		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local servers = {
			bashls = true,
            prismals = true,
			lua_ls = true,
			cssls = {
				server_capabilities = {
					documentFormattingProvider = false,
				},
			},
            biome = true,
			-- vtsls = {
			-- 	server_capabilities = {
			-- 		documentFormattingProvider = false,
			-- 	},
			-- 	settings = {
			-- 		typescript = {
			-- 			inlayHints = {
			-- 				parameterNames = { enabled = "all" },
			-- 				parameterTypes = { enabled = true },
			-- 				variableTypes = { enabled = true },
			-- 				propertyDeclarationTypes = { enabled = true },
			-- 				functionLikeReturnTypes = { enabled = true },
			-- 				enumMemberValues = { enabled = true },
			-- 			},
			-- 		},
			-- 	},
			-- },
			--pyright = true,
			basedpyright = {
				settings = {
					basedpyright = {
						analysis = {
							autoSearchPaths = true,
							diagnosticMode = "openFilesOnly",
							useLibraryCodeForTypes = true,
						},
					},
				},
			},
			tailwindcss = true,
			emmet_ls = {
				settings = {
					filetypes = {
						"html",
						"typescriptreact",
						"javascriptreact",
						"css",
						"sass",
						"scss",
						"less",
						"htmldjango",
					},
					init_options = {
						html = {
							options = {
								["bem.enabled"] = true,
							},
						},
					},
				},
			},

			ts_ls = {
				server_capabilities = {
					documentFormattingProvider = true,
				},
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayVariableTypeHintsWhenTypeMatchesName = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayVariableTypeHintsWhenTypeMatchesName = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
				},
			},
			jsonls = {
				server_capabilities = {
					documentFormattingProvider = false,
				},
				settings = {
					json = {
						validate = { enable = true },
					},
				},
			},

			yamlls = {
				settings = {
					yaml = {
						schemaStore = {
							enable = false,
							url = "",
						},
					},
				},
			},
		}

		local servers_to_install = vim.tbl_filter(function(key)
			local t = servers[key]
			if type(t) == "table" then
				return not t.manual_install
			else
				return t
			end
		end, vim.tbl_keys(servers))

		require("mason-lspconfig").setup({
			ensure_installed = servers_to_install,
			automatic_installation = true,
		})

		for name, config in pairs(servers) do
			if config == true then
				config = {}
			end
			config = vim.tbl_deep_extend("force", {}, {
				capabilities = capabilities,
			}, config)

			lspconfig[name].setup(config)
		end

		--
		-- local function setup_lsp(lsp)
		--     lspconfig[lsp].setup({
		--         capabilities = capabilities,
		--     })
		-- end
		-- -- Setup lspconfig
		--
		-- setup_lsp("lua_ls")
		-- setup_lsp("cssls")
		-- setup_lsp("cssmodules_ls")
		-- setup_lsp("pyright")
		-- setup_lsp("tsserver")
		-- setup_lsp("dockerls")
		-- setup_lsp("docker_compose_language_service")
		--
		-- lspconfig.bashls.setup({
		--     capabilities = capabilities,
		--     filetypes = {
		--         "sh",
		--         "zsh",
		--         "bash",
		--     },
		-- })
		--
		-- lspconfig.emmet_ls.setup({
		--     capabilities = capabilities,
		--     filetypes = {
		--         "html",
		--         "typescriptreact",
		--         "javascriptreact",
		--         "css",
		--         "sass",
		--         "scss",
		--         "less",
		--         "htmldjango",
		--     },
		--     init_options = {
		--         html = {
		--             options = {
		--                 ["bem.enabled"] = true,
		--             },
		--         },
		--     },
		-- })
		--
		-- lspconfig.html.setup({
		--     capabilities = capabilities,
		--     filetypes = { "html", "htmldjango" },
		-- })
		--
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local bufnr = args.buf
				local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

				local settings = servers[client.name]
				if type(settings) ~= "table" then
					settings = {}
				end

				local builtin = require("telescope.builtin")

				vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
				vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0 })
				vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = 0 })
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
				vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
				vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
				vim.keymap.set("n", "<space>fb", function()
					vim.lsp.buf.format({ async = true })
				end, { buffer = 0 })

				if settings.server_capabilities then
					for k, v in pairs(settings.server_capabilities) do
						if v == vim.NIL then
							---@diagnostic disable-next-line: cast-local-type
							v = nil
						end

						client.server_capabilities[k] = v
					end
				end
			end,
		})

		-- Setup luasnip
		require("luasnip/loaders/from_vscode").load()
	end,
}
