local M = {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
}

function M.config()
  require("notify").setup({
    timeout = 250,
  })

  require("noice").setup({
    cmdline = {
      format = {
        search_down = {
          icon = "   ",
        },
        search_up = {
          icon = "   ",
        },
      },
    },

    lsp = {
      progress = {
        enabled = false,
      },

      message = {
        enabled = false,
      },

      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },

      signature = {
        enabled = false,
        auto_open = {
          enabled = false,
          trigger = false,
          luasnip = false,
          throttle = 50,
        },
        view = nil,
        opts = {},
      },
    },

    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = true,
    },
  })
end

return M
