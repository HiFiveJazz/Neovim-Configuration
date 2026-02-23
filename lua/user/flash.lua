local M = {
  "folke/flash.nvim",
  event = "VeryLazy",

  ---@type Flash.Config
}

function M.config()
  require("flash").setup({
    opts = {
      modes = {
        char = {
          enabled = true,
          jump_labels = true,
          multi_line = true, -- lets f/t jump above/below
        },
      },
    },

    keys = {
      {
        "zf",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash Jump",
      },
    },
  })

  local wk = require("which-key")

  wk.add({
    { "z", group = "Z motions" },
    { "zf", desc = "Flash Jump", mode = { "n", "x", "o" } },
  })
end

return M
