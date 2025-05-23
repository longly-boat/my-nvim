local leet_arg = "leetcode.nvim"
return {
	"kawre/leetcode.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
		-- "ibhagwan/fzf-lua",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		arg = leet_arg,
		lang = "cpp",
		cn = {
			enabled = true,
		},
	},
	lazy = leet_arg ~= vim.fn.argv()[1],
}
