local M = {
  "JoosepAlviste/nvim-ts-context-commentstring",
  event = { "BufReadPre", "BufNewFile" },
}

function M.config()
  require("ts_context_commentstring").setup({
    enable_autocmd = true,
  })

  local wk = require("which-key")

  wk.add({
    { "<leader>/", "gcc", remap = true, desc = "Comment line" },
    { "<leader>/", "gc", mode = "v", remap = true, desc = "Comment selection" },
  })
end

return M
