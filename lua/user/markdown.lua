local M = {
"iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function() vim.fn["mkdp#util#install"]() end,
}

function M.config()
  local wk = require "which-key"
  wk.add {
    ["<leader>m"] = { "<cmd>MarkdownPreviewToggle<cr>", "Toggle Markdown Preview" },
  }
end

return M

