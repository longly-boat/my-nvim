return {
	{
    
		"neoclide/coc.nvim",
		branch = "release",
		config = function()
			-- 某些语言服务器在处理备份文件时可能会出现问题，详见问题 #649
			vim.opt.backup = false
			vim.opt.writebackup = false
			-- 设置较短的 `updatetime`（默认是 4000 毫秒 = 4 秒），以减少延迟并提升用户体验
			vim.opt.updatetime = 300

			-- 始终显示 `signcolumn`，避免每次诊断信息出现或消失时文本发生位移
			vim.opt.signcolumn = "yes"

			-- 配置全局扩展列表
			vim.g.coc_global_extensions = {
				"coc-json",
				"coc-css",
				"coc-clangd",
				"coc-cmake",
				"coc-docker",
				"coc-java",
				"coc-pyright",
				"coc-sh",
				"coc-sql",
				"coc-lua",
			}

			local keyset = vim.keymap.set

			-- 自动补全功能
			function _G.check_back_space()
				local col = vim.fn.col(".") - 1
				return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
			end

			-- 使用 Tab 键触发补全并导航
			-- 注意：默认情况下总是会选中一个补全项。如果希望禁用默认选择，可在配置文件中设置 `"suggest.noselect": true`
			-- 注意：使用命令 `:verbose imap <tab>` 确保 Tab 未被其他插件映射，然后将以下代码放入您的配置文件中
			local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
			keyset(
				"i",
				"<TAB>",
				'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
				opts
			)
			keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

			-- 按下回车键 `<CR>` 选择补全项或通知 coc.nvim 执行格式化
			-- `<C-g>u` 会打断当前撤销链，请根据需要决定是否保留
			keyset(
				"i",
				"<CR>",
				[[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]],
				opts
			)
      
			-- 使用 `<c-j>` 快捷键触发代码片段跳转
			keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")

			-- 使用 `<c-space>` 快捷键打开补全列表
			keyset("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })

			-- 使用 `[g` 和 `]g` 导航诊断信息
			-- 使用 `:CocDiagnostics` 查看当前缓冲区的所有诊断信息（显示在位置列表中）
			keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
			keyset("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })

			-- 代码导航功能
			keyset("n", "gd", "<Plug>(coc-definition)", { silent = true }) -- 跳转到定义
			keyset("n", "gy", "<Plug>(coc-type-definition)", { silent = true }) -- 跳转到类型定义
			keyset("n", "gi", "<Plug>(coc-implementation)", { silent = true }) -- 跳转到实现
			keyset("n", "gr", "<Plug>(coc-references)", { silent = true }) -- 查看引用

			-- 使用 K 键在预览窗口中显示文档
			function _G.show_docs()
				local cw = vim.fn.expand("<cword>")
				if vim.fn.index({ "vim", "help" }, vim.bo.filetype) >= 0 then
					vim.api.nvim_command("h " .. cw) -- 在帮助文档中查找
				elseif vim.api.nvim_eval("coc#rpc#ready()") then
					vim.fn.CocActionAsync("doHover") -- 调用 CocAction 显示悬停文档
				else
					vim.api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw) -- 使用关键字程序显示文档
				end
			end
			keyset("n", "K", "<CMD>lua _G.show_docs()<CR>", { silent = true })

			-- 在 CursorHold 事件（光标停留时）高亮符号及其引用
			vim.api.nvim_create_augroup("CocGroup", {})
			vim.api.nvim_create_autocmd("CursorHold", {
				group = "CocGroup",
				command = "silent call CocActionAsync('highlight')",
				desc = "在 CursorHold 时高亮光标下的符号",
			})

			-- 符号重命名
			keyset("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true })

			-- 格式化选中代码
			keyset("x", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })
			keyset("n", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })

			-- 为特定文件类型设置 `formatexpr`
			vim.api.nvim_create_autocmd("FileType", {
				group = "CocGroup",
				pattern = "typescript,json",
				command = "setl formatexpr=CocAction('formatSelected')",
				desc = "为指定的文件类型设置 formatexpr",
			})

			-- 在跳转占位符时更新签名帮助
			vim.api.nvim_create_autocmd("User", {
				group = "CocGroup",
				pattern = "CocJumpPlaceholder",
				command = "call CocActionAsync('showSignatureHelp')",
				desc = "在跳转占位符时更新签名帮助",
			})
			-- 将代码操作应用到选定区域
			-- 示例：`<leader>aap` 应用于当前段落
			local opts = { silent = true, nowait = true }
			keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts) -- 选中区域代码操作
			keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts) -- 当前行代码操作

			-- 重新映射键以在光标位置应用代码操作
			keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts) -- 应用光标位置的代码操作
			-- 重新映射键以应用影响整个缓冲区的代码操作
			keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts) -- 整个缓冲区代码操作
			-- 重新映射键以应用代码操作到当前缓冲区
			keyset("n", "<leader>ac", "<Plug>(coc-codeaction)", opts) -- 当前缓冲区代码操作
			-- 对当前行应用优先级最高的快速修复操作
			keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts) -- 当前行快速修复

			-- 重新映射键以应用代码重构操作
			keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true }) -- 重构操作
			keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true }) -- 选中区域的重构操作
			keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true }) -- 当前行的重构操作

			-- 在当前行运行代码镜头（Code Lens）操作
			keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts) -- 运行代码镜头操作

			-- 映射函数和类的文本对象
			-- 注意：需要语言服务器支持 'textDocument.documentSymbol'
			keyset("x", "if", "<Plug>(coc-funcobj-i)", opts) -- 函数内部
			keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
			keyset("x", "af", "<Plug>(coc-funcobj-a)", opts) -- 函数全部
			keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
			keyset("x", "ic", "<Plug>(coc-classobj-i)", opts) -- 类内部
			keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
			keyset("x", "ac", "<Plug>(coc-classobj-a)", opts) -- 类全部
			keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)

			-- 重新映射 <C-f> 和 <C-b> 用于滚动浮动窗口/弹窗
			---@diagnostic disable-next-line: redefined-local
			local opts = { silent = true, nowait = true, expr = true }
			keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts) -- 向下滚动
			keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts) -- 向上滚动
			keyset("i", "<C-f>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts) -- 插入模式下向下滚动
			keyset("i", "<C-b>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts) -- 插入模式下向上滚动
			keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts) -- 可视模式下向下滚动
			keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts) -- 可视模式下向上滚动

			-- 使用 CTRL-S 进行选择范围
			-- 需要语言服务器支持 'textDocument/selectionRange'
			keyset("n", "<C-s>", "<Plug>(coc-range-select)", { silent = true }) -- 普通模式下启用范围选择
			keyset("x", "<C-s>", "<Plug>(coc-range-select)", { silent = true }) -- 可视模式下启用范围选择

			-- 添加 `:Format` 命令用于格式化当前缓冲区
			vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

			-- 添加 `:Fold` 命令用于折叠当前缓冲区
			vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = "?" })

			-- 添加 `:OR` 命令用于整理当前缓冲区的导入
			vim.api.nvim_create_user_command(
				"OR",
				"call CocActionAsync('runCommand', 'editor.action.organizeImport')",
				{}
			)

			-- 添加 (Neo)Vim 原生的状态栏支持
			-- 注意：请参考 `:h coc-status` 获取与提供自定义状态栏的外部插件（如 lightline.vim、vim-airline）的集成方式
			vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

			-- CoCList 的按键映射
			-- 与代码操作和 CoC 相关功能
			---@diagnostic disable-next-line: redefined-local
			local opts = { silent = true, nowait = true }

			-- 显示所有诊断信息
			keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", opts)

			-- 管理扩展
			keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)

			-- 显示命令
			keyset("n", "<space>c", ":<C-u>CocList commands<cr>", opts)

			-- 查找当前文档的符号
			keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)

			-- 搜索工作区符号
			keyset("n", "<space>s", ":<C-u>CocList -I symbols<cr>", opts)

			-- 对下一个项目执行默认操作
			keyset("n", "<space>j", ":<C-u>CocNext<cr>", opts)

			-- 对上一个项目执行默认操作
			keyset("n", "<space>k", ":<C-u>CocPrev<cr>", opts)

			-- 恢复最近的 coc 列表
			keyset("n", "<space>p", ":<C-u>CocListResume<cr>", opts)
		end,
	},
}
