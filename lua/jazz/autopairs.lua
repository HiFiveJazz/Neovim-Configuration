local M = {
  "windwp/nvim-autopairs",
}

M.config = function()
  require("nvim-autopairs").setup {
    check_ts = true,
    disable_filetype = { "TelescopePrompt", "spectre_panel" },
  }
  local Rule = require('nvim-autopairs.rule')
  local npairs = require('nvim-autopairs')
  npairs.add_rules {
    Rule("$","$",{"tex", "latex"}),
    Rule("<",">",{"html", "javascriptreact", "xml", "typescriptreact"})
  }

end

return M
