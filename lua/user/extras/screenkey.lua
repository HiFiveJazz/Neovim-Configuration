local M = {
  "NStefan002/screenkey.nvim",
  lazy = false,
  version = "*",
}

function M.config()
require("screenkey").setup({
    win_opts = {
        row = vim.o.lines - vim.o.cmdheight - 1,
        col = vim.o.columns - 1,
        relative = "editor",
        anchor = "SE",
        width = 40,
        height = 3,
        border = "single",
        title = "Screen Key",
        title_pos = "center",
        style = "minimal",
        focusable = false,
        noautocmd = true,
    },
})
end

return M
