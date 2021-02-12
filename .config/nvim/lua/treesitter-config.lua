require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    indent = {enable = true},
    highlight = {enable = true},
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm"
        }
    },
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner"
            }
        },
        swap = {
            enable = true,
            swap_next = {["<Leader>w"] = "@parameter.inner"},
            swap_previous = {["<Leader>W"] = "@parameter.inner"}
        }
    }
}

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'

vim.cmd('command! TR write | edit | TSBufEnable highlight')
||||||| e840957
