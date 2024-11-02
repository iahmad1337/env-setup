local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

-- Custom plugins
require('setup/codesearch')

-- `use` is a dummy parameter that prevents some spurious errors
return require('packer').startup(function(use)
    use "wbthomason/packer.nvim" -- without this some strange things will happen on PackerUpdate
    use 'michaeljsmith/vim-indent-object' -- ai ii aI
    use 'kana/vim-textobj-user' -- necessary for the following
    use 'kana/vim-textobj-entire' -- ae ie
    use 'tommcdo/vim-exchange'  -- cx<motion> cxx X(visual) cxc(cancel)
    use {
        'iahmad1337/argtextobj.vim',
        config = function() require('setup/argtextobj') end
    } -- aa ia
    use 'iahmad1337/sql-format.nvim'
    use {
        'cdelledonne/vim-cmake',
        config = function() require('setup/vim-cmake') end
    }
    use 'tpope/vim-surround'
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    use {
        'sonph/onehalf',
        rtp = 'vim',
        config = function()
            vim.cmd [[colorscheme onehalfdark]]
        end,
        event = 'VimEnter'
    }
    use {
        'vim-airline/vim-airline',
        config = function() require('setup/airline') end
    }
    use {
        'kyazdani42/nvim-tree.lua',
        config = function() require('setup/nvim-tree') end
    }
    use {
        'sirver/ultisnips',
        config = function() require('setup/ultisnips') end
    }
    use 'honza/vim-snippets'
    use {
        'junegunn/fzf',
        run = function() vim.fn['fzf#install']() end
    }
    use {
        'junegunn/fzf.vim',
        config = function() require('setup/fzf') end
    }
    use {
        'voldikss/vim-floaterm',
        config = function() require('setup/floaterm') end
    }
    use {
        'mhinz/vim-startify',
        config = function() require('setup/startify') end
    }
    use 'vim-scripts/vcscommand.vim'
    use 'mhinz/vim-signify'
    use {
        -- This is barely needed since I set up things manually anyway
        -- It is only good for LSPs that I want to work right out of the box
        'https://github.com/neovim/nvim-lspconfig',
        config = function() require('setup/nvim-lspconfig') end
    }
    -- use {
    --     'mfussenegger/nvim-lint',
    --     config = function () require('setup/nvim-lint') end
    -- }
    use 'justinmk/vim-sneak'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'quangnguyen30192/cmp-nvim-ultisnips'  -- needed for ultisnips and nvim-cmp interop
    use {
        'hrsh7th/nvim-cmp',
        config = function()
            require('setup/nvim-cmp')
        end
    }

    if packer_bootstrap then
        require('packer').sync()
    end
end)
