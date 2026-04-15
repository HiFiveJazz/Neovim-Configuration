local M = {
    "kawre/leetcode.nvim",
    -- build = ":TSUpdate html", -- optional but recommended for formatted problem descriptions
    cmd = "Leet",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",

        -- pick one picker you already use
        "nvim-telescope/telescope.nvim",
        -- or "ibhagwan/fzf-lua",
        -- or "folke/snacks.nvim",
        -- or "echasnovski/mini.pick",
    },
}

function M.config()
    require("leetcode").setup({
        lang = "rust",
        plugins = {
            non_standalone = true,
        },
    })
end

return M
