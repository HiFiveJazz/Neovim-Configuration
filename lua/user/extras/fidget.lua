local M = {
  "j-hui/fidget.nvim",
}

function M.config()
  require("fidget").setup({
    integration = {
      ["nvim-tree"] = { enable = true },
    },

    notification = {
      window = {
        normal_hl = "NormalFloat",
        winblend = 10,              -- slight transparency (0 = solid)
        border = "rounded",         -- ✨ rounded corners
        zindex = 45,
        max_width = 60,
        max_height = 10,
        x_padding = 2,
        y_padding = 1,
        align = "top",
        relative = "editor",
      },

      view = {
        stack_upwards = false,      -- new notifications appear below old ones
      },
    },
  })
end

return M

