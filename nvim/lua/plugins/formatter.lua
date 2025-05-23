return {
	{
		"mhartington/formatter.nvim", -- 引入 formatter.nvim 插件
		config = function()
			-- 用于创建配置的工具函数
			local util = require("formatter.util")

			require("formatter").setup({
				-- 启用或禁用日志记录
				logging = true,
				-- 设置日志级别
				log_level = vim.log.levels.WARN,
				-- 所有格式化器配置都是手动启用的
				filetype = {
					-- 针对 "cpp" 文件类型的格式化器配置
					-- 这些格式化器会按顺序执行
					c = {
						function()
							return {
								exe = "clang-format",
								args = {
									"-assume-filename=",
									vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),
									'-style="{BasedOnStyle: llvm, IndentWidth: 2, UseTab: Never}"',
								},
								stdin = true,
							}
						end,
					},

					cpp = {
						function()
							return {
								exe = "clang-format",
								args = {
									"-assume-filename=",
									vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),
									'-style="{BasedOnStyle: llvm, IndentWidth: 2, UseTab: Never}"',
								},
								stdin = true,
							}
						end,
					},
					json = { require("formatter.filetypes.json").prettier }, -- 使用 prettier 格式化
					python = { require("formatter.filetypes.python").autopep8 }, -- 使用 autopep8 格式化
					rust = { require("formatter.filetypes.rust").rustfmt }, -- 使用 rustfmt 格式化
					lua = {
						-- "formatter.filetypes.lua" 定义了 Lua 文件类型的默认配置
						require("formatter.filetypes.lua").stylua,

						-- 你也可以定义自己的配置
						function()
							-- 支持条件格式化
							if util.get_current_buffer_file_name() == "special.lua" then
								return nil -- 如果当前文件名是 special.lua，则跳过格式化
							end

							-- 完整配置的定义如下，并在 Vim 帮助文件中也有说明
							return {
								exe = "stylua", -- 使用 stylua 格式化
								args = {
									"--search-parent-directories", -- 搜索父目录
									"--stdin-filepath", -- 传递当前文件路径
									util.escape_path(util.get_current_buffer_file_path()), -- 获取并转义当前缓冲区的文件路径
									"--", -- 标志文件内容从标准输入中传递
									"-",
								},
								stdin = true, -- 标志内容通过标准输入传递
							}
						end,
					},

					-- 使用特殊的 "*" 文件类型定义对所有文件的格式化行为
					["*"] = {
						-- "formatter.filetypes.any" 定义了对任意文件类型的默认配置
						require("formatter.filetypes.any").remove_trailing_whitespace, -- 删除多余空格
					},
				},
			})
			-- 保存时自动格式化
			vim.api.nvim_exec(
				[[
    augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost *.{lua,py,cpp}  FormatWrite
    augroup END
]],
				true -- 执行 Vim 脚本
			)
		end,
	},
}
