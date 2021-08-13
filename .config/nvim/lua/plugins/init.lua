vim.cmd("packadd packer.nvim")
return require("packer").startup(function()
    use({ "wbthomason/packer.nvim", opt = true })

    local config = function(name)
        return string.format("require('plugins.%s')", name)
    end

    local use_with_config = function(path, name)
        use({ path, config = config(name) })
    end

    -- basic
    use("tpope/vim-repeat")
    use("tpope/vim-surround")
    use("tpope/vim-unimpaired")
    use("tpope/vim-commentary")

    -- git
    use({
        { "lewis6991/gitsigns.nvim", config = config("git") },
        { "tpope/vim-fugitive", requires = "tpope/vim-rhubarb", cmd = "Git" },
    })

    -- text objects
    use("wellle/targets.vim") -- many useful additional text objects
    use_with_config("andymass/vim-matchup", "matchup") -- improves %
    use({
        "kana/vim-textobj-user",
        {
            "kana/vim-textobj-entire", -- ae/ie for entire buffer
            "Julian/vim-textobj-variable-segment", -- av/iv for variable segment
            "beloglazov/vim-textobj-punctuation", -- au/iu for punctuation
        },
    })

    -- registers
    use_with_config("svermeulen/vim-subversive", "subversive") -- adds substitute operator
    use_with_config("svermeulen/vim-cutlass", "cutlass") -- separates cut and delete operations
    use_with_config("svermeulen/vim-yoink", "yoink") -- improves paste
    use_with_config("tversteeg/registers.nvim", "registers") -- shows register contents intelligently

    -- additional functionality
    use_with_config("windwp/nvim-autopairs", "autopairs") -- autocomplete pairs
    use_with_config("~/git/minsnip.nvim", "minsnip") -- tiny snippet plugin
    use_with_config("justinmk/vim-sneak", "sneak") -- motion

    -- integrations
    use_with_config("numToStr/Navigator.nvim", "navigator") -- tmux / neovim pane navigation
    use_with_config("christoomey/vim-tmux-runner", "vtr") -- run commands in a linked tmux pane
    use_with_config("mcchrish/nnn.vim", "nnn") -- simple nnn integration
    use({
        "ibhagwan/fzf-lua", -- fzf plugin with lua api
        requires = {
            "vijaymarupudi/nvim-fzf",
        },
        config = config("fzf"),
    })

    -- lsp
    use("neovim/nvim-lspconfig") -- makes lsp configuration easier
    use_with_config("RRethy/vim-illuminate", "illuminate") -- highlights and allows moving between variable references
    use("~/git/null-ls.nvim") -- allows using neovim as language server
    use("mfussenegger/nvim-lsp-compl") -- provides simple and fast lsp completion

    -- development
    use("~/git/nvim-lsp-ts-utils") -- improve typescript experience
    use_with_config("vuki656/package-info.nvim", "package-info") -- show versions in package.json

    -- visual
    use({ -- themes
        "sainnhe/sonokai",
        "sainnhe/everforest",
        "folke/tokyonight.nvim",
    })
    use("sheerun/vim-polyglot") -- syntax highlighting
    use_with_config("~/git/buftabline.nvim", "buftabline") -- show buffers in tabline
    use("kyazdani42/nvim-web-devicons")

    -- misc
    use("teal-language/vim-teal") -- teal language support
    use("nvim-lua/plenary.nvim") -- required for plugins (and testing)
    use({
        "iamcco/markdown-preview.nvim", -- preview markdown output in browser
        opt = true,
        ft = { "markdown" },
        config = "vim.cmd[[doautocmd BufEnter]]",
        run = "cd app && yarn install",
        cmd = "MarkdownPreview",
    })
end)
