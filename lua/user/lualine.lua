local M = {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "ecthelionvi/Neocomposer.nvim",
    "nvim-tree/nvim-web-devicons",
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
    local ft = vim.bo.filetype
    if ft == "" then
      return ""
    end

    -- Your uppercase list
    local upper = {
      json = true, jsonc = true, yaml = true, toml = true, css = true,
      scss = true, html = true, xml = true,
    }

    local label = upper[ft] and ft:upper() or ft

    -- Devicon for the current buffer name
    local ok, devicons = pcall(require, "nvim-web-devicons")
    if not ok then
      return label
    end

    local name = vim.fn.expand("%:t")
    local ext  = vim.fn.expand("%:e")
    local icon = devicons.get_icon(name, ext, { default = true }) or ""

    if icon ~= "" then
      return icon .. " " .. label
    end
    return label
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
      lualine_x = { "harpoon2", diff, filetype },
      lualine_y = { "progress" },
      lualine_z = {},
    },
    -- extensions = { "quickfix", "man", "fugitive", "oil" },
    extensions = { "quickfix", "man", "fugitive" },
  }
end

return M

