local M = {
  "mfussenegger/nvim-lint",
  event = "VeryLazy",
}

function M.config()
require('lint').linters_by_ft = {
  c = {'checkpatch'},
}
end

return M
