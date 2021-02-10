local nvim_lsp = require "lspconfig"

local on_attach = function(_, bufnr)
    local function map(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local opts = {noremap = true, silent = true}

    map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    map('i', '<C-x><C-x>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    map('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    map('n', '<Leader>cr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    map('n', 'gR', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    map('n', '[a', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    map('n', ']a', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    map('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    map('n', '<Leader>a',
        '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    map("n", "gs", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

nvim_lsp.tsserver.setup {
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = false
        on_attach(client)
    end
}

nvim_lsp.vimls.setup {on_attach = on_attach}
nvim_lsp.bashls.setup {on_attach = on_attach}
nvim_lsp.jsonls.setup {on_attach = on_attach}
nvim_lsp.yamlls.setup {on_attach = on_attach}

local sumneko_root_path = vim.fn.getenv("HOME") .. "/git/lua-language-server/"
local sumneko_binary = sumneko_root_path .. "/bin/macOS/lua-language-server"
nvim_lsp.sumneko_lua.setup {
    on_attach = on_attach,
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    settings = {Lua = {diagnostics = {enable = true, globals = {"vim", "use"}}}}
}

nvim_lsp.diagnosticls.setup {
    filetypes = {"typescript", "typescriptreact"},
    init_options = {
        filetypes = {
            sh = "shellcheck",
            typescript = 'eslint',
            typescriptreact = "eslint",
            markdown = {"markdownlint", "writeGood"},
            vim = 'vint'
        },
        linters = {
            eslint = {
                sourceName = "eslint",
                command = "./node_modules/.bin/eslint",
                rootPatterns = {".eslintrc.js", "package.json"},
                debounce = 100,
                args = {
                    "--cache", "--stdin", "--stdin-filename", "%filepath",
                    "--format", "json"
                },
                parseJson = {
                    errorsRoot = "[0].messages",
                    line = "line",
                    column = "column",
                    endLine = "endLine",
                    endColumn = "endColumn",
                    message = "${message} [${ruleId}]",
                    security = "severity"
                },
                securities = {[2] = "error", [1] = "warning"}
            },
            markdownlint = {
                command = 'markdownlint',
                rootPatterns = {'.git'},
                isStderr = true,
                debounce = 100,
                args = {'--stdin'},
                offsetLine = 0,
                offsetColumn = 0,
                sourceName = 'markdownlint',
                securities = {undefined = 'hint'},
                formatLines = 1,
                formatPattern = {
                    '^.*:(\\d+)\\s+(.*)$', {line = 1, column = -1, message = 2}
                }
            },
            writeGood = {
                command = "write-good",
                debounce = 100,
                args = {"--text=%text"},
                offsetLine = 0,
                offsetColumn = 1,
                sourceName = "write-good",
                formatLines = 1,
                formatPattern = {
                    "(.*)\\s+on\\s+line\\s+(\\d+)\\s+at\\s+column\\s+(\\d+)\\s*$",
                    {line = 2, column = 3, message = 1}
                }
            },
            shellcheck = {
                command = "shellcheck",
                debounce = 100,
                args = {"--format", "json", "-"},
                sourceName = "shellcheck",
                parseJson = {
                    line = "line",
                    column = "column",
                    endLine = "endLine",
                    endColumn = "endColumn",
                    message = "${message} [${code}]",
                    security = "level"
                },
                securities = {
                    error = "error",
                    warning = "warning",
                    info = "info",
                    style = "hint"
                }
            },
            vint = {
                command = "vint",
                debounce = 100,
                args = {"--enable-neovim", "-"},
                offsetLine = 0,
                offsetColumn = 0,
                sourceName = "vint",
                formatLines = 1,
                formatPattern = {
                    "[^:]+:(\\d+):(\\d+):\\s*(.*)(\\r|\\n)*$",
                    {line = 1, column = 2, message = 3}
                }
            }
        }
    }
}
