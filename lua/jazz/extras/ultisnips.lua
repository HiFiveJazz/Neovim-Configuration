local M = {
  "sirver/ultisnips",
}
function M.config()
  vim.g.UltiSnipsExpandTrigger = '<tab>' 
  vim.g.UltiSnipsJumpForwardTrigger = '<tab>' 
  vim.g.UltiSnipsJumpBackwardTrigger= '<s-tab>' 
  vim.g.UltiSnipsSnippetDir = '~/.config/nvim/UltiSnips/'
end

return M
