local M = {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    "mason-org/mason.nvim",
    "nvim-lua/plenary.nvim",
  },
}

M.execs = {
  "cssls",
  "html",
  "pyright",
  "bashls",
  "jsonls",
  "rust_analyzer",
}

function M.config()
  local wk = require "which-key"
  wk.add{
    { "<leader>lI", "<cmd>Mason<cr>", desc = "Mason Info" },
  }

  require("mason").setup {
    ui = {
      border = "rounded",
    },
  }
  require("mason-lspconfig").setup {
    ensure_installed = M.execs,
  }
end

return M
