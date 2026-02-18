-- ~/.config/nvim/init.lua

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic UI/UX
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 200
vim.opt.timeoutlen = 400
vim.opt.clipboard = "unnamedplus"
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Line Numbering
vim.opt.number = true
vim.opt.relativenumber = true
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    vim.opt.relativenumber = false
  end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    vim.opt.relativenumber = true
  end,
})

-- Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true

-- Neovide-specific tweaks
if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font:h12"
  vim.g.neovide_scale_factor = 1.0
  vim.g.neovide_cursor_vfx_mode = "railgun" -- or "pixiedust", "sonicboom", or nil
  vim.g.neovide_input_macos_alt_is_meta = false
end

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

if vim.g.neovide then
  vim.keymap.set("n", "<C-=>", function() vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1 end)
  vim.keymap.set("n", "<C-->", function() vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1 end)
  vim.keymap.set("n", "<C-0>", function() vim.g.neovide_scale_factor = 1.0 end)
  
  vim.o.guifont = "JetBrainsMono NFM:h12"
end

require("rust_on_save").setup()
