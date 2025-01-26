return {
	"echasnovski/mini.nvim",
	version = false,
	lazy = false,
	priority = 900,
	specs = {
		{ "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
	},
	init = function()
		package.preload["nvim-web-devicons"] = function()
			require("mini.icons").mock_nvim_web_devicons()
			return package.loaded["nvim-web-devicons"]
		end
	end,
	config = function()
		local enabled_modules = {
			-- animate = true,
			-- cursorword = true,
			-- extra = true,
			icons = { lsp = { ["Copilot"] = "" } },
			-- indentscope = { options = { try_as_border = true } },
			files = true,
			--[[ hipatterns = {
				highlighters = {
					-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
					fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
					hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
					todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
					note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

					-- Highlight hex color strings (`#rrggbb`) using that color
					hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
				},
			}, ]]
			--[[ pairs = { modes = { insert = true, command = true } },
			surround = true, ]]
		}

		for module, opts in pairs(enabled_modules) do
			if opts == true then
				require("mini." .. module).setup()
			elseif type(opts) == "table" then
				require("mini." .. module).setup(opts)
			elseif opts == false then
				return
			else
				vim.api.nvim_err_writeln("Invalid option for mini.nvim: " .. opts)
			end
		end
	end,
}

--[[ {
      { "<leader>bb", "<cmd>Telescope buffers previewer=false<cr>",                       desc = "Find" },
      { "<leader>fb", "<cmd>Telescope git_branches<cr>",                                  desc = "Checkout branch" },
      { "<leader>fc", "<cmd>Telescope colorscheme<cr>",                                   desc = "Colorscheme" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>",                                    desc = "Find files" },
      { "<leader>fp", "<cmd>lua require('telescope').extensions.projects.projects()<cr>", desc = "Projects" },
      { "<leader>ft", "<cmd>Telescope live_grep<cr>",                                     desc = "Find Text" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>",                                     desc = "Help" },
      { "<leader>fl", "<cmd>Telescope resume<cr>",                                        desc = "Last Search" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>",                                      desc = "Recent File" },
    } ]]
