local M = {
  "windwp/nvim-ts-autotag",
  -- "miridih-jslee01/nvim-ts-autotag",
  -- event = { "BufReadPre", "BufNewFile" },
  -- ft = { "html", "css", "markdown", "ts", "js", "jsx", "tsx"},
}

function M.config()
  require("nvim-ts-autotag").setup({
    opts = {
      enable_close = true,
      -- enable_close = false,
      -- enable_rename = true,
      enable_rename = false,
      enable_close_on_slash = false,
    },
    -- Use per_filetype to customize behavior per language
    per_filetype = {
      html = {
        enable_close = false,
      },
      javascript = {},
      typescript = {},
      javascriptreact = {},
      typescriptreact = {},
      svelte = {},
      vue = {},
      tsx = {},
      jsx = {},
      rescript = {},
      xml = {},
      php = {},
      markdown = {},
      astro = {},
      glimmer = {},
      handlebars = {},
      hbs = {},
    },
  })
end

return M

