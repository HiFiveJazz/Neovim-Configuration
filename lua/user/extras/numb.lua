local M = {
  "nacro90/numb.nvim",
  event = "CmdlineEnter",
}

function M.config()
  require("numb").setup({
    show_numbers = true,      -- show line numbers in preview
    show_cursorline = true,   -- highlight the previewed line
    hide_relativenumbers = true,
    number_only = false,      -- allow :42, not just numbers
    centered_peeking = true,  -- keep preview centered (feels nice)
  })
end

return M
