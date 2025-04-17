local Utils = {}

---@class Utils.keymap.keymapArgs
---@field mode string|string[] The mode(s) in which the keymap should be set. Default is "n" (normal mode).
---@field lhs string The left-hand side of the keymap (the key combination to be pressed).
---@field rhs string|function The right-hand side of the keymap (the command or function to be executed).
---@field opts? vim.keymap.set.Opts Optional additional options for the keymap. Default is an empty table.

---@param args Utils.keymap.keymapArgs The arguments for setting the keymap.
---@param wk? boolean Optional flag to indicate whether to use which-key for the keymap. Default is false.
function Utils.keymap(args, wk)
	local wk = wk or false
	-- keymap.set(mode: string|string[], lhs: string, rhs: string|function, opts?: vim.keymap.set.Opts)
	local mode = args.mode or "n"
	local lhs = args.lhs
	local rhs = args.rhs
	local opts = args.opts or {}
	if not wk then
		vim.keymap.set(mode, lhs, rhs, opts)
	else
		-- require("which-key").add()
	end
end

---Execute vim.cmd commands in pure lua. Intended for use with which-key as RHS
---@param command function
---@param args? string|table|nil
---@return function
function Utils.luacmd(command, args)
	if not args then
		return command
	else
		return function()
			command(args)
		end
	end
end

return Utilsa
