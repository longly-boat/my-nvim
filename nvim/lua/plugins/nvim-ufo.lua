return {
  {
    "kevinhwang91/nvim-ufo", -- 主插件：用于增强 Neovim 折叠功能
    lazy = true, -- 懒加载：插件仅在特定条件下加载
    cmd = { "UfoDisable", "UfoEnable" }, -- 指定懒加载触发命令
    dependencies = {
      "kevinhwang91/promise-async", -- 异步库，是 nvim-ufo 的依赖项
    },
    config = function()
      -- 基础折叠设置
      vim.o.foldcolumn = "1" -- 设置折叠列宽度为 1
      vim.o.foldlevel = 99 -- 设置折叠级别，99 表示展开所有折叠
      vim.o.foldlevelstart = 99 -- 打开文件时的默认折叠级别
      vim.o.foldenable = true -- 启用折叠功能

      -- 定义自定义高亮组，用于折叠的补充文本
      vim.cmd([[highlight AdCustomFold guifg=#bf8040]])

      -- 自定义折叠虚拟文本处理器
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {} -- 新的虚拟文本表
        local suffix = ("  %d "):format(endLnum - lnum) -- 折叠显示的行数差（后缀）
        local sufWidth = vim.fn.strdisplaywidth(suffix) -- 后缀的显示宽度
        local targetWidth = width - sufWidth -- 虚拟文本的目标宽度
        local curWidth = 0 -- 当前虚拟文本的宽度计数

        -- 遍历当前的虚拟文本内容
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1] -- 文本内容
          local chunkWidth = vim.fn.strdisplaywidth(chunkText) -- 文本宽度
          if targetWidth > curWidth + chunkWidth then
            -- 如果当前宽度未超出目标宽度，直接添加
            table.insert(newVirtText, chunk)
          else
            -- 如果超出目标宽度，截断文本
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2] -- 文本的高亮组
            table.insert(newVirtText, { chunkText, hlGroup }) -- 添加截断后的文本
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- 如果截断后宽度不足目标宽度，填充空格
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth -- 更新当前宽度
        end

        -- 读取当前折叠的第二行内容（如果有）
        local lines = vim.api.nvim_buf_get_lines(0, lnum, lnum + 1, false)
        local secondLine = nil
        if #lines == 1 then
          secondLine = lines[1] -- 单行折叠时，取当前行内容
        elseif #lines > 1 then
          secondLine = lines[2] -- 多行折叠时，取第二行内容
        end
        if secondLine ~= nil then
          -- 将第二行内容添加到虚拟文本中，并使用自定义高亮
          table.insert(newVirtText, { secondLine, "AdCustomFold" })
        end

        -- 添加后缀，显示折叠的行数
        table.insert(newVirtText, { suffix, "MoreMsg" })

        return newVirtText -- 返回最终的虚拟文本
      end

      -- 配置 nvim-ufo 插件
      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          -- 指定折叠提供者，这里使用 treesitter 和缩进
          return { "treesitter", "indent" }
        end,
        fold_virt_text_handler = handler, -- 设置自定义虚拟文本处理器
      })
    end,
  }
}

