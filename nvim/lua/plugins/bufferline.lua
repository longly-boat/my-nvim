return {
    {
      'akinsho/bufferline.nvim',
      version = "*",
      dependencies = { 'nvim-tree/nvim-web-devicons', "moll/vim-bbye" },
      config = function()
        require("bufferline").setup({
          options = {
            mode = "buffers", -- 模式设置为 "buffers"，也可以设置为 "tabs"
            style_preset = require("bufferline").style_preset.default, -- 使用默认样式预设
            themable = true, -- 是否允许重写高亮组
            numbers = "none", -- 数字显示方式，可选 "none"、"ordinal"、"buffer_id"、"both"
            close_command = "Bdelete! %d", -- 使用 moll/vim-bbye 的 :Bdelete 命令
            right_mouse_command = "Bdelete! %d", -- 右键关闭缓冲区的命令
            left_mouse_command = "buffer %d", -- 左键切换缓冲区的命令
            middle_mouse_command = nil, -- 中键的默认行为
            indicator = {
              icon = '▎', -- 指示器图标
              style = 'icon', -- 指示器样式，可选 "icon"、"underline" 或 "none"
            },
            buffer_close_icon = '󰅖', -- 关闭缓冲区的图标
            modified_icon = '● ', -- 修改状态的图标
            close_icon = ' ', -- 关闭按钮的图标
            left_trunc_marker = ' ', -- 左侧截断标记
            right_trunc_marker = ' ', -- 右侧截断标记
            name_formatter = nil, -- 自定义缓冲区名称格式化函数
            max_name_length = 18, -- 缓冲区名称的最大显示长度
            max_prefix_length = 15, -- 缓冲区去重时的前缀长度
            truncate_names = true, -- 是否截断名称
            tab_size = 18, -- Tab 的宽度
            diagnostics = "coc", -- 使用 nvim 内置 LSP
            diagnostics_update_in_insert = true, -- 是否在插入模式更新诊断信息
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
              local s = " "
              for e, n in pairs(diagnostics_dict) do
                local sym = e == "error" and " " or (e == "warning" and " " or "")
                s = s .. n .. sym
              end
              return s
            end,
            custom_filter = nil, -- 自定义过滤规则
            offsets = { -- 侧边栏配置
              {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                text_align = "left",
              },
            },
            color_icons = true, -- 是否为文件类型图标添加颜色高亮
            show_buffer_icons = true, -- 是否显示缓冲区的文件类型图标
            show_buffer_close_icons = true, -- 是否显示缓冲区关闭图标
            show_close_icon = true, -- 是否显示整体关闭图标
            show_tab_indicators = true, -- 是否显示 Tab 指示器
            duplicates_across_groups = true, -- 是否在不同分组间视为重复路径
            persist_buffer_sort = true, -- 是否保持自定义的缓冲区排序
            separator_style = "slant", -- 分隔符样式
            enforce_regular_tabs = false, -- 是否强制使用常规 Tab 样式
            always_show_bufferline = true, -- 是否始终显示缓冲区线
            hover = {
              enabled = true, -- 是否启用悬停功能
              delay = 200, -- 延迟时间（毫秒）
              reveal = { 'close' }, -- 悬停时显示的元素
            },
            sort_by = 'insert_after_current', -- 缓冲区排序方式
          },
        })
      end,
    }
  }
