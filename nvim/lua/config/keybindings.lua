--<leader> 表示 空格
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--保存本地变量
local map = vim.api.nvim_set_keymap
-- 复用 opt 参数
local opt = { noremap = true, silent = true }

--map('模式', '按键', '映射为', 'options')

-- 取消 s 默认功能
map("n", "s", "", opt)
-- windows 分屏快捷键
map("n", "sv", ":vsp<CR>", opt) --垂直分屏
map("n", "sh", ":sp<CR>", opt) -- 水平分屏
-- 关闭当前窗u
map("n", "sc", "<C-w>c", opt)
-- 关闭其他窗口
map("n", "so", "<C-w>o", opt)
--保存文件
map("n", "ss", ":w<CR>", opt)
-- Alt + hjkl  窗口之间跳转
map("n", "<A-h>", "<C-w>h", opt)
map("n", "<A-j>", "<C-w>j", opt)
map("n", "<A-k>", "<C-w>k", opt)
map("n", "<A-l>", "<C-w>l", opt)
-- 左右比例控制
map("n", "<C-Left>", ":vertical resize -2<CR>", opt)
map("n", "<C-Right>", ":vertical resize +2<CR>", opt)
-- 上下比例
map("n", "<C-Down>", ":resize +2<CR>", opt)
map("n", "<C-Up>", ":resize -2<CR>", opt)
-- 等比例
map("n", "s=", "<C-w>=", opt)
--清空文件,不保存
map("n", "<leader>ad", ":%d<CR>", opt)
--复制文件所有内容
map("n", "<leader>y", [[:%y+<CR>]], opt)
-- Terminal相关
map("n", "<leader>t", ":sp | terminal<CR>", opt)
map("n", "<leader>vt", ":vsp | terminal<CR>", opt)
map("t", "<Esc>", "<C-\\><C-n>", opt)
map("t", "<A-h>", [[ <C-\><C-N><C-w>h ]], opt)
map("t", "<A-j>", [[ <C-\><C-N><C-w>j ]], opt)
map("t", "<A-k>", [[ <C-\><C-N><C-w>k ]], opt)
map("t", "<A-l>", [[ <C-\><C-N><C-w>l ]], opt)

-- visual模式下缩进代码
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)
-- 上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv", opt)
map("v", "K", ":move '<-2<CR>gv-gv", opt)

-- 普通模式tab 插入制表符
map("n", "<tab>", "i<tab>", opt)
-- 上下滚动浏览
map("n", "<C-j>", "4j", opt)
map("n", "<C-k>", "4k", opt)
map("v", "<C-j>", "4j", opt)
map("v", "<C-k>", "4k", opt)
-- ctrl u / ctrl + d  只移动9行，默认移动半屏

map("n", "<C-u>", "9k", opt)
map("n", "<C-d>", "9j", opt)

-- 在visual 模式里粘贴不要复制
map("v", "p", '"_dP', opt)
-- 退出
map("n", "q", ":q<CR>", opt)
map("n", "qq", ":q!<CR>", opt)
map("n", "Q", ":qa!<CR>", opt)
-- insert 模式下，跳到行首行尾
map("i", "<C-h>", "<ESC>I", opt)
map("i", "<C-l>", "<ESC>A", opt)
-- 打开目录树
map("n", "<leader>m", ":NvimTreeOpen<CR>", opt)

--关闭ufo插件
map("n", "oud", "<cmd>UfoDisable<cr>", opt)
--开启ufo插件
map("n", "oue", "<cmd>UfoEnable<cr>", opt)

-- bufferline
-- 左右Tab切换
map("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
map("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)
-- 关闭
--"moll/vim-bbye"
map("n", "<C-w>", ":Bdelete!<CR>", opt)
map("n", "<leader>bl", ":BufferLineCloseRight<CR>", opt)
map("n", "<leader>bh", ":BufferLineCloseLeft<CR>", opt)
map("n", "<leader>bc", ":BufferLinePickClose<CR>", opt)

-- Telescope
-- 查找文件
map("n", "<C-p>", ":Telescope find_files<CR>", opt)
-- 全局搜索
map("n", "<C-f>", ":Telescope live_grep<CR>", opt)

-- 插件快捷键
local pluginKeys = {}
-- nvim-tree
-- alt + m 键打开关闭tree
map("n", "<A-m>", ":NvimTreeToggle<CR>", opt)
-- 格式化快捷键
map("n", "<leader>f", ":Format<CR>", opt)
map("n", "<leader>F", ":FormatWrite<CR>", opt)

-- 列表快捷键
pluginKeys.nvimTreeList = {
	-- 打开文件或文件夹
	{ key = { "<CR>", "o", "<2-LeftMouse>" }, action = "node.open.edit", desc = "Open File/Folder" },
	-- 分屏打开文件
	{ key = "v", action = "node.open.vertical", desc = "Open in Vertical Split" },
	{ key = "h", action = "node.open.horizontal", desc = "Open in Horizontal Split" },
	{ key = "i", action = "tree.toggle_hidden_filter", desc = "Toggle Hidden Files (Custom)" },
	{ key = ".", action = "tree.toggle_hidden_filter", desc = "Toggle Dotfiles" },
	-- 文件操作
	{ key = "<F5>", action = "tree.reload", desc = "Refresh Tree" },
	{ key = "a", action = "fs.create", desc = "Create File/Folder" },
	{ key = "d", action = "fs.remove", desc = "Delete File/Folder" },
	{ key = "r", action = "fs.rename", desc = "Rename File/Folder" },
	{ key = "x", action = "fs.cut", desc = "Cut File/Folder" },
	{ key = "c", action = "fs.copy", desc = "Copy File/Folder" },
	{ key = "p", action = "fs.paste", desc = "Paste File/Folder" },
	{ key = "s", action = "node.run.system", desc = "Open File/Folder with System" },
}
pluginKeys.telescopeList = {
	i = {
		-- 上下移动
		["<C-j>"] = "move_selection_next",
		["<C-k>"] = "move_selection_previous",
		["<Down>"] = "move_selection_next",
		["<Up>"] = "move_selection_previous",
		-- 历史记录
		["<C-n>"] = "cycle_history_next",
		["<C-p>"] = "cycle_history_prev",
		-- 关闭窗口
		["<C-c>"] = "close",
		-- 预览窗口上下滚动
		["<C-u>"] = "preview_scrolling_up",
		["<C-d>"] = "preview_scrolling_down",
	},
}

return pluginKeys

-- Telescope 列表中 插入模式快捷键
