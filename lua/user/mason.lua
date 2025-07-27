local M = {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    "mason-org/mason.nvim",
    "nvim-lua/plenary.nvim",
  },
}

M.execs = {
  -- "lua_ls",
  "cssls",
  "html",
  "pyright",
  "bashls",
  "jsonls",
  -- "matlab_ls",
  "rust_analyzer",
  -- "ltex",
  -- "texlab",
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
