local t = { "n", "<leader>ll", "luacmd(vim.lsp.codelens.run)", desc = "CodeLens Action", buffer = 0, noremap = true }

--[[ for i, e in ipairs(t) do
	print(type(e))
end ]]
for k, v in pairs(t) do
	print(k .. ": " .. tostring(v))
end

--[[ local mode = table.remove(t, 1)
local key = table.remove(t, 1)
local cmd = table.remove(t, 1)

print("Mode: " .. mode)
print("Key: " .. key)
print("Command: " .. cmd)
for k, v in pairs(t) do
	print(k .. ": " .. tostring(v) .. "\n")
end
-- print("Options: " .. opts) ]]
