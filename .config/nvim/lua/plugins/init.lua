vim.cmd("packadd packer.nvim")
return require("packer").startup(function()
    -- basic
    use {"wbthomason/packer.nvim", opt = true}
    use "tpope/vim-commentary"
    use "tpope/vim-repeat"
    use "tpope/vim-surround"
    use "tpope/vim-unimpaired"
    use "tpope/vim-vinegar"

    -- additional functionality
    use {"phaazon/hop.nvim", config = function() require("plugins.hop") end}
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
    use {"hrsh7th/nvim-compe", config = function() require("plugins.compe") end}
    use {"hrsh7th/vim-vsnip", config = function() require("plugins.vsnip") end}

    -- integrations
    use "christoomey/vim-tmux-navigator"
    use {
        "junegunn/fzf.vim",
        requires = {"junegunn/fzf"},
        run = "fzf#install()",
        config = function() require("plugins.fzf") end
    }
    use {
        "christoomey/vim-tmux-runner",
        config = function() require("plugins.vtr") end
    }

    -- text objects
    use "wellle/targets.vim"
    use {"kana/vim-textobj-entire", requires = {"kana/vim-textobj-user"}}
    use {
        "beloglazov/vim-textobj-punctuation",
        requires = {"kana/vim-textobj-user"}
    }
    use {
        "Julian/vim-textobj-variable-segment",
        requires = {"kana/vim-textobj-user"}
    }
    use {
        "inside/vim-textobj-jsxattr",
        requires = {"kana/vim-textobj-user"},
        ft = {"javascriptreact", "typescriptreact"}
    }

    -- development
    use "neovim/nvim-lspconfig"
    use {
        "lewis6991/gitsigns.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function() require("plugins.gitsigns") end
    }
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function() require("plugins.treesitter") end
    }
    use "sheerun/vim-polyglot"
    use {
        "vim-test/vim-test",
        config = function() require("plugins.vim-test") end
    }
    use {
        "mfussenegger/nvim-dap",
        config = function() require("plugins.dap") end
    }
    use {"theHamsta/nvim-dap-virtual-text", requires = "mfussenegger/nvim-dap"}

    -- visual
    use {
        "ap/vim-buftabline",
        config = function() require("plugins.buftabline") end
    }
    use "sainnhe/sonokai"
    use "ghifarit53/tokyonight-vim"
    use "RRethy/vim-illuminate"
    use "antoinemadec/FixCursorHold.nvim"

    -- other
    use {
        "iamcco/markdown-preview.nvim",
        ft = {"md", "mkdn", "markdown"},
        config = {"vim.cmd[[doautocmd BufEnter]]"},
        run = "cd app && yarn install",
        cmd = "MarkdownPreview"
    }
end)
