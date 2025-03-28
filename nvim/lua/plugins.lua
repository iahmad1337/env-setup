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
    use {
        'michaeljsmith/vim-indent-object',
        commit = '8ab36d5ec2a3a60468437a95e142ce994df598c6',
    } -- ai ii aI
    use {
        'kana/vim-textobj-user',
        commit = '41a675ddbeefd6a93664a4dc52f302fe3086a933',
    } -- necessary for the following
    use {
        'kana/vim-textobj-entire',
        commit = '64a856c9dff3425ed8a863b9ec0a21dbaee6fb3a',
    } -- ae ie
    use {
        'tommcdo/vim-exchange',
        commit = "d6c1e9790bcb8df27c483a37167459bbebe0112e",
    }  -- cx<motion> cxx X(visual) cxc(cancel)
    use {
        'iahmad1337/argtextobj.vim',
        commit = '4e21592600545dbed431d340fd28f8c4d59426a0',
        config = function() require('setup/argtextobj') end
    } -- aa ia
    use 'iahmad1337/sql-format.nvim'
    use {
        'tpope/vim-surround',
        commit = '3d188ed2113431cf8dac77be61b842acb64433d9',
    }
    use {
        'numToStr/Comment.nvim',
        commit = 'e30b7f2008e52442154b66f7c519bfd2f1e32acb',
        config = function()
            require('Comment').setup()
        end
    }
    use {
        'sonph/onehalf',
        commit = '75eb2e97acd74660779fed8380989ee7891eec56',
        rtp = 'vim',
        config = function()
            vim.cmd [[colorscheme onehalfdark]]
        end,
        event = 'VimEnter'
    }
    use {
        'vim-airline/vim-airline',
        commit = '6c704f4b780e2b687dd21b24a19f598dde06dc22',
        config = function() require('setup/airline') end
    }
    use {
        'kyazdani42/nvim-tree.lua',
        commit = '28eac2801b201f301449e976d7a9e8cfde053ba3',
        config = function() require('setup/nvim-tree') end
    }
    use {
        'sirver/ultisnips',
        commit = '35252b3327bf0cb55136399dfe615637093a8291',
        config = function() require('setup/ultisnips') end
    }
    use {
        'honza/vim-snippets',
        commit = 'f0a3184d9f90b96b044d5914625a25c554d7f301',
    }
    use {
        'junegunn/fzf',
        commit = '215ab48222ac5fa8855c1e5bbf56742276b57324',
        run = function() vim.fn['fzf#install']() end
    }
    use {
        'junegunn/fzf.vim',
        commit = '556f45e79ae5e3970054fee4c4373472604a1b4e',
        config = function() require('setup/fzf') end
    }
    use {
        'voldikss/vim-floaterm',
        commit = '4e28c8dd0271e10a5f55142fb6fe9b1599ee6160',
        config = function() require('setup/floaterm') end
    }
    use {
        'mhinz/vim-startify',
        commit = '4e089dffdad46f3f5593f34362d530e8fe823dcf',
        config = function() require('setup/startify') end
    }
    use {
        'vim-scripts/vcscommand.vim',
        commit = '2fb32681361f37533455d20aaa7fc6eb11b0fa4b',
    }
    use {
        'mhinz/vim-signify',
        commit = '8670143f9e12ed1cd3c9b2c54f345cdd9a4baac3',
    }
    use {
        -- This is barely needed since I set up things manually anyway
        -- It is only good for LSPs that I want to work right out of the box
        'https://github.com/neovim/nvim-lspconfig',
        config = 'd2d153a179ed59aa7134d7ebdf4d7dcb156efa22',
        config = function() require('setup/nvim-lspconfig') end
    }
    use {
        'justinmk/vim-sneak',
        commit = 'c13d0497139b8796ff9c44ddb9bc0dc9770ad2dd',
    }
    use {
        'hrsh7th/cmp-nvim-lsp',
        commit = '39e2eda76828d88b773cc27a3f61d2ad782c922d',
    }
    use {
        'hrsh7th/cmp-buffer',
        commit = '3022dbc9166796b644a841a02de8dd1cc1d311fa',
    }
    use {
        'hrsh7th/cmp-path',
        commit = '91ff86cd9c29299a64f968ebb45846c485725f23',
    }
    use {
        'hrsh7th/nvim-cmp',
        commit = 'f17d9b4394027ff4442b298398dfcaab97e40c4f',
        config = function()
            require('setup/nvim-cmp')
        end
    }

    if packer_bootstrap then
        require('packer').sync()
    end
end)
