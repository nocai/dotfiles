vim.cmd [[packadd packer.nvim]]

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
        config = function()
            vim.api.nvim_set_keymap("n", "<Leader>s", ":HopWord<CR>",
                                    {silent = true})
            vim.api.nvim_set_keymap("n", "<Leader>S", ":HopChar2<CR>",
                                    {silent = true})
        end
    }
    use {
        "svermeulen/vim-subversive",
        config = function()
            vim.api
                .nvim_set_keymap("n", "s", "<Plug>(SubversiveSubstitute)", {})
            vim.api
                .nvim_set_keymap("x", "s", "<Plug>(SubversiveSubstitute)", {})
            vim.api.nvim_set_keymap("n", "ss",
                                    "<Plug>(SubversiveSubstituteLine)", {})
            vim.api.nvim_set_keymap("n", "S",
                                    "<Plug>SubversiveSubstituteToEndOfLine", {})
        end
    }
    use {
        "svermeulen/vim-cutlass",
        config = function()
            vim.api.nvim_set_keymap("n", "m", "d", {noremap = true})
            vim.api.nvim_set_keymap("x", "m", "d", {noremap = true})
            vim.api.nvim_set_keymap("n", "mm", "dd", {noremap = true})
            vim.api.nvim_set_keymap("n", "M", "D", {noremap = true})
            vim.api.nvim_set_keymap("n", "gm", "m", {noremap = true})
        end
    }
    use {
        "Asheq/close-buffers.vim",
        cmd = {"Bdelete"},
        config = function()
            vim.api.nvim_set_keymap("n", "<Leader>b", ":Bdelete menu<CR>",
                                    {silent = true})
        end
    }
    use "christoomey/vim-tmux-navigator"
    use {
        "nvim-telescope/telescope.nvim",
        requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}},
        config = function() require("plugins.telescope") end
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
    use {"hrsh7th/nvim-compe", config = function() require("plugins.compe") end}
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function() require("plugins.treesitter") end
    }
    use {
        "lewis6991/gitsigns.nvim",
        requires = {{"nvim-lua/plenary.nvim"}},
        config = function() require("plugins.gitsigns") end
    }
    use {
        "hrsh7th/vim-vsnip",
        config = function()
            vim.api.nvim_set_var("vsnip_filetypes", {
                javascriptreact = {"javascript"},
                typescriptreact = {"typescript"}
            })

            vim.api.nvim_set_keymap("n", "<Leader>v", ":VsnipOpenSplit<CR>",
                                    {silent = true})
            vim.api.nvim_set_keymap("i", "<Tab>",
                                    "vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<Tab>'",
                                    {silent = true, expr = true})
            vim.api.nvim_set_keymap("s", "<Tab>",
                                    "vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<Tab>'",
                                    {silent = true, expr = true})
            vim.api.nvim_set_keymap("i", "<S-Tab>",
                                    "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-o>A'",
                                    {silent = true, expr = true})
            vim.api.nvim_set_keymap("s", "<S-Tab>",
                                    "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-o>A'",
                                    {silent = true, expr = true})
        end
    }
    use "sheerun/vim-polyglot"
    use {
        "mattn/emmet-vim",
        ft = {"html", "javascriptreact", "typescriptreact"},
        config = function()
            vim.api.nvim_set_var("user_emmet_leader_key", "<C-z")
        end
    }

    -- visual
    use {
        "szw/vim-maximizer",
        cmd = {"MaximizerToggle"},
        config = function()
            vim.api.nvim_set_keymap("n", "<C-w>z", ":MaximizerToggle<CR>",
                                    {silent = true})
        end
    }
    use {
        "akinsho/nvim-bufferline.lua",
        config = function() require("plugins/bufferline") end
    }
    use {
        "glepnir/galaxyline.nvim",
        requires = {"kyazdani42/nvim-web-devicons"},
        config = function() require("plugins/galaxyline") end
    }
    use "RRethy/vim-illuminate"
    use "sainnhe/sonokai"
    use "sainnhe/edge"
    use "sainnhe/forest-night"

    -- other
    use {
        "iamcco/markdown-preview.nvim",
        run = "cd app && yarn install",
        cmd = "MarkdownPreview"
    }
end)
