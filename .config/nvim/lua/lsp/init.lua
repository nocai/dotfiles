local u = require("utils")
local functions = require("lsp.functions")
local nvim_lsp = require("lspconfig")
local sumneko = require("lsp.sumneko")

local lsp = vim.lsp

lsp.handlers["textDocument/publishDiagnostics"] =
    lsp.with(lsp.diagnostic.on_publish_diagnostics,
             {underline = true, signs = true, virtual_text = false})

local lsp_popup_opts = {border = "single"}
_G.lsp_popup_opts = lsp_popup_opts

lsp.handlers["textDocument/signatureHelp"] =
    lsp.with(lsp.handlers.signature_help, lsp_popup_opts)
lsp.handlers["textDocument/hover"] =
    lsp.with(lsp.handlers.hover, lsp_popup_opts)

-- wrap omnifunc to prevent annoying "can only be used in insert" message
_G.lsp_omnifunc = function() return pcall(lsp.omnifunc) end

local on_attach = function(client, bufnr)
    -- commands
    vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
    vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
    vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
    vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
    vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
    vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
    vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
    vim.cmd(
        "command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev({popup_opts = lsp_popup_opts})")
    vim.cmd(
        "command! LspDiagNext lua vim.lsp.diagnostic.goto_next({popup_opts = lsp_popup_opts})")
    vim.cmd(
        "command! LspDiagLine lua vim.lsp.diagnostic.show_line_diagnostics(lsp_popup_opts)")
    vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")

    -- bindings
    u.buf_map(bufnr, "n", "gd", ":LspDef<CR>")
    u.buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>")
    u.buf_map(bufnr, "n", "gi", ":LspRename<CR>")
    u.buf_map(bufnr, "n", "K", ":LspHover<CR>")
    u.buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>")
    u.buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>")
    u.buf_map(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>")
    u.buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>")

    u.exec([[
    augroup LspAutocommands
        autocmd! * <buffer>
        autocmd CursorHold * LspDiagLine
    augroup END
    ]])

    u.buf_opt(bufnr, "omnifunc", "v:lua.lsp_omnifunc")

    require("illuminate").on_attach(client)
end

nvim_lsp.tsserver.setup {
    cmd = {
        "typescript-language-server", "--stdio", "--tsserver-path",
        "/usr/local/bin/tsserver-wrapper"
    },
    on_attach = function(client, bufnr)
        on_attach(client)

        u.buf_map(bufnr, "i", ".", ".<C-x><C-o>")

        local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup {
            -- debug = true,
            enable_import_on_completion = true,
            complete_parens = true,
            signature_help_in_parens = true,
            eslint_bin = "eslint_d",
            eslint_enable_diagnostics = true,
            enable_formatting = true,
            formatter = "eslint_d",
            formatter_args = {
                "--fix-to-stdout", "--stdin", "--stdin-filename", "$FILENAME"
            },
            format_on_save = true,
            update_imports_on_move = true
        }
        ts_utils.setup_client(client)

        u.buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
        u.buf_map(bufnr, "n", "gI", ":TSLspRenameFile<CR>")
        u.buf_map(bufnr, "n", "gt", ":TSLspImportAll<CR>")
        u.buf_map(bufnr, "n", "qq", ":TSLspFixCurrent<CR>")
    end
}

nvim_lsp.sumneko_lua.setup {
    on_attach = function(client, bufnr)
        on_attach(client)
        u.buf_map(bufnr, "i", ".", ".<C-x><C-o>")

        lsp.handlers["textDocument/formatting"] = functions.lua_format
        u.exec([[
        augroup LspFormatOnSave
            autocmd! * <buffer>
            autocmd BufWritePost <buffer> LspFormatting
        augroup END
        ]])
    end,
    cmd = {sumneko.binary, "-E", sumneko.root .. "/main.lua"},
    settings = sumneko.settings
}

nvim_lsp.bashls.setup {on_attach = on_attach}
nvim_lsp.jsonls.setup {
    on_attach = on_attach,
    filetypes = {"json", "jsonc"},
    init_options = {provideFormatter = false}
}
nvim_lsp.yamlls.setup {on_attach = on_attach}
