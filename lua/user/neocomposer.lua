local M = {
  "ecthelionvi/NeoComposer.nvim",
  dependencies = {
    "kkharji/sqlite.lua",
    "nvim-telescope/telescope.nvim",
  },
  opts = {}
}

local wk = require "which-key"

wk.add {
{
  "mr",
  desc = "Record Macro",
},
{
  "mr",
  desc = "Play Macro",
},
{
  "ms",
  desc = "Stop Macro",
},
{
  "mm",
  desc = "Macro Menu",
},
}
function M.config()
  local config = {
    notify = true,
    delay_timer = 150,
    queue_most_recent = false,
    window = {
      width = 60,
      height = 10,
      border = "rounded",
      winhl = {
        Normal = "ComposerNormal",
      },
    },
    colors = {
      bg = "#000000",
      status_bg = "#999123",
      fg = "#ff9e64",
      red = "#ec5f67",
      blue = "#5fb3b3",
      green = "#99c794",
    },
    keymaps = {
      toggle_record = "mr",
      play_macro = "mp",
      stop_macro = "ms",
      toggle_macro_menu = "mm",
    },
  }
  require("NeoComposer").setup(config)
end
return M
