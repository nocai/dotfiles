vim.cmd("packadd paq-nvim")
local paq = require"paq-nvim".paq
paq {"savq/paq-nvim", opt = true}

-- basic
paq "tpope/vim-commentary"
paq "tpope/vim-repeat"
paq "tpope/vim-surround"
paq "tpope/vim-unimpaired"

-- additional functionality
paq {"phaazon/hop.nvim", run = require("plugins.hop")}
paq {"windwp/nvim-autopairs", run = require("plugins.autopairs")}
paq {"svermeulen/vim-subversive", run = require("plugins.subversive")}
paq {"svermeulen/vim-cutlass", run = require("plugins.cutlass")}
paq {"hrsh7th/vim-vsnip", run = require("plugins.vsnip")}
paq {"hrsh7th/nvim-compe", run = require("plugins.compe")}
paq {"junegunn/vim-slash", run = require("plugins.slash")}

-- integrations
paq {"junegunn/fzf"}
paq {"junegunn/fzf.vim", run = require("plugins.fzf")}
paq "christoomey/vim-tmux-navigator"
paq {"christoomey/vim-tmux-runner", run = require("plugins.vtr")}
paq {"vifm/vifm.vim", run = require("plugins.vifm")}

-- text objects
paq "wellle/targets.vim"
paq "kana/vim-textobj-user"
paq "kana/vim-textobj-entire"
paq "beloglazov/vim-textobj-punctuation"
paq "Julian/vim-textobj-variable-segment"
paq {"inside/vim-textobj-jsxattr", opt = true}

-- development
paq "neovim/nvim-lspconfig"
paq "ojroques/nvim-lspfuzzy"
paq "nvim-lua/plenary.nvim"
paq {"lewis6991/gitsigns.nvim", run = require("plugins.gitsigns")}
paq "sheerun/vim-polyglot"
paq {"vim-test/vim-test", run = require("plugins.vim-test")}
paq "tpope/vim-fugitive"
paq "tpope/vim-rhubarb"

-- visual
paq {"ap/vim-buftabline", run = require("plugins.buftabline")}
paq "sainnhe/sonokai"
paq "ghifarit53/tokyonight-vim"
paq "RRethy/vim-illuminate"
paq "antoinemadec/FixCursorHold.nvim"

-- other
paq {"iamcco/markdown-preview.nvim", opt = true, run = "cd app && yarn install"}
