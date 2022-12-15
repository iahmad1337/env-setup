vim.cmd([[
    " move to the next window in normal mode
    nnoremap <space>h <C-w>h
    nnoremap <space>j <C-w>j
    nnoremap <space>k <C-w>k
    nnoremap <space>l <C-w>l
]])

-- Better escape-sequence
vim.cmd([[
    inoremap jk <ESC>
    inoremap kj <ESC>
    cnoremap jk <ESC>
    cnoremap kj <ESC>
    tnoremap jk <ESC>
    tnoremap kj <ESC>
]])

-- Yank till EOL
vim.cmd [[nnoremap Y v$y]]

-- search and replace the selection
vim.cmd [[vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>]]

-- Move chunks up and down
vim.cmd [[
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '>-2<CR>gv=gv
]]
