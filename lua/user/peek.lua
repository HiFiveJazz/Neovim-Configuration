local M = {
  "toppair/peek.nvim",
  event = { "VeryLazy" },
  build = "deno task --quiet build:fast",
  -- config = function()
  --   M.config()
  -- end,
}

function M.config()
  local peek = require("peek")
  local wk = require("which-key")

  peek.setup({
    auto_load = true,
    close_on_bdelete = true,
    syntax = true,
    theme = 'dark',
    update_on_change = true,
    app = 'browser',
    filetype = { 'markdown' },
    throttle_at = 200000,
    throttle_time = 'auto',
  })

  vim.api.nvim_create_user_command("PeekOpen", peek.open, {})
  vim.api.nvim_create_user_command("PeekClose", peek.close, {})

  -- Register which-key binding
  wk.add {
    {
      "<leader>m",
      function()
        if peek.is_open() then
          peek.close()
        else
          peek.open()
        end
      end,
      desc = "Toggle Markdown Preview (Peek)",
    },
  }
end

return M
