local configs = require("nvim-treesitter.configs")
configs.setup {
	ensure_installed = { "bash", "c", "cmake", "comment", "cpp", "css", "dockerfile", "fish", "help", "hjson", "html", "http", "java", "javascript", "jsdoc", "lua", "make",
						"markdown", "python", "regex", "rust", "tsx", "typescript", "vim", "yaml"},
	sync_install = false,
	ignore_install = { "" }, -- List of parsers to ignore installing
	autopairs = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "" }, -- list of language that will be disabled
		additional_vim_regex_hignlighting = true,
	},
	incremental_selection = {
		enable = true,
		disable = {},
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
	indent = {
		enable = true,
		disable = { "yaml", "python", "css" }
	},
	rainbow = {
	enable = true,
	-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
	extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
	max_file_lines = nil, -- Do not enable for files with more than n lines, int
	-- colors = {}, -- table of hex strings
	-- termcolors = {} -- table of colour name strings
	},
	context_commentstring = {
		enable = true,
		disable = { "lua" },
		enable_autocmd = false,
	},
}
