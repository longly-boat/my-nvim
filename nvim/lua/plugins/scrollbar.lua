return {
  {
    'petertriho/nvim-scrollbar',
    config = function()
      require("scrollbar").setup({
        show = true, -- 是否显示滚动条
        handle = {
          color = "#6C7D8A", -- 滚动条的颜色
        },
        marks = {
          Search = { color = "#EBCB8B" }, -- 搜索高亮
          Error = { color = "#BF616A" }, -- 错误高亮
          Warn = { color = "#EBCB8B" }, -- 警告高亮
          Info = { color = "#A3BE8C" }, -- 信息高亮
          Hint = { color = "#88C0D0" }, -- 提示高亮
          Misc = { color = "#D08770" }, -- 其他高亮
        },
        excluded_buftypes = { "terminal" }, -- 排除某些缓冲区类型
        excluded_filetypes = { "prompt", "TelescopePrompt" }, -- 排除某些文件类型
        handlers = {
          cursor = true, -- 显示光标位置
          diagnostic = true, -- 显示诊断信息位置
          search = true, -- 显示搜索匹配位置
        },
      })
    end,
  }
}

