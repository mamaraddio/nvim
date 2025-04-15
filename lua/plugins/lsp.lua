local servers = {
	"lua_ls",
	"vimls",
}
local function generate_capabilities()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	local require_ok, blink_cmp = pcall(require, "blink_cmp")
	if require_ok then
		capabilities = blink_cmp.get_lsp_capabilities(capabilities)
	end
	return capabilities
end

return {
	{
		"williamboman/mason.nvim",
		event = { "BufRead", "BufNewFile" },
		dependencies = {
			{
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				init = function()
					vim.api.nvim_create_autocmd("User", {
						pattern = "MasonToolsStartingInstall",
						callback = function()
							vim.schedule(function()
								print("mason-tool-installer is starting")
							end)
						end,
					})
					vim.api.nvim_create_autocmd("User", {
						pattern = "MasonToolsUpdateCompleted",
						callback = function(e)
							vim.schedule(function()
								print(vim.inspect(e.data)) -- print the table that lists the programs that were installed
							end)
						end,
					})
				end,
				opts = function()
					--- Estrae valori stringa univoci da una tabella di tabelle.
					--- Versione leggermente più concisa.
					--- @param input_table table Tabella di input { key = {"a", "b"}, ... }
					--- @return table Flattened tabella list-like con valori univoci {"a", "b", ...}
					local function flatten_valuer(input_table)
						local seen = {}
						local unique_list = {}
						local index = 0 -- Usiamo un indice separato per l'inserimento

						for _, inner_table in pairs(input_table or {}) do -- Usa or {} per gestire nil input
							if type(inner_table) == "table" then
								for _, value_string in ipairs(inner_table) do
									-- Combina controllo e azione
									if seen[value_string] == nil then -- Verifica esplicita con nil
										seen[value_string] = true -- Marca come visto
										index = index + 1
										unique_list[index] = value_string -- Inserimento diretto tramite indice
									end
								end
							end
						end

						return unique_list
					end

					local list = vim.list_extend(
						flatten_valuer(require("lint").linters_by_ft),
						flatten_valuer(require("conform").formatters_by_ft)
					)
					-- vim.notify(vim.inspect(list), vim.log.levels.INFO)

					return {
						ensure_installed = list,
						auto_update = true,
					}
				end,
			},
		},
		opts = { ui = { border = "rounded" } },
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "mason.nvim" },
		opts = { ensure_installed = servers, automatic_installation = { exclude = { "rust_analyzer" } } },
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			--- See the configuration section for more details
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } }, -- Load luvit types when the `vim.uv` word is found
				vim.api.nvim_get_runtime_file("", true),
			},
		},
		config = true,
	},
	{ "folke/neoconf.nvim", config = true },
	{
		"neovim/nvim-lspconfig",
		dependencies = "folke/neoconf.nvim",
		event = { "BufReadPost", "BufNewFile" },
		init = function()
			local wk = require("which-key")
			wk.add({
				{ "<leader>l", group = "LSP" },
				{ "<leader>la", vim.lsp.buf.code_action, desc = "Code Action" },
				{
					"<leader>lf",
					luacmd(require("conform").format, {
						lsp_fallback = true,
						async = true,
						timeout_ms = 500,
					}),
					desc = "Format file or range (in visual mode)",
				}, --[[ filter = function(client) return client.name ~= 'typescript-tools' end ]]
				{ "<leader>li", vim.cmd.LspInfo, desc = "LSP Info" },
				{ "<leader>lj", luacmd(vim.diagnostic.jump, { count = 1, float = true }), desc = "Next Diagnostic" },
				{ "<leader>lk", luacmd(vim.diagnostic.jump, { count = -1, float = true }), desc = "Prev Diagnostic" },
				{ "<leader>ll", vim.lsp.codelens.run, desc = "CodeLens Action" },
				{ "<leader>lq", vim.diagnostic.setloclist, desc = "Quickfix" },
				{ "<leader>lr", vim.lsp.buf.rename, desc = "Rename" },
			})
		end,
		config = function()
			local lspconfig = require("lspconfig")
			local icons = require("config.icons").diagnostics

			vim.diagnostic.config({
				signs = {
					active = true,
					text = {
						[vim.diagnostic.severity.ERROR] = icons.Error,
						[vim.diagnostic.severity.WARN] = icons.Warning,
						[vim.diagnostic.severity.INFO] = icons.Hint,
						[vim.diagnostic.severity.HINT] = icons.Information,
					},
				},
				update_in_insert = true,
				underline = true,
				severity_sort = true,
				float = {
					focusable = true,
					style = "minimal",
					border = "rounded",
					---@type string
					source = "always",
					header = "",
					prefix = "",
				},
			})

			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.buf.signature_help({ border = "rounded" })
			require("lspconfig.ui.windows").default_options.border = "rounded"

			for _, server in pairs(servers) do
				local opts = {
					on_attach = function(client, bufnr)
						local wk = require("which-key")
						local options = { noremap = true, silent = true, buffer = bufnr }
						-- wk.add({ "gd", vim.lsp.buf.definition, desc = "Goto Definition", options })
						wk.add({ "gD", vim.lsp.buf.declaration, desc = "Goto Declaration", options })
						wk.add({
							"K",
							luacmd(vim.lsp.buf.hover, { border = "rounded" }),
							desc = "Hover Definition",
							options,
						})
						wk.add({ "gI", vim.lsp.buf.implementation, desc = "Goto Implementation", options })
						wk.add({ "gr", vim.lsp.buf.references, desc = "Goto References", options })
						wk.add({ "gl", vim.diagnostic.open_float, desc = "Diagnostic Float", options })

						if client.supports_method("textDocument/inlayHint") then
							vim.lsp.inlay_hint.enable(true, { bufnr })
						end
					end,
					capabilities = generate_capabilities(),
				}

				local require_ok, settings = pcall(require, "lspsettings." .. server)
				if require_ok then
					opts = vim.tbl_deep_extend("force", settings, opts)
				end

				-- lspconfig[server].setup(opts)
				vim.lsp.enable({ "lua_ls", "vimls" })
			end
		end,
	},
}
