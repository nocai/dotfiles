vim.cmd("packadd packer.nvim")
return require("packer").startup(function()
    -- basic
    use {"wbthomason/packer.nvim", opt = true}
    use "tpope/vim-commentary"
    use "tpope/vim-repeat"
    use "tpope/vim-surround"
    use "tpope/vim-unimpaired"

    -- additional functionality
    use "justinmk/vim-sneak"
    use {
        "svermeulen/vim-subversive",
        config = function() require("plugins.subversive") end
    }
    use "vim-scripts/ReplaceWithRegister"
    use {"hrsh7th/vim-vsnip", config = function() require("plugins.vsnip") end}
    use {"hrsh7th/nvim-compe", config = function() require("plugins.compe") end}

    -- integrations
    use {"junegunn/fzf.vim", requires = {"junegunn/fzf"}, run = "fzf#install()"}
    use "christoomey/vim-tmux-navigator"
    use {
        "christoomey/vim-tmux-runner",
        config = function() require("plugins.vtr") end
    }
    use {"mcchrish/nnn.vim", config = function() require("plugins.nnn") end}

    -- text objects
    use "wellle/targets.vim"
    use {"kana/vim-textobj-entire", requires = "kana/vim-textobj-user"}
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
    use "challenger-deep-theme/vim"
end)
