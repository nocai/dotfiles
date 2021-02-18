vim.cmd("packadd packer.nvim")
return require("packer").startup(function()
    -- basic
    use {"wbthomason/packer.nvim", opt = true}
    use "tpope/vim-commentary"
    use "tpope/vim-repeat"
    use "tpope/vim-surround"
    use "tpope/vim-unimpaired"
    use "tpope/vim-eunuch"
    use {
        "windwp/nvim-autopairs",
        config = function() require("plugins.autopairs") end
    }

    -- additional functionality
    use {"phaazon/hop.nvim", config = function() require("plugins.hop") end}
    use {
        "svermeulen/vim-subversive",
        config = function() require("plugins.subversive") end
    }
    use {
        "svermeulen/vim-cutlass",
        config = function() require("plugins.cutlass") end
    }
    use {
        "Asheq/close-buffers.vim",
        config = function() require("plugins.close-buffers") end
    }
    use "christoomey/vim-tmux-navigator"
    use {
        "nvim-telescope/telescope.nvim",
        requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}},
        config = function() require("plugins.telescope") end
    }
    use {
        "voldikss/vim-floaterm",
        config = function() require("plugins.floaterm") end
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
        "glepnir/lspsaga.nvim",
        config = function() require("plugins.lspsaga") end
    }
    use {"hrsh7th/nvim-compe", config = function() require("plugins.compe") end}
    use {
        "lewis6991/gitsigns.nvim",
        requires = {"nvim-lua/plenary.nvim"},
        config = function() require("plugins.gitsigns") end
    }
    use {"hrsh7th/vim-vsnip", config = function() require("plugins.vsnip") end}
    use "sheerun/vim-polyglot"
    use {
        "vim-test/vim-test",
        config = function() require("plugins.vim-test") end
    }
    use {
        "mhartington/formatter.nvim",
        config = function() require("plugins.formatter") end
    }

    -- visual
    use {
        "szw/vim-maximizer",
        cmd = {"MaximizerToggle"},
        config = function() require("plugins.maximizer") end
    }
    use {
        "ap/vim-buftabline",
        config = function() require("plugins.buftabline") end
    }
    use "RRethy/vim-illuminate"
    use "sainnhe/sonokai"
    use "sainnhe/edge"

    -- other
    use {
        "iamcco/markdown-preview.nvim",
        run = "cd app && yarn install",
        opt = true,
        cmd = "MarkdownPreview"
    }
    use "antoinemadec/FixCursorHold.nvim"
    use {"rafcamlet/nvim-luapad", opt = true, cmd = {"Luapad", "LuaRun", "Lua"}}
end)
