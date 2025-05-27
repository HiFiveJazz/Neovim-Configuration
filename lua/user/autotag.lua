local M = {
  "windwp/nvim-ts-autotag",
  event = { "BufReadPre", "BufNewFile" },
}

function M.config()
  require("nvim-ts-autotag").setup({
    opts = {
      enable_close = false,
      enable_rename = true,
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

