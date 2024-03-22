local M = {
  "lervag/vimtex",
  -- event = "VeryLazy",
}

function M.config()
  vim.cmd('syntax enable')
  vim.g.vimtex_view_method = 'zathura'
end

return M
