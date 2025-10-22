-- File: lua/user/extras/harpoon.lua
-- Requires Lazy (or similar) loading
local M = {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
}

function M.config()
  local harpoon = require("harpoon")
  harpoon:setup({}) -- use defaults; add opts here if you want

  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  -- Mark current file (your old <s-m>)
  keymap("n", "<S-m>", function()
    require("user.extras.harpoon").mark_file()
  end, opts)

  -- Toggle quick menu (your old <TAB>)
  keymap("n", "<Tab>", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
  end, opts)

  -- Style the Harpoon window
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "harpoon",
    callback = function()
      vim.cmd([[highlight link HarpoonBorder TelescopeBorder]])
      -- You can put other window-local tweaks here if you like
      -- e.g. vim.cmd([[setlocal nonumber]])
    end,
  })
end

-- Harpoon v2: mark via the active list()
function M.mark_file()
  require("harpoon"):list():add()
  vim.notify("󱡅  marked file")
end

return M

