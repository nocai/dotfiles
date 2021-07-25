vim.cmd("packadd packer.nvim")
return require("packer").startup(function()
    use({ "wbthomason/packer.nvim", opt = true })

    local config = function(name)
        return string.format("require('plugins.%s')", name)
    end

    local use_with_config = function(path, name)
        use({
            path,
            config = config(name),
        })
    end

    -- basic
    use("tpope/vim-repeat")
    use("tpope/vim-surround")
    use("tpope/vim-unimpaired")
    use("tpope/vim-commentary")
    use_with_config("lewis6991/gitsigns.nvim", "gitsigns")

    -- text objects
    use("wellle/targets.vim") -- many useful additional text objects
    use({
        "kana/vim-textobj-user",
        {
            "Julian/vim-textobj-variable-segment", -- av/iv for variable segment
            "kana/vim-textobj-entire", -- ae/ie for entire buffer
            "beloglazov/vim-textobj-punctuation", -- au/iu for punctuation
        },
    })
    use_with_config("andymass/vim-matchup", "matchup") -- improves %

    -- improvements to registers
    use_with_config("svermeulen/vim-subversive", "subversive") -- adds substitute operator
    use_with_config("svermeulen/vim-cutlass", "cutlass") -- separates cut and delete operations
    use_with_config("svermeulen/vim-yoink", "yoink") -- improves paste
    use_with_config("tversteeg/registers.nvim", "registers") -- shows register contents intelligently

    -- additional functionality
    use_with_config("justinmk/vim-sneak", "sneak") -- my favorite motion plugin
    use_with_config("windwp/nvim-autopairs", "autopairs") -- autocomplete pairs
    use({
        "nvim-telescope/telescope.nvim", -- fuzzy finder
        requires = {
            { "nvim-lua/popup.nvim" },
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }, -- better search algorithm
        },
        config = config("telescope"),
    })

    -- integrations
    use_with_config("numToStr/Navigator.nvim", "navigator") -- tmux / neovim pane navigation
    use_with_config("vifm/vifm.vim", "vifm") -- simple nnn integration
    use_with_config("christoomey/vim-tmux-runner", "vtr") -- run commands in a linked tmux pane

    -- development
    use("neovim/nvim-lspconfig")
    use("nvim-lua/plenary.nvim")
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = config("treesitter"),
    })
    use("folke/lua-dev.nvim") -- adds completion for neovim api, plugins, and more
    use({
        "RRethy/nvim-treesitter-textsubjects", -- adds smart . text object
        ft = { "lua", "typescript", "typescriptreact" },
    })
    use({ "windwp/nvim-ts-autotag", ft = { "typescript", "typescriptreact" } }) -- automatically completes jsx tags
    use({ "JoosepAlviste/nvim-ts-context-commentstring", ft = { "typescript", "typescriptreact" } }) -- makes jsx comments actually work
    use_with_config("RRethy/vim-illuminate", "illuminate") -- highlights and moves between variable references

    -- visual
    use("sainnhe/sonokai")
    use("kyazdani42/nvim-web-devicons")

    -- local
    use_with_config("~/git/minsnip.nvim", "minsnip")
    use_with_config("~/git/buftabline.nvim", "buftabline")
    use("~/git/nvim-lsp-ts-utils")
    use("~/git/null-ls.nvim")

    -- misc
    use("blankname/vim-fish")
    use("teal-language/vim-teal")
    use({
        "iamcco/markdown-preview.nvim",
        opt = true,
        ft = { "markdown" },
        config = "vim.cmd[[doautocmd BufEnter]]",
        run = "cd app && yarn install",
        cmd = "MarkdownPreview",
    })
end)
