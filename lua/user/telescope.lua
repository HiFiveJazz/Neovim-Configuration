local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = { { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true } },
  lazy = true,
  cmd = "Telescope",
}

function M.config()
  local wk = require "which-key"
  local actions = require "telescope.actions"

  wk.add({
    {
      "<leader>bb",
      "<cmd>Telescope buffers previewer=false<cr>",
      desc = "Find",
      icon = { icon = "󰈔 ", color = "green" },
    },
    {
      "<leader>fC",
      "<cmd>Telescope commands<cr>",
      desc = "Commands",
      icon = { icon = "󰘳 ", color = "green" },
    },
    {
      "<leader>fH",
      "<cmd>Telescope highlights<cr>",
      desc = "Highlights",
      icon = { icon = "󰸱 ", color = "green" },
    },
    {
      "<leader>fm",
      "<cmd>Telescope man_pages<cr>",
      desc = "Man Pages",
      icon = { icon = "󰗚 ", color = "green" },
    },
    {
      "<leader>fb",
      "<cmd>Telescope git_branches<cr>",
      desc = "Checkout branch",
      icon = { icon = "󰘬 ", color = "green" },
    },
    {
      "<leader>fc",
      "<cmd>Telescope colorscheme<cr>",
      desc = "Colorscheme",
      icon = { icon = "󰏘 ", color = "green" },
    },
    {
      "<leader>ff",
      "<cmd>Telescope find_files<cr>",
      desc = "Find files",
      icon = { icon = "󰈞 ", color = "green" },
    },
    {
      "<leader>fh",
      "<cmd>Telescope help_tags<cr>",
      desc = "Help",
      icon = { icon = "󰞋 ", color = "green" },
    },
    {
      "<leader>fk",
      "<cmd>Telescope keymaps<cr>",
      desc = "Keymaps",
      icon = { icon = "󰌌 ", color = "green" },
    },
    {
      "<leader>fl",
      "<cmd>Telescope resume<cr>",
      desc = "Last Search",
      icon = { icon = "󰑓 ", color = "green" },
    },
    {
      "<leader>fp",
      "<cmd>lua require('telescope').extensions.projects.projects()<cr>",
      desc = "Projects",
      icon = { icon = "󰏗 ", color = "green" },
    },
    {
      "<leader>fr",
      "<cmd>Telescope oldfiles<cr>",
      desc = "Recent File",
      icon = { icon = "󰋚 ", color = "green" },
    },
    {
      "<leader>fs",
      "<cmd>Telescope grep_string<cr>",
      desc = "Find String",
      icon = { icon = "󰱼 ", color = "green" },
    },
    {
      "<leader>ft",
      "<cmd>Telescope live_grep<cr>",
      desc = "Find Text",
      icon = { icon = "󱎸 ", color = "green" },
    },
    {
      "<leader>le",
      "<cmd>Telescope quickfix<cr>",
      desc = "Telescope Quickfix",
      icon = { icon = "󱖫 ", color = "green" },
    },
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "TelescopeResults",
    callback = function(ctx)
      vim.api.nvim_buf_call(ctx.buf, function()
        vim.fn.matchadd("TelescopeParent", "\t\t.*$")
        vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
      end)
    end,
  })

  local telescope_icon = "󰍉 "
  local forward_icon = " "

  local function filenameFirst(_, path)
    local tail = vim.fs.basename(path)
    local parent = vim.fs.dirname(path)
    if parent == "." then
      return tail
    end
    return string.format("%s\t\t%s", tail, parent)
  end

  require("telescope").setup({
    defaults = {
      prompt_prefix = telescope_icon,
      selection_caret = forward_icon,
      entry_prefix = "   ",
      initial_mode = "insert",
      selection_strategy = "reset",
      path_display = { "smart" },
      color_devicons = true,
      set_env = { ["COLORTERM"] = "truecolor" },
      sorting_strategy = nil,
      layout_strategy = nil,
      layout_config = {},
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--glob=!.git/",
      },

      mappings = {
        i = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        },
        n = {
          ["<esc>"] = actions.close,
          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
          ["q"] = actions.close,
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
        path_display = filenameFirst,
      },

      buffers = {
        theme = "dropdown",
        previewer = false,
        initial_mode = "normal",
        mappings = {
          i = {
            ["<C-d>"] = actions.delete_buffer,
          },
          n = {
            ["dd"] = actions.delete_buffer,
          },
        },
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
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  })
end

return M
