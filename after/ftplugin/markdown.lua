-- Markdown-specific editing behavior

vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true

-- Required for Markdown conceal behavior like hiding parts of links/images.
vim.opt_local.conceallevel = 2

-- Enable Vim spell checking for Markdown.
vim.opt_local.spell = true
vim.opt_local.spelllang = { "en_us" }

-- The article uses Vim's spellfile and feeds it into LTeX.
vim.opt_local.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"

-- Markdown usually feels better with 2-space indentation.
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true
