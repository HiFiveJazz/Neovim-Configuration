local M = {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  event = "VeryLazy",
  ft = { "markdown", "quarto", "vimwiki" },
}

function M.config()
  require("render-markdown").setup({
    -- Render Behavior
    render_modes = { "n", "c", "t" }, -- render in normal/command/terminal
    -- or set to true to render in ALL modes

    -- This is the key for your request:
    -- Keeps rendering active even when cursor is on the line
    anti_conceal = {
      enabled = false,
    },

    -- Window Conceal Settings
    win_options = {
      conceallevel = {
        default = vim.o.conceallevel,
        rendered = 3,
      },
      concealcursor = {
        default = vim.o.concealcursor,
        rendered = "",
      },
    },

    -- Make it render in hover / nofile buffers (LSP hover)
    overrides = {
      buftype = {
        nofile = {
          render_modes = true,
          anti_conceal = { enabled = false },
          sign = { enabled = false },
        },
      },
    },
  })
end

return M
