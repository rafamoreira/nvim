-- ./init.lua

-- 1. Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 2. Map leader key BEFORE loading lazy (very important!)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 3. Setup lazy and tell it to load the `lua/plugins/` directory
require("lazy").setup("plugins")

-- Load options, keymaps, autocmds first
-- require("config.options")
-- require("config.keymaps")
-- require("config.autocmds")

