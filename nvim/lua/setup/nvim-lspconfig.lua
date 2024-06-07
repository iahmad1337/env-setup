-- Based on https://github.com/neovim/nvim-lspconfig example configuration

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gdec', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gotod', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gimpl', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<C-n>', vim.lsp.buf.completion, bufopts)
  vim.keymap.set('n', 'gdeft', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gref', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'gdiag', vim.diagnostic.open_float, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- WHy the fuck are there two places that setup lsp??? (the second one is in
-- setup/nvim-cmp.lua)
require('lspconfig')['clangd'].setup{
    cmd = {'clangd', '--clang-tidy'},
    filetypes = { 'c', 'cpp', 'cc', 'objc', 'objcpp', 'cuda' },
    on_attach = on_attach,
    flags = lsp_flags
}


-- do `pip install 'python-lsp-server[all]'`
require('lspconfig')['pylsp'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    -- capabilities = capabilities,
    settings = {
        -- formatCommand = {'black'},
        pylsp = {
            -- configurationSources = {'flake8'},
            plugins = {
                -- pylint = { enabled = true, },
                -- flake8 = { enabled = true, },
                -- maccabe = { enabled = false, },
                -- pyflakes = { enabled = false, },
                -- autopep8 = { enabled = false, },
                -- yapf = { enabled = false, },
                jedi = {
                    extra_paths = {
                        -- List all of the paths that have python modules
                        -- defined in them
                    },
                },
                -- flake8 = {
                --     enabled = true,
                --     config = '/home/ahmad1337/.config/flake8',
                -- },
        --         black = { enabled = true, },
            }
        }
    }
}
