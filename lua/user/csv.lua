-- lua/plugins/csvview.lua
local M = {
  "hat0uma/csvview.nvim",
  cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
  ft  = { "csv", "tsv" },
  ---@type CsvView.Options
  opts = {
    parser = { comments = { "#", "//" } },
    sticky_header = {
      enabled = true,
      separator = "─",
    },
    keymaps = {
      textobject_field_inner = { "if", mode = { "o", "x" } },
      textobject_field_outer = { "af", mode = { "o", "x" } },
      jump_next_field_end = { "<Tab>",    mode = { "n", "v" } },
      jump_prev_field_end = { "<S-Tab>",  mode = { "n", "v" } },
      jump_next_row       = { "<Enter>",  mode = { "n", "v" } },
      jump_prev_row       = { "<S-Enter>",mode = { "n", "v" } },
    },
  },
}

function M.config(_, opts)
  -- keep your notify filter
  local banned_messages = { "No information available" }
  vim.notify = function(msg, ...)
    for _, banned in ipairs(banned_messages) do
      if msg == banned then return end
    end
    return require("notify")(msg, ...)
  end

  require("csvview").setup(opts)

  -- Auto-enable on CSV/TSV open with the requested command args
  local aug = vim.api.nvim_create_augroup("CsvViewAutoEnable", { clear = true })
  vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "FileType" }, {
    group = aug,
    pattern = { "*.csv", "*.tsv", "csv", "tsv" },
    callback = function(args)
      -- avoid re-running if already enabled in this buffer
      if vim.b[args.buf].csvview_enabled then return end
      vim.b[args.buf].csvview_enabled = true
      -- run with your flags
      pcall(vim.cmd, "CsvViewEnable display_mode=border header_lnum=1")
    end,
  })
end

return M

