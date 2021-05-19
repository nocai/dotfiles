vim.cmd("packadd packer.nvim")
return require("packer").startup(function()
    use {"wbthomason/packer.nvim", opt = true}

    local config = function(name) require("plugins." .. name) end
    local use_with_config = function(path, name)
        use {path, config = config(name)}
    end

    -- basic
    use "tpope/vim-repeat"
    use "tpope/vim-surround"
    use "tpope/vim-unimpaired"
    use "tpope/vim-commentary"

    -- additional functionality
    use "wellle/targets.vim"
    use_with_config("windwp/nvim-autopairs", "autopairs")
    use_with_config("svermeulen/vim-subversive", "subversive")
    use_with_config("svermeulen/vim-cutlass", "cutlass")
    use_with_config("SirVer/ultisnips", "ultisnips")
    use_with_config("phaazon/hop.nvim", "hop")

    -- integrations
    use {
        "junegunn/fzf.vim",
        requires = {"junegunn/fzf"},
        run = function() vim.fn["fzf#install"]() end,
        config = config("fzf")
    }
    use_with_config("numToStr/Navigator.nvim", "navigator")
    use_with_config("vifm/vifm.vim", "vifm")
    use "ojroques/nvim-lspfuzzy"
    use "wellle/tmux-complete.vim"

    -- development
    use "neovim/nvim-lspconfig"
    use "nvim-lua/plenary.nvim"
    use_with_config("lewis6991/gitsigns.nvim", "gitsigns")
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = config("treesitter")
    }
    use "JoosepAlviste/nvim-ts-context-commentstring"
    use {"windwp/nvim-ts-autotag", requires = "nvim-treesitter/nvim-treesitter"}
    use_with_config("vim-test/vim-test", "vim-test")

    -- visual
    use_with_config("RRethy/vim-illuminate", "illuminate")
    use "sainnhe/sonokai"

    -- local
    use_with_config("~/git/null-ls/", "null-ls")
    use_with_config("~/git/buftabline.nvim", "buftabline")
    use "~/git/nvim-lsp-ts-utils"

    -- misc
    use {
        "iamcco/markdown-preview.nvim",
        ft = {"markdown"},
        config = "vim.cmd[[doautocmd BufEnter]]",
        run = "cd app && yarn install",
        cmd = "MarkdownPreview"
    }
end)
