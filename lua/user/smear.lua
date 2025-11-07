local M = {
  "sphamba/smear-cursor.nvim",
  -- Lazy-load when it actually matters:
  event = { "BufReadPost", "BufNewFile", "InsertEnter" },
}

function M.config()
  require("smear_cursor").setup({
    smear_between_buffers = true,
    smear_between_neighbor_lines = true,
    scroll_buffer_space = true,
    legacy_computing_symbols_support = true,
    smear_insert_mode = true,
    stiffness = 0.5,
    trailing_stiffness = 0.6,
    distance_stop_animating = 0.1,
    time_interval = 5,
    damping = 0.70,
    damping_insert_mode = 0.75,
  })
end

return M
