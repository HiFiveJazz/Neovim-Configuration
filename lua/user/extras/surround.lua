local M = {
  "kylechui/nvim-surround",
  version = "*",
  event = "VeryLazy",

  -- must be set before plugin loads
  init = function()
    vim.g.nvim_surround_no_mappings = true
  end,
}

function M.config()
  require("nvim-surround").setup({})

  -- Add surrounds
  vim.keymap.set("n", "s",  "<Plug>(nvim-surround-normal-cur)", { desc = "Surround (motion)" })
  -- vim.keymap.set("n", "S",  "<Plug>(nvim-surround-normal-line)", { desc = "Surround (motion, newline)" })
  -- vim.keymap.set("n", "SS", "<Plug>(nvim-surround-normal-cur-line)", { desc = "Surround (line, newline)" })

  -- Visual
  vim.keymap.set("x", "s", "<Plug>(nvim-surround-visual)", { desc = "Surround (visual)" })

  vim.keymap.set("n", "ds", "<Plug>(nvim-surround-delete)", { desc = "Delete surround" })
  vim.keymap.set("n", "cs", "<Plug>(nvim-surround-change)", { desc = "Change surround" })

  vim.keymap.set("n", "dt", "dst", { remap = true, desc = "Delete surrounding tag" })
  vim.keymap.set("n", "ct", "cst", { remap = true, desc = "Change tag (keep attributes)" })
  vim.keymap.set("n", "cT", "csT", { remap = true, desc = "Change tag (replace attributes)" })

  -- which-key (optional)
  local ok, wk = pcall(require, "which-key")
  if ok then
    wk.add({
      { "s",  group = "Surround", mode = { "n", "x" } },
      { "S",  desc = "Surround (newline)", mode = "n" },
      { "SS", desc = "Surround line (newline)", mode = "n" },
      { "dt", group = "Delete Surround", mode = "n" },
      { "ct", group = "Change Surround", mode = "n" },
      { "dt", desc = "Delete tag (dst)", mode = "n" },
      { "ct", desc = "Change tag (cst)", mode = "n" },
      { "cT", desc = "Change tag (csT)", mode = "n" },
    })
  end
end

return M
