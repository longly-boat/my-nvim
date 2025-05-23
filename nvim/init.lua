-- 基础设置
-- ./lua/config/basic.lua
require("config.basic")
-- 快捷键映射
-- ./lua/config/keybindings.lua
require("config.keybindings")
local pluginKeys = require("config.keybindings")
-- 模块化加载lazy.nvim配置文件
-- ./lua/config/lazy.lua
require("config.lazy")
-- 主题设置
-- ./lua/config/colorscheme.lua
require("config.colorscheme")

-- 在 Neovim 启动时自动打开 nvim-tree
local function open_nvim_tree()
	-- 打开 nvim-tree
	require("nvim-tree.api").tree.open()
	-- 切换焦点回到编辑窗口
	vim.cmd("wincmd p")
end

-- 在 VimEnter 事件时调用 open_nvim_tree 函数
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

--使用wsl时打通nvim和windows的剪切版
vim.opt.clipboard:append({ "unnamedplus" })

vim.g.clipboard = {
	name = "win32yank",
	copy = {
		["+"] = "win32yank -i --crlf",
		["*"] = "win32yank -i --crlf",
	},
	paste = {
		["+"] = "win32yank -o --lf",
		["*"] = "win32yank -o --lf",
	},
	cache_enabled = 0,
}
--自动关闭tree
vim.api.nvim_create_autocmd("BufEnter", {
	nested = true,
	callback = function()
		-- 获取当前打开的窗口数量
		local wins = vim.api.nvim_list_wins()
		-- 获取当前缓冲区的文件类型
		local buf_ft = vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), "filetype")
		-- 检查是否只剩下一个窗口且该窗口是 nvim-tree
		if #wins == 1 and buf_ft == "NvimTree" then
			-- 关闭 Neovim
			vim.cmd("quit")
		end
	end,
})
