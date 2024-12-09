vim.o.shada = "!,'1337,<50,s10,h"

vim.o.autochdir = true

vim.o.scrolloff = 5
vim.o.foldenable = true

vim.o.foldmethod = 'manual'

vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

vim.o.textwidth = 80
vim.o.hls = false

vim.o.cursorline = true
vim.o.number = true

-----------------
--  Incsearch  --
-----------------
vim.o.incsearch = true
vim.o.hlsearch = false
vim.o.ignorecase = true

------------------
--  Completion  --
------------------
-- Primeagen does 'menuone,noinsert,noselect'
vim.o.completeopt = 'menu,preview,longest'

vim.cmd('filetype plugin indent on')
vim.o.encoding = 'utf-8'
vim.o.compatible = false
vim.o.syntax = 'enable'

-- Highlight yanked text
vim.cmd('au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=750}')

-- Russian keys
vim.cmd("set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz")

vim.o.wildmenu = true

-- highlight trailing whitespaces and todo's
vim.cmd([[
    match Error /\v\s+$/
    2match Underlined /\vTODO[^.]*/
]])

-------------------
--  Apppearance  --
-------------------
vim.o.termguicolors = true

-----------------------------------
--  Risky non-portable commands  --
-----------------------------------

vim.o.mouse = 'a'
