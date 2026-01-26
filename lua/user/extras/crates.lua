local M = {
  "saecki/crates.nvim",
  -- tag = 'stable',
}

function M.config()
  require("crates").setup {
    null_ls = false, 
    -- {
    --   enabled = true,
    --   name = "crates.nvim",
    -- },
  }
end

return M
