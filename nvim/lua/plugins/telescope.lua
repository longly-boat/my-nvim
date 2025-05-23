return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	-- or                              , branch = '0.1.x',
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("telescope").setup({
			defaults = {
				-- 打开弹窗后进入的初始模式，默认为 insert，也可以是 normal
				initial_mode = "insert",
				-- 窗口内快捷键
				mappings = require("config.keybindings").telescopeList,
			},
			pickers = {
				-- 内置 pickers 配置
				find_files = {
					-- 查找文件换皮肤，支持的参数有： dropdown, cursor, ivy
					-- theme = "dropdown",
				},
			},
			extensions = {
				-- 扩展插件配置
			},
		})
	end,
}
