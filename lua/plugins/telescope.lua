return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
    "nvim-lua/plenary.nvim",
  },
  -- lazy = true,
  cmd = "Telescope",
  opts = {
    defaults = {
      prompt_prefix = require("config.icons").ui.Telescope .. " ",
      selection_caret = require("config.icons").ui.Forward .. " ",
      entry_prefix = "   ",
      initial_mode = "insert",
      selection_strategy = "reset",
      path_display = { "smart" },
      color_devicons = true,
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob=!.git/",
      },
    },
    mappings = {
      i = {
        ["<C-n>"] = require("telescope.actions").cycle_history_next,
        ["<C-p>"] = require("telescope.actions").cycle_history_prev,

        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<C-k>"] = require("telescope.actions").move_selection_previous,
      },
      n = {
        ["<esc>"] = require("telescope.actions").close,
        ["q"] = require("telescope.actions").close,
        ["j"] = require("telescope.actions").move_selection_next,
        ["k"] = require("telescope.actions").move_selection_previous,
      },
    },
    buffers = {
      mappings = {
        i = {
          ["<C-d>"] = require("telescope.actions").delete_buffer,
        },
        n = {
          ["dd"] = require("telescope.actions").delete_buffer,
        },
      },
    },
    pickers = {
      live_grep = {
        theme = "dropdown",
      },

      grep_string = {
        theme = "dropdown",
      },

      find_files = {
        theme = "dropdown",
        previewer = false,
      },

      buffers = {
        theme = "dropdown",
        previewer = false,
        initial_mode = "normal",
      },

      planets = {
        show_pluto = true,
        show_moon = true,
      },

      colorscheme = {
        enable_preview = true,
      },

      lsp_references = {
        theme = "dropdown",
        initial_mode = "normal",
      },

      lsp_definitions = {
        theme = "dropdown",
        initial_mode = "normal",
      },

      lsp_declarations = {
        theme = "dropdown",
        initial_mode = "normal",
      },

      lsp_implementations = {
        theme = "dropdown",
        initial_mode = "normal",
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,                   -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true,    -- override the file sorter
        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
      },
    },
  },
}

-- local wk = require "which-key"
-- wk.add {
--   { "<leader>bb", "<cmd>Telescope buffers previewer=false<cr>",                       desc = "Find" },
--   { "<leader>fb", "<cmd>Telescope git_branches<cr>",                                  desc = "Checkout branch" },
--   { "<leader>fc", "<cmd>Telescope colorscheme<cr>",                                   desc = "Colorscheme" },
--   { "<leader>ff", "<cmd>Telescope find_files<cr>",                                    desc = "Find files" },
--   { "<leader>fp", "<cmd>lua require('telescope').extensions.projects.projects()<cr>", desc = "Projects" },
--   { "<leader>ft", "<cmd>Telescope live_grep<cr>",                                     desc = "Find Text" },
--   { "<leader>fh", "<cmd>Telescope help_tags<cr>",                                     desc = "Help" },
--   { "<leader>fl", "<cmd>Telescope resume<cr>",                                        desc = "Last Search" },
--   { "<leader>fr", "<cmd>Telescope oldfiles<cr>",                                      desc = "Recent File" },
-- }
