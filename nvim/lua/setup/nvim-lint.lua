require('lint').linters_by_ft = {
  python = {'flake8'},
  sh = {'shellcheck'}
}

vim.cmd([[
augroup linting_autocmds
    autocmd!
    autocmd BufWritePost * lua require('lint').try_lint()
    autocmd BufWinEnter * lua require('lint').try_lint()
augroup END
]])
