local M = {
	"chrisgrieser/nvim-rip-substitute",
	event = "VeryLazy",
	-- cmd = "RipSubstitute",
}

function M.config()
	require("rip-substitute").setup({
	})
end

return M
