-- 引导 lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- 如果 lazy.nvim 尚未安装，则从指定仓库克隆
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    -- 如果克隆失败，输出错误信息并提示用户按任意键退出
    vim.api.nvim_echo({
      { "克隆 lazy.nvim 失败:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\n按任意键退出..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
-- 将 lazy.nvim 的路径添加到运行时路径中
vim.opt.rtp:prepend(lazypath)

-- 确保在加载 lazy.nvim 之前设置 `mapleader` 和 `maplocalleader`，
-- 以确保按键映射正确。
-- 这里也是设置其他配置（vim.opt）的好地方
vim.g.mapleader = " "  -- 设置全局 leader 键为空格
vim.g.maplocalleader = "\\"  -- 设置本地 leader 键为反斜杠

-- 配置 lazy.nvim
require("lazy").setup({
  spec = {
    -- 导入插件配置
    { import = "plugins" },
  },
  -- 在这里配置其他设置。请参阅文档以了解更多细节。 
  -- 安装插件时使用的配色方案
  install = { colorscheme = { "habamax" } },
  -- 自动检查插件更新
  checker = { enabled = true },
})

