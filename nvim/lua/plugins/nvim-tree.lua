local pluginKeys = require("config.keybindings")

local on_attach = function(bufnr)
    local api = require("nvim-tree.api")

    -- 定义快捷键映射选项
    local function opts(desc)
        return {
            desc = "nvim-tree: " .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true,
        }
    end

    -- 遍历快捷键列表并设置映射
    for _, keymap in ipairs(pluginKeys.nvimTreeList) do
        local keys = keymap.key   -- 快捷键，可以是字符串或表
        local action = keymap.action -- nvim-tree 的功能路径
        local desc = keymap.desc or action -- 描述

        -- 验证 action 是否为有效的函数
        local fn = api
        for segment in string.gmatch(action, "[^.]+") do
            if fn[segment] then
                fn = fn[segment]
            else
                vim.notify("Invalid nvim-tree action: " .. action, vim.log.levels.ERROR)
                fn = nil
                break
            end
        end

        if fn and type(fn) == "function" then
            -- 处理快捷键为表的情况
            if type(keys) == "table" then
                for _, key in ipairs(keys) do
                    vim.keymap.set("n", key, fn, opts(desc))
                end
            else
                vim.keymap.set("n", keys, fn, opts(desc))
            end
        end
    end
end
return {
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({
				-- 不显示 git 状态图标
				git = {
					enable = false,
				},
				-- project plugin 需要这样设置
				update_cwd = true,
				update_focused_file = {
					enable = true,
					update_cwd = true,
				},
				-- 隐藏 .文件 和 node_modules 文件夹
				filters = {
					dotfiles = true,
					custom = { "node_modules" },
				},
				view = {
					-- 宽度
					width = 30,
					-- 也可以 'right'
					side = "left",
					-- 不显示行数
					number = false,
					relativenumber = false,
					-- 显示图标
					signcolumn = "yes",
				},
				actions = {
					open_file = {
						-- 首次打开大小适配
						resize_window = true,
						-- 打开文件时关闭
						quit_on_open = true,
					},
				},
				-- wsl install -g wsl-open
				-- https://github.com/4U6U57/wsl-open/
				system_open = {
					cmd = "wsl-open", -- mac 直接设置为 open
				},
				-- 将 on_attach 函数绑定到 nvim-tree
				on_attach = on_attach,
			})
		end,
	},
}
