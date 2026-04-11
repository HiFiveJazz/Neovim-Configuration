local M = {
  "brenton-leighton/multiple-cursors.nvim",
  version = "*",
  event = "VeryLazy",
  opts = {},
  keys = {
    -- Turn the visual selection into real multicursors
    { "<M-k>", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "x" }, desc = "Add cursor up" },
    { "<M-j>", "<Cmd>MultipleCursorsAddDown<CR>", mode = { "n", "x" }, desc = "Add cursor down" },
    { "<CR>", "<Cmd>MultipleCursorsAddVisualArea<CR>", mode = "x", desc = "Activate multicursors on selected lines" },
  },
}

return M
