-- Filetypes
vim.cmd([[
augroup ftype_group
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType python,py setlocal textwidth=80 ts=4 sts=4 sw=4 foldmethod=indent
    autocmd FileType cpp,c,h,hpp setlocal ts=4 sts=4 sw=4 foldenable foldmethod=syntax
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
