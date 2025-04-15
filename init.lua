---Execute vim.cmd commands in pure lua. Intended for use with which-key as RHS
---@param command function
---@param args? string|table
---@return function
_G.luacmd = function(command, args)
	return function()
		command(args)
	end
end

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")
