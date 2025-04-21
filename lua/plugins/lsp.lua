return {
	{
		"williamboman/mason.nvim",
		event = { "BufRead", "BufNewFile" },
		opts = { ui = { border = "rounded" } },
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "mason.nvim" },
		opts = {
			ensure_installed = {
				"lua_ls",
				"vimls",
			},
			automatic_installation = { exclude = { "rust_analyzer" } },
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason.nvim" },
		opts = function()
			--- @param input_table table Tabella di input { key = {"a", "b"}, ... }
			--- @return string[] flattened tabella list-like con valori univoci {"a", "b", ...}
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
	{
		"folke/lazydev.nvim",
		event = { "BufRead", "BufNewFile" },
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
	-- { "folke/neoconf.nvim", config = true },
	{ "neovim/nvim-lspconfig", enable = false },
}
