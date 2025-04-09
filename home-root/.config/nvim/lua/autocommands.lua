-- Filetypes
vim.cmd([[
augroup ftype_group
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType python,py setlocal textwidth=120 ts=4 sts=4 sw=4 foldmethod=indent
    autocmd FileType cpp,c,h,hpp setlocal ts=4 sts=4 sw=4 foldenable foldmethod=syntax
    autocmd FileType java,hs,js,tex,latex setlocal foldenable foldmethod=syntax
    autocmd FileType txt,text,tex,latex setlocal spell spelllang=ru,en
augroup END
]])

vim.api.nvim_create_autocmd(
    {"BufRead", "BufNewFile"},
    {
        pattern = {
            'ya.make',
            'ya.make.inc',
            'ya.inc'
            -- 'include.inc',
            -- 'recipe.inc'
            -- ...
            -- other commonly used patterns
        },
        callback = function()
            vim.o.filetype = 'yamake'
        end
    }
)

vim.api.nvim_create_autocmd(
    {"BufRead", "BufNewFile"},
    {
        pattern = {
            '*.j2',
            '*.jinja',
        },
        callback = function()
            vim.o.filetype = 'jinja'
        end
    }
)

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
    autocmd BufWritePre *.sql FormatSql
augroup END
]])

-- For already touched files - open them in readonly
vim.cmd([[
autocmd SwapExists * let v:swapchoice = "o"
]])

-- For some reason, automatic line numbers don't work, so we do this
-- The only filetype that we want to avoid is `NvimTree`
vim.cmd([[
augroup ShowLineNumberForShortFiles
  autocmd!
  autocmd BufEnter * if &ft != 'NvimTree' | setlocal number | endif
augroup END
]])
