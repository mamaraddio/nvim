return {
	"numToStr/Comment.nvim",
	event = "VeryLazy",
	dependencies = {
		{
			"JoosepAlviste/nvim-ts-context-commentstring",
			event = "VeryLazy",
		},
	},
	init = function()
		local wk = require("which-key")
		wk.add({
			{ "<leader>/", "<Plug>(comment_toggle_linewise_current)", desc = "Comment" },
		})

		wk.add({
			{ "<leader>/", "<Plug>(comment_toggle_linewise_visual)", desc = "Comment", mode = "v" },
		})
		vim.g.skip_ts_context_commentstring_module = true
	end,
	config = function()
		---@diagnostic disable: missing-fields
		require("ts_context_commentstring").setup({
			enable_autocmd = false,
		})

		require("Comment").setup({
			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
		})
	end,
}
