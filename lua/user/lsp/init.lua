local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "user.lsp.mason"
require ("user.lsp.handlers").setup()
require "user.lsp.null-ls"
require "user.lsp.mason-null-ls"

-- cmp_nvim_lsp.update_capabilities is deprecated, use cmp_nvim_lsp.default_capabilities instead. See :h deprecated
-- This function will be removed in cmp-nvim-lsp version 1.0.0
