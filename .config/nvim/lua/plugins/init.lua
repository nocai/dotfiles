vim.cmd("packadd packer.nvim")
return require("packer").startup(function()
    -- basic
    use {"wbthomason/packer.nvim", opt = true}
    use "tpope/vim-repeat"
    use "tpope/vim-surround"
    use "tpope/vim-unimpaired"
    use "tpope/vim-commentary"

    -- additional functionality
    use "wellle/targets.vim"
    use {
        "windwp/nvim-autopairs",
        config = function() require("plugins.autopairs") end
    }
    use {
        "svermeulen/vim-subversive",
        config = function() require("plugins.subversive") end
    }
    use {
        "svermeulen/vim-cutlass",
        config = function() require("plugins.cutlass") end
    }
    use {
        "SirVer/ultisnips",
        config = function() require("plugins.ultisnips") end
    }
    use {"phaazon/hop.nvim", config = function() require("plugins.hop") end}

    -- integrations
    use {
        "junegunn/fzf.vim",
        requires = {"junegunn/fzf"},
        run = function() vim.fn["fzf#install"]() end,
        config = function() require("plugins.fzf") end
    }
    use {
        "numToStr/Navigator.nvim",
        config = function() require("plugins.navigator") end
    }
    use {"vifm/vifm.vim", config = function() require("plugins.vifm") end}
    use "ojroques/nvim-lspfuzzy"
    use "wellle/tmux-complete.vim"

    -- development
    use "neovim/nvim-lspconfig"
    use "nvim-lua/plenary.nvim"
    use {
        "mfussenegger/nvim-dap",
        config = function() require("plugins.dap") end
    }
    use "~/git/nvim-lsp-ts-utils"
    use {
        "lewis6991/gitsigns.nvim",
        config = function() require("plugins.gitsigns") end
    }
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function() require("plugins.treesitter") end
    }
    use "JoosepAlviste/nvim-ts-context-commentstring"
    use {"windwp/nvim-ts-autotag", requires = "nvim-treesitter/nvim-treesitter"}
    use {
        "vim-test/vim-test",
        config = function() require("plugins.vim-test") end
    }

    -- visual
    use {
        "~/git/buftabline.nvim",
        config = function() require("plugins.buftabline") end
    }
    use {
        "RRethy/vim-illuminate",
        config = function() require("plugins.illuminate") end
    }
    use "sainnhe/sonokai"

    -- misc
    use {
        "iamcco/markdown-preview.nvim",
        ft = {"md", "mkdn", "markdown"},
        config = {"vim.cmd[[doautocmd BufEnter]]"},
        run = "cd app && yarn install",
        cmd = "MarkdownPreview"
    }
    use "dag/vim-fish"
end)
