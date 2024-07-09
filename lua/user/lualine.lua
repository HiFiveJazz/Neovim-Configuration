local M = {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "AndreM222/copilot-lualine",
    "ecthelionvi/Neocomposer.nvim",
  },
}

function M.config()
  local icons = require "user.icons"
  local diff = {
    "diff",
    colored = false,
    symbols = { added = icons.git.LineAdded, modified = icons.git.LineModified, removed = icons.git.LineRemoved }, -- Changes the symbols used by the diff.
  }

  local diagnostics = {
    "diagnostics",
    sections = { "error", "warn" },
    colored = false, -- Displays diagnostics status in color if set to true.
    always_visible = true, -- Show diagnostics even if there are none.
  }

  local filetype = {
    function()
      local filetype = vim.bo.filetype
      local upper_case_filetypes = {
        "json",
        "jsonc",
        "yaml",
        "toml",
        "css",
        "scss",
        "html",
        "xml",
      }

      if vim.tbl_contains(upper_case_filetypes, filetype) then
        return filetype:upper()
      end

      return filetype
    end,
  }

  local neo_composer_status = {
    function()
      return require('NeoComposer.ui').status_recording()
    end,
    update = {
      "User",
      pattern = { "NeoComposerRecordingSet", "NeoComposerPlayingSet", "NeoComposerDelaySet" },
      callback = function(self)
        self.status = require("NeoComposer.ui").status_recording()
      end,
    },
  }

  require("lualine").setup {
    options = {
      -- theme = "neovim",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      ignore_focus = { "NvimTree" },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { { "branch", icon = "" } },
      lualine_c = { diagnostics, neo_composer_status },
      lualine_x = { diff, filetype },
      lualine_y = { "progress" },
      lualine_z = {},
    },
    -- extensions = { "quickfix", "man", "fugitive", "oil" },
    extensions = { "quickfix", "man", "fugitive" },
  }
end

return M

