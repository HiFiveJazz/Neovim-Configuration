local M = {
  -- "LunarVim/darkplus.nvim",
  "folke/tokyonight.nvim",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
}
require ("tokyonight").setup({
  style = "night",
  transparent = true,
  styles = {
    terminal_colors = true,
    sidebars = "transparent",
    floats = "transparent",
  },
})
function M.config()
  vim.cmd.colorscheme "tokyonight"
  -- vim.cmd.colorscheme "darkplus"
  -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return M
