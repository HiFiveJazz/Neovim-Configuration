local M = {
  "letieu/harpoon-lualine",
  -- event = "VeryLazy",
  dependencies = {
      "ThePrimeagen/harpoon",
        branch = "harpoon2",
  }
}

function M.config()
  require("harpoon-lualine").setup({
    -- clean macOS style
    -- icon = "󰀱 ", -- subtle icon
    -- separator = " ",
    -- no_harpoon = "",
    -- indicator_active = "●",
    -- indicator_inactive = "○",
    -- active_color = { fg = "#7aa2f7" },   -- Tokyo Night blue
    -- inactive_color = { fg = "#565f89" }, -- muted
  })
end

return M
