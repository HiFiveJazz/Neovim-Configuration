local M = {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    modes = {
      char = {
        enabled = true,
        jump_labels = true,
        multi_line = true, -- ✅ lets f/t jump above/below
      },
    },
  },
  keys = {
    -- Your existing "obscure places fast" jump
    {
      "zf",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash Jump",
    },

  },
}

return M

