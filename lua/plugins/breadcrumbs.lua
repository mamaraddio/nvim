local icons = require "config.icons"
return {
  "LunarVim/breadcrumbs.nvim",
  event = "BufReadPost",
  dependencies = {
    {
      "SmiteshP/nvim-navic",
      opts = {
        icons = icons.kind,
        highlight = true,
        lsp = {
          auto_attach = true,
        },
        click = true,
        separator = " " .. icons.ui.ChevronRight .. " ",
        depth_limit = 4,
        depth_limit_indicator = "..",
      }
    },
  },
  config = true,
}
