local M = {
	"chrisgrieser/nvim-rip-substitute",
	event = "VeryLazy",
}

function M.config()
	require("rip-substitute").setup({
	})
end

return M
