local M = {
  "KeitaNakamura/tex-conceal.vim",
}

function M.config()
  vim.opt.conceallevel = 1
  vim.g.tex_conceal = 'abdmg'
  vim.cmd('highlight Conceal ctermbg=none')
end

return M
