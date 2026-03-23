local M = {
  "code-biscuits/nvim-biscuits",
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
}

function M.config()
  require("nvim-biscuits").setup {
  }
end

return M
