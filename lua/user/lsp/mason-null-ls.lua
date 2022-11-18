
local ok, mason_null_ls = pcall(require, "mason-null-ls")
if not ok then
  return
end

mason_null_ls.setup({
    automatic_setup = true,
})
