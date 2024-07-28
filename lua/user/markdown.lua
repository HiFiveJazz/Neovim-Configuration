local M = {
"iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function() vim.fn["mkdp#util#install"]() end,
}

function M.config()
  local wk = require "which-key"
  wk.add {
    { "<leader>M", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle Markdown Preview" },
  }
end

return M

