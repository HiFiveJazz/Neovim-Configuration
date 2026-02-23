local M = {
  "kylechui/nvim-surround",
  version = "*",
  event = "VeryLazy",
}

function M.config()
  require("nvim-surround").setup {
    eymaps = { 
      -- insert = "<C-g>s",
      -- insert_line = "<C-g>S",
      normal = "s",
      normal_cur = "ss",
      normal_line = "S",
      normal_cur_line = "SS",
      visual = "s",
      -- visual_line = "gS",
      delete = "ds",
      change = "cs",
    },
  }

  local wk = require "which-key"

wk.add({
  -- First level
  { "s", group = "Surround", mode = { "n", "x" } },
  { "ss", group = "Surround Line", mode = "n" },

  -- Second level (targets)
  { "ss(", desc = "Surround with ()", mode = "n" },
  { "ss{", desc = "Surround with {}", mode = "n" },
  { "ss[", desc = "Surround with []", mode = "n" },
  { 'ss"', desc = 'Surround with ""', mode = "n" },
  { "ss'", desc = "Surround with ''", mode = "n" },
  { "ss`", desc = "Surround with ``", mode = "n" },
  { "sst", desc = "Surround with HTML tag", mode = "n" },

  -- Delete / Change preview
  { "ds", group = "Delete Surround", mode = "n" },
  { "cs", group = "Change Surround", mode = "n" },
})

  -- vim.cmd [[nmap <leader>' siw']]
end

return M
