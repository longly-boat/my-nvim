return {
{
		"sidebar-nvim/sidebar.nvim",
		config = function()
			require("sidebar-nvim").setup({
				sections = { "datetime", "git", "diagnostics", "todos" }, -- 要显示的部分
				section_separator = "-----", -- 部分之间的分隔符
				datetime = {
					format = "%Y-%m-%d %H:%M:%S", -- 日期时间格式
					clocks = {
						{ name = "local", tz = "local" },
					},
				},
				todos = {
					icon = "", -- TODO 项目的图标
				},
				git = {
					icon = "", -- Git 图标
				},
				diagnostics = {
					icon = "", -- 诊断信息的图标
				},
				open = false, -- 是否在启动时打开 sidebar
				update_interval = 1000, -- 自动刷新时间间隔（毫秒）
				disable_default_keybindings = false, -- 是否禁用默认键绑定
				bindings = { -- 自定义键绑定
					["q"] = function()
						require("sidebar-nvim").close()
					end, -- 按 `q` 关闭 sidebar
				},
			})
		end,
	},
}
