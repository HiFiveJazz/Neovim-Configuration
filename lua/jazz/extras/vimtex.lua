local M = {
  "lervag/vimtex",
  -- event = "VeryLazy",
}

function M.config()
  vim.g.tex_flavor='latex'
  vim.g.vimtex_view_method = 'zathura'
  vim.g.vimtex_quickfix_mode = 0
end

return M
