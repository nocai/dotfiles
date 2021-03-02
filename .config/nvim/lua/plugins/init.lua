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
    use {"junegunn/fzf.vim", requires = "junegunn/fzf", run = "fzf#install()"}

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
