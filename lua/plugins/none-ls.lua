return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvimtools/none-ls-extras.nvim",
    {
      "jay-babu/mason-null-ls.nvim",
      opts = {
        handlers = {},
      }
    },
  },
  config = function()
    local null_ls = require("null-ls")

    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local completion = null_ls.builtins.completion

    null_ls.setup({
      debug = false,
      sources = {
        require("none-ls.formatting.beautysh"),
        -- formatting.prettier.with {
        --   extra_filetypes = { "toml" },
        --   -- extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
        -- },
        diagnostics.codespell,
        completion.spell,
      },
    })
  end,
}
