return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      -- javascript = { "prettier" },
      -- typescript = { "prettier" },
      -- javascriptreact = { "prettier" },
      -- typescriptreact = { "prettier" },
      -- svelte = { "prettier" },
      -- css = { "prettier" },
      -- html = { "prettier" },
      -- json = { "prettier" },
      -- yaml = { "prettier" },
      -- markdown = { "prettier" },
      -- graphql = { "prettier" },
      lua = { "stylua" },
      -- python = { "isort", "black" },
    },
    format_on_save = {
      lsp_fallback = true,
      async = false,
      timeout_ms = 500,
    },
  },
  init = function()
    --[[ vim.api.nvim_create_user_command("Conform", function(args)
			local opts = {
				lsp_fallback = true,
				async = true,
				timeout_ms = 500,
			}

			-- Sovrascrivi le opzioni predefinite se vengono forniti argomenti
			if args.fargs then
				local ok, parsed_opts = load("return " .. args.fargs)
				if ok and type(parsed_opts) == "table" then
					opts = parsed_opts
				end
			end
			vim.api.nvim_echo({ { "Conform options: " .. vim.inspect(opts), "Normal" } }, true, {})

			local conform = require("conform").format(opts)
		end, { nargs = "?", desc = "Format current buffer with Conform" }) ]]
  end,
}
