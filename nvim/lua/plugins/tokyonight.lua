return {
  {
    
    "folke/tokyonight.nvim",  -- Tokyonight 主题插件
    lazy = false,  -- 禁用延迟加载，插件在启动时立即加载
    priority = 1000,  -- 插件加载优先级，值越大越优先加载
    opts = {},  -- 配置选项（可以为空）
    config = function()
      require("tokyonight").setup({
    -- 您的配置可以在这里添加
    -- 或者留空以使用默认设置
    style = "moon", -- 主题提供三种样式：`storm`、`moon`，以及一个更暗的变体 `night` 和 `day`
    light_style = "moon", -- 在背景设置为浅色时使用的主题样式
    transparent = false, -- 启用此选项以禁用背景颜色的设置
    terminal_colors = true, -- 配置在 [Neovim](https://github.com/neovim/neovim) 中打开 `:terminal` 时使用的颜色
    styles = {
      -- 应用于不同语法组的样式
      -- 值可以是任何有效的 `:help nvim_set_hl` 中的 attr-list 属性
      comments = { italic = true }, -- 评论字体设置为斜体
      keywords = { italic = true }, -- 关键字字体设置为斜体
      functions = {}, -- 函数的样式（留空使用默认样式）
      variables = {}, -- 变量的样式（留空使用默认样式）
      -- 背景样式，可以是 "dark"（深色）、"transparent"（透明） 或 "normal"（正常）
      sidebars = "dark", -- 侧边栏的样式
      floats = "dark", -- 浮动窗口的样式
    },
  
    sidebars = { "qf", "help" }, -- 为类似侧边栏的窗口设置深色背景。例如：`["qf", "vista_kind", "terminal", "packer"]`
    day_brightness = 0.3, -- 调整 **Day** 样式颜色的亮度。范围是 0 到 1，数值越小颜色越暗淡，数值越大颜色越鲜艳
    hide_inactive_statusline = false, -- 启用此选项时，隐藏非活动窗口的状态栏，并用一个细边框代替。适用于标准的 **StatusLine** 和 **LuaLine**
    dim_inactive = false, -- 使非活动窗口变暗
    lualine_bold = false, -- 当设置为 `true` 时，lualine 主题的分段标题将以加粗样式显示
    
    --- 可以覆盖特定的颜色组，使用其他组或十六进制颜色
    --- 该函数将接收一个 ColorScheme 表作为参数
    ---@param colors ColorScheme
    on_colors = function(colors) end,
    
    --- 可以覆盖特定的高亮组，使用其他组或十六进制颜色
    --- 该函数将接收一个 Highlights 表和 ColorScheme 表作为参数
    ---@param highlights Highlights
    ---@param colors ColorScheme
    on_highlights = function(highlights, colors) end,
    })
        end
    
}
  
}
