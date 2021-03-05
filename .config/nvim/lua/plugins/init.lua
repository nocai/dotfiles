vim.cmd("packadd packer.nvim")
return require("packer").startup(function()
    -- basic
    use {"wbthomason/packer.nvim", opt = true}
    use "tpope/vim-commentary"
    use "tpope/vim-repeat"
    use "tpope/vim-surround"
    use "tpope/vim-unimpaired"

    -- additional functionality
    use {"phaazon/hop.nvim", config = function() require("plugins.hop") end}
    use {
        "windwp/nvim-autopairs",
        config = function()
            if (vim.api.nvim_eval("exists('g:vscode')") == 0) then
                require("plugins.autopairs")
            end
        end
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
        "svermeulen/vim-subversive",
        config = function() require("plugins.subversive") end
    }
    use {
        "svermeulen/vim-cutlass",
        config = function() require("plugins.cutlass") end
    }
    use {"hrsh7th/vim-vsnip", config = function() require("plugins.vsnip") end}
    use {"hrsh7th/nvim-compe", config = function() require("plugins.compe") end}
    use {"junegunn/vim-slash", config = function() require("plugins.slash") end}
    use {
        "ojroques/nvim-bufdel",
        config = function() require("plugins.bufdel") end
    }

    -- integrations
    use {
        "junegunn/fzf.vim",
        requires = {"junegunn/fzf"},
        run = function() vim.fn["fzf#install"]() end,
        config = function() require("plugins.fzf") end
    }
    use {
        "hrsh7th/nvim-compe",
        config = function()
            if (vim.api.nvim_eval("exists('g:vscode')") == 0) then
                require("plugins.compe")
            end
        end
    }

    -- integrations
    use {"junegunn/fzf.vim", requires = {"junegunn/fzf"}, run = "fzf#install()"}
    use "christoomey/vim-tmux-navigator"
    use {
        "christoomey/vim-tmux-runner",
        config = function()
            if (vim.api.nvim_eval("exists('g:vscode')") == 0) then
                require("plugins.vtr")
            end
        end
    }
    use {
        "mcchrish/nnn.vim",
        config = function()
            if (vim.api.nvim_eval("exists('g:vscode')") == 0) then
                require("plugins.nnn")
            end
        end
    }
    use {"vifm/vifm.vim", config = function() require("plugins.vifm") end}

    -- text objects
    use "wellle/targets.vim"
    use {"kana/vim-textobj-entire", requires = "kana/vim-textobj-user"}
    use {
        "beloglazov/vim-textobj-punctuation",
        requires = "kana/vim-textobj-user"
    }
    use {
        "Julian/vim-textobj-variable-segment",
        requires = "kana/vim-textobj-user"
    }
    use {
        "inside/vim-textobj-jsxattr",
        requires = "kana/vim-textobj-user",
        ft = {"javascriptreact", "typescriptreact"}
    }

    -- development
    use "neovim/nvim-lspconfig"
    use {
        "ojroques/nvim-lspfuzzy",
        requires = {{"junegunn/fzf"}, {"junegunn/fzf.vim"}}
    }
    use {
        "lewis6991/gitsigns.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            if (vim.api.nvim_eval("exists('g:vscode')") == 0) then
                require("plugins.gitsigns")
            end
        end
    }
    use "sheerun/vim-polyglot"
    use {
        "vim-test/vim-test",
        config = function()
            if (vim.api.nvim_eval("exists('g:vscode')") == 0) then
                require("plugins.vim-test")
            end
        end
    }
    use {"tpope/vim-fugitive"}
    use {"tpope/vim-rhubarb", requires = "tpope/vim-fugitive", cmd = {"Git"}}

    -- visual
    use {
        "ap/vim-buftabline",
        config = function()
            if (vim.api.nvim_eval("exists('g:vscode')") == 0) then
                require("plugins.buftabline")
            end
        end
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
