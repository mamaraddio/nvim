local Utils = {}

---Execute vim.cmd commands in pure lua. Intended for use with which-key as RHS
---@param command function
---@param args? string|table|nil
---@return function
function Utils.luacmd(command, args)
	if not args then
		return command
	else
		return function() command(args) end
	end
end

vim.diagnostic.refresh = function() return vim.diagnostic.is_enabled() and vim.diagnostic.show() end

return Utils
