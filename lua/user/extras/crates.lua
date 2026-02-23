local M = {
  "saecki/crates.nvim",
  event = { "BufRead Cargo.toml" },
}

function M.config()
  require("crates").setup {
    completion = {
        cmp = {
            enabled = true,
        },
    },
    null_ls = {
        enabled = true,
        name = "crates.nvim",
    },
  }

  local wk = require("which-key")

  wk.add({
    { "<leader>cm", function() require("crates").show_popup() end, desc = "Cargo Menu" },
    { "<leader>cu", function() require("crates").update_crate() end, desc = "Update Cargo Package" },
  })
end

return M
