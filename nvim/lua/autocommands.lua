-- Filetypes
vim.cmd([[
augroup ftype_group
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType cpp,c,h,hpp setlocal ts=2 sts=2 sw=2 foldenable foldmethod=syntax
    autocmd FileType java,hs,js,tex,latex setlocal foldenable foldmethod=syntax
    autocmd FileType txt,text,tex,latex setlocal spell spelllang=ru,en
augroup END
]])

-- On save
vim.cmd([[
fun! TrimWhitespace()
    let l:save = winsaveview()
    keepjumps keeppatterns silent! %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup my_autocmd_group
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END
]])
