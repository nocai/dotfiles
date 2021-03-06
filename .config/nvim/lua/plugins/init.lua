local function not_vscode() return vim.api.nvim_eval("exists('g:vscode')") == 0 end

vim.cmd("packadd packer.nvim")
return require("packer").startup(function()
    -- basic
    use {"wbthomason/packer.nvim", opt = true}
    use "tpope/vim-commentary"
    use "tpope/vim-repeat"
    use "tpope/vim-surround"
    use "tpope/vim-unimpaired"

    -- additional functionality
    use {
        "phaazon/hop.nvim",
        config = function() require("plugins.hop") end,
        cond = not_vscode
    }
    use {
        "windwp/nvim-autopairs",
        config = function() require("plugins.autopairs") end,
        cond = not_vscode
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
        "hrsh7th/vim-vsnip",
        config = function() require("plugins.vsnip") end,
        cond = not_vscode
    }
    use {
        "hrsh7th/nvim-compe",
        config = function() require("plugins.compe") end,
        cond = not_vscode
    }
    use {"junegunn/vim-slash", config = function() require("plugins.slash") end}
    use {
        "ojroques/nvim-bufdel",
        config = function() require("plugins.bufdel") end,
        cond = not_vscode
    }

    -- integrations
    use {
        "junegunn/fzf.vim",
        requires = {"junegunn/fzf"},
        run = function() vim.fn["fzf#install"]() end,
        config = function() require("plugins.fzf") end,
        cond = not_vscode

    }
    use {"christoomey/vim-tmux-navigator", cond = not_vscode}
    use {
        "christoomey/vim-tmux-runner",
        config = function() require("plugins.vtr") end,
        cond = not_vscode
    }
    use {
        "vifm/vifm.vim",
        config = function() require("plugins.vifm") end,
        cond = not_vscode
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
        "ojroques/nvim-lspfuzzy",
        requires = {{"junegunn/fzf"}, {"junegunn/fzf.vim"}}
    }
    use {
        "lewis6991/gitsigns.nvim",
        requires = {"nvim-lua/plenary.nvim"},
        cond = not_vscode,
        config = function() require("plugins.gitsigns") end
    }
    use {"sheerun/vim-polyglot", cond = not_vscode}
    use {
        "vim-test/vim-test",
        config = function() require("plugins.vim-test") end,
        cond = not_vscode
    }
    use {"tpope/vim-fugitive", cond = not_vscode}
    use {
        "tpope/vim-rhubarb",
        requires = {"tpope/vim-fugitive"},
        cmd = {"Git"},
        cond = not_vscode
    }

    -- visual
    use {
        "jose-elias-alvarez/buftabline.nvim",
        config = function() require("plugins.buftabline") end,
        cond = not_vscode
    }
    use {"sainnhe/sonokai"}
    use {"ghifarit53/tokyonight-vim", cond = not_vscode}
    use {"RRethy/vim-illuminate", cond = not_vscode}
    use {"antoinemadec/FixCursorHold.nvim", cond = not_vscode}

    -- other
    use {
        "iamcco/markdown-preview.nvim",
        ft = {"md", "mkdn", "markdown"},
        config = {"vim.cmd[[doautocmd BufEnter]]"},
        run = "cd app && yarn install",
        cmd = "MarkdownPreview",
        cond = not_vscode
    }
end)
