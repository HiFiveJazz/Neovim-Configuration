local M = {
  "m00qek/baleia.nvim",

  cond = function()
    return vim.env.AERC_NVIM_VIEWER == "1"
  end,
}

M.config = function()
  vim.g.baleia = require("baleia").setup({
    strip_ansi_codes = true,
    async = false,
  })

  vim.api.nvim_create_user_command("BaleiaColorize", function()
    vim.g.baleia.once(vim.api.nvim_get_current_buf())
  end, { bang = true })

  vim.api.nvim_create_user_command("BaleiaLogs", function()
    vim.cmd.messages()
  end, { bang = true })

  vim.api.nvim_create_autocmd("StdinReadPost", {
    callback = function(ev)
      vim.g.baleia.once(ev.buf)
      vim.bo[ev.buf].modified = false
    end,
  })
end

return M
