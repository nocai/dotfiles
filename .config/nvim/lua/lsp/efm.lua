local tools = {
    eslint = {
        lintCommand = 'eslint_d --stdin --stdin-filename ${INPUT} -f unix',
        lintStdin = true,
        lintIgnoreExitCode = true
    },

    prettier = {
        formatCommand = 'prettier --stdin-filepath ${INPUT}',
        formatStdin = true
    },
    luaFormat = {formatCommand = 'lua-format -i', formatStdin = true},
    vint = {
        lintCommand = 'vint -',
        lintStdin = true,
        lintFormats = {'%f:%l:%c: %m'}
    },
    markdownlint = {
        lintCommand = 'markdownlint -s',
        lintStdin = true,
        lintFormats = {'%f:%l %m', '%f:%l:%c %m', '%f: %l: %m'}
    },
    shellcheck = {
        lintCommand = "shellcheck -f gcc -x -",
        lintStdin = true,
        lintFormats = {
            "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m",
            "%f:%l:%c: %tote: %m"
        }
    },
    shfmt = {formatCommand = 'shfmt -ci -s -bn', formatStdin = true}
}

local languages = {
    markdown = {tools.markdownlint, tools.prettier},
    typescript = {tools.eslint, tools.prettier},
    typescriptreact = {tools.eslint, tools.prettier},
    lua = {tools.luaFormat},
    vim = {tools.vint},
    sh = {tools.shellcheck, tools.shfmt},
    json = {tools.prettier}
}

return languages
