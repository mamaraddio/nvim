local servers = {
  "lua_ls",
  "vimls",
}
local function generate_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  -- local require_ok, blink_cmp = pcall(require, "blink_cmp")
  -- if require_ok then
  --   capabilities = blink_cmp.get_lsp_capabilities(capabilities)
  -- end
  return capabilities
end

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "folke/neodev.nvim",
    {
      "williamboman/mason-lspconfig.nvim",
      opts = {
        ensure_installed = servers,
      },
      dependencies = {
        "mason.nvim",
        opts = {
          ui = {
            border = "rounded"
          },
        },
      },
    },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local icons = require("config.icons").diagnostics

    vim.diagnostic.config({
      signs = {
        active = true,
        values = {
          { name = "DiagnosticSignError", text = icons.Error },
          { name = "DiagnosticSignWarn",  text = icons.Warning },
          { name = "DiagnosticSignHint",  text = icons.Hint },
          { name = "DiagnosticSignInfo",  text = icons.Information },
        },
      },
      virtual_text = false,
      update_in_insert = false,
      underline = true,
      severity_sort = true,
      float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })

    for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
      vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
    end

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
    require("lspconfig.ui.windows").default_options.border = "rounded"

    for _, server in pairs(servers) do
      local opts = {
        on_attach = function(client, bufnr)
          local keymap_opt = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, keymap_opt)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, keymap_opt)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, keymap_opt)
          vim.keymap.set("n", "gI", vim.lsp.buf.implementation, keymap_opt)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, keymap_opt)
          vim.keymap.set("n", "gl", vim.diagnostic.open_float, keymap_opt)
          vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, keymap_opt)

          if client.supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr })
          end
        end,
        capabilities = generate_capabilities()
      }

      local require_ok, settings = pcall(require, "lspsettings." .. server)
      if require_ok then opts = vim.tbl_deep_extend("force", settings, opts) end

      if server == "lua_ls" then require("neodev").setup() end

      lspconfig[server].setup(opts)
    end
  end,
}

-- local function toggle_hints()
--   local bufnr = vim.api.nvim_get_current_buf()
--   local hint = vim.lsp.inlay_hint
--   hint.enable(not hint.is_enabled { bufnr }, { bufnr })
-- end

-- local wk = require "which-key"
-- wk.add {
--   { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
--   {
--     "<leader>lf",
--     "<cmd>lua vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= 'typescript-tools' end})<cr>",
--     desc = "Format",
--   },
--   { "<leader>lh", "<cmd>lua require('config.lspconfig').toggle_inlay_hints()<cr>", desc = "Hints" },
--   { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info" },
--   { "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Next Diagnostic" },
--   { "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic" },
--   { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action" },
--   { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Quickfix" },
--   { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
-- }
--
-- wk.add {
--   { "<leader>la", group = "LSP" },
--   { "<leader>laa", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action", mode = "v" },
-- }
