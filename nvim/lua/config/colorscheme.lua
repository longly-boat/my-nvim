local colorscheme = "tokyonight"
local status_ok, err = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("无法加载主题 " .. colorscheme .. "，错误信息：" .. tostring(err), vim.log.levels.ERROR)
  return
end
