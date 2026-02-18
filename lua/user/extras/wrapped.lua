-- {
--   "aikhe/wrapped.nvim",
--   dependencies = { 
--     "nvzone/volt" 
--   },
--   cmd = { 
--     "NvimWrapped" 
--   },
--   opts = {},
-- }

local M = {
  "aikhe/wrapped.nvim",
  dependencies = { "nvzone/volt" },
  cmd = { "NvimWrapped" },
  event = "VeryLazy",
  opts = {},
}

function M.config()
end

return M
