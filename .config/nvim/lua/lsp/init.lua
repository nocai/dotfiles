local u = require("utils")
local functions = require("lsp.functions")
local nvim_lsp = require("lspconfig")
local sumneko = require("lsp.sumneko")

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                 {underline = true, signs = true, virtual_text = false})

local lsp_popup_opts = {border = "single"}
_G.lsp_popup_opts = lsp_popup_opts

vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, lsp_popup_opts)
vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(vim.lsp.handlers.hover, lsp_popup_opts)

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
    u.buf_map(bufnr, "n", "gd", ":LspDef<CR>", {silent = true})
    u.buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>", {silent = true})
    u.buf_map(bufnr, "n", "gi", ":LspRename<CR>", {silent = true})
    u.buf_map(bufnr, "n", "K", ":LspHover<CR>", {silent = true})
    u.buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>", {silent = true})
    u.buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>", {silent = true})
    u.buf_map(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>", {silent = true})
    u.buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>",
              {silent = true})

    u.exec([[
    augroup LspAutocommands
        autocmd! * <buffer>
        autocmd CursorHold * LspDiagLine
    augroup END
    ]])

    u.buf_opt(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    require("illuminate").on_attach(client)
end

nvim_lsp.tsserver.setup {
    cmd = {
        "typescript-language-server", "--stdio", "--tsserver-path",
        "/usr/local/bin/tsserver-wrapper"
    },
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        on_attach(client)

        u.buf_map(bufnr, "i", ".", ".<C-x><C-o>")

        local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup {
            enable_import_on_completion = true,
            eslint_bin = "eslint_d",
            eslint_enable_diagnostics = true,
            enable_formatting = true,
            format_on_save = true
        }
        vim.lsp.buf_request = ts_utils.buf_request

        u.buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>", {silent = true})
        u.buf_map(bufnr, "n", "gI", ":TSLspRenameFile<CR>", {silent = true})
        u.buf_map(bufnr, "n", "gt", ":TSLspImportAll<CR>", {silent = true})
        u.buf_map(bufnr, "n", "qq", ":TSLspFixCurrent<CR>", {silent = true})
    end
}

nvim_lsp.sumneko_lua.setup {
    on_attach = function(client, bufnr)
        on_attach(client)
        u.buf_map(bufnr, "i", ".", ".<C-x><C-o>")

        vim.lsp.handlers["textDocument/formatting"] = functions.lua_format
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
