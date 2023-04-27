-- 基础设置
require('basic')
require("keybindings")
require("plugins")
require("colorscheme")
-- 插件配置
require("plugin-config.nvim-tree")
require("plugin-config.bufferline")
require("plugin-config.lualine")
require("plugin-config.telescope")
require("plugin-config.nvim-treesitter")
require("plugin-config.startscreen").config()
require("plugin-config.coc-nvim")

