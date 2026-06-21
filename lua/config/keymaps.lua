-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>ya", function()
  vim.cmd("silent %y+")
  vim.notify("Copied entire file to clipboard")
end, {
  desc = "Copy entire file to clipboard",
})
