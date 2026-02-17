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
    lsp = {
      -- ✅ don't let noice display LSP progress (use fidget instead)
      progress = {
        enabled = false,
      },

      -- ✅ don't let noice route LSP messages to cmdline/popup
      message = {
        enabled = false,
      },

      -- keep your markdown overrides
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

