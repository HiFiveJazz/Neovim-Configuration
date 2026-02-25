local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
keymap("n", "<Space>", "", opts)
keymap("n", "q", "", opts) -- My macro button is Neocomposer
keymap("n", "m", "", opts) -- This is the macro button used by Neocomposer
keymap("n", "s", "", opts) -- Used by nvim surround
vim.g.mapleader = " "
vim.g.maplocalleader = " "
keymap("v", "X", '"_d', opts) -- binds X to delete into black hole register
keymap("n", "X", '"_dd', opts) -- binds X to delete into black hole register
keymap("n", "<C-i>", "<C-i>", opts)
-- Better window navigation
-- When using :vsplit, rebinds, default window moving keys
-- to alt-h, alt-j, alt-k, alt-l based on the window location 
keymap("n", "<m-h>", "<C-w>h", opts)
keymap("n", "<m-j>", "<C-w>j", opts)
keymap("n", "<m-k>", "<C-w>k", opts)
keymap("n", "<m-l>", "<C-w>l", opts)
keymap("n", "<m-tab>", "<c-6>", opts)

keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)
keymap("n", "g*", "g*zz", opts)
keymap("n", "g#", "g#zz", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

keymap("x", "p", [["_dP]])

vim.cmd [[:amenu 10.100 mousemenu.Goto\ Definition <cmd>lua vim.lsp.buf.definition()<CR>]]
vim.cmd [[:amenu 10.110 mousemenu.References <cmd>lua vim.lsp.buf.references()<CR>]]
-- vim.cmd [[:amenu 10.120 mousemenu.-sep- *]]

vim.keymap.set("n", "<RightMouse>", "<cmd>:popup mousemenu<CR>")
vim.keymap.set("n", "<Tab>", "<cmd>:popup mousemenu<CR>")

-- more good
keymap({ "n", "o", "x" }, "<s-h>", "^", opts) -- Shift-h moves to the left 
keymap({ "n", "o", "x" }, "<s-l>", "g_", opts) -- Shift-l moves to the right

-- tailwind bearable to work with
keymap({ "n", "x" }, "j", "gj", opts)
keymap({ "n", "x" }, "k", "gk", opts)
keymap("n", "<leader>w", ":lua vim.wo.wrap = not vim.wo.wrap<CR>", opts)


vim.api.nvim_set_keymap('t', '<C-;>', '<C-\\><C-n>', opts)

function find_and_replace()
    -- Prompt user for search term
    local search_term = vim.fn.input('Find: ')
    -- Prompt user for replace term
    local replace_term = vim.fn.input('Replace with: ')
    
    -- Construct the substitution command
    local command = string.format('%%s/%s/%s/g', search_term, replace_term)
    
    -- Execute the substitution command
    vim.cmd(command)
end

vim.api.nvim_set_keymap('n', '<Leader>r', [[:lua find_and_replace()<CR>]], opts)
