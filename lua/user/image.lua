local M = {
  "folke/snacks.nvim",
  priority = 1000,
  ft = { "markdown", "norg", "vimwiki", "html" },
  cmd = { "Snacks" },
}

function M.init()
  local group = vim.api.nvim_create_augroup("snacks_image_lazy_load", { clear = true })

  vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    group = group,
    pattern = {
      "*.png",
      "*.jpg",
      "*.jpeg",
      "*.gif",
      "*.webp",
      "*.avif",
      "*.bmp",
      "*.pdf",
    },
    callback = function()
      require("lazy").load({ plugins = { "snacks.nvim" } })
    end,
  })
end

function M.config()
  require("snacks").setup({
    image = {
      enabled = true,
      doc = {
        enabled = true,
        inline = true,
        float = true,
        max_width = 80,
        max_height = 40,
      },
      wo = {
        wrap = false,
        number = false,
        relativenumber = false,
        cursorcolumn = false,
        signcolumn = "no",
        foldcolumn = "0",
        list = false,
        spell = false,
        statuscolumn = "",
      },
      cache = vim.fn.stdpath("cache") .. "/snacks/image",
      convert = {
        notify = false,
      },
    },
  })
end

return M
