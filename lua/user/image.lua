local M = {
  "3rd/image.nvim",
  version = "v1.4.0",
  dependencies = { "luarocks.nvim" },

  -- IMPORTANT: load early so hijack_file_patterns autocmds exist
  lazy = false,
  -- (Alternative if you prefer lazy-loading: event = { "BufReadPre", "BufNewFile" })
}

function M.config()
  require("image").setup({
    backend = "kitty",

    -- If you didn't explicitly configure a processor elsewhere,
    -- setting it removes ambiguity:
    processor = "magick_cli", -- requires ImageMagick installed

    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = true,
        download_remote_images = true,
        only_render_image_at_cursor = false,
        only_render_image_at_cursor_mode = "popup",
        filetypes = { "markdown", "vimwiki" },
      },
      neorg = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = true,
        only_render_image_at_cursor = false,
        filetypes = { "norg" },
      },
      html = { enabled = false },
      css  = { enabled = false },
    },

    max_width = nil,
    max_height = nil,
    max_width_window_percentage = 75,
    max_height_window_percentage = 25,
    window_overlap_clear_enabled = false,
    window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
    editor_only_render_when_focused = false,
    tmux_show_only_in_active_window = false,
    hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
  })
end

return M
