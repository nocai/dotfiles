local u = require("utils")
local functions = require("lsp.functions")
local nvim_lsp = require("lspconfig")
local sumneko = require("lsp.sumneko")
local diagnosticls = require("lsp.diagnosticls")

vim.lsp.handlers["textDocument/formatting"] = functions.format_async
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                 {underline = true, signs = true, virtual_text = false})

vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, {border = "single"})

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
        [[command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev({ popup_opts = { border = "single" }})]])
    vim.cmd(
        [[command! LspDiagNext lua vim.lsp.diagnostic.goto_next({ popup_opts = { border = "single" }})]])
    vim.cmd(
        "command! LspDiagLine lua vim.lsp.diagnostic.show_line_diagnostics()")
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

    u.buf_opt(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    if client.resolved_capabilities.document_formatting then
        u.exec([[
        augroup LspFormatOnSave
            autocmd! * <buffer>
            autocmd BufWritePost <buffer> LspFormatting
        augroup END
        ]])
    end

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
            eslint_fix_current = true
        }
        vim.lsp.handlers["textDocument/codeAction"] =
            ts_utils.code_action_handler

        u.buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>", {silent = true})
        u.buf_map(bufnr, "n", "gI", ":TSLspRenameFile<CR>", {silent = true})
        u.buf_map(bufnr, "n", "gt", ":TSLspImportAll<CR>", {silent = true})
        u.buf_map(bufnr, "n", "qq", ":TSLspFixCurrent<CR>", {silent = true})

        require("telescope.builtin").lsp_code_actions =
            functions.ts_telescope_code_actions
    end
}

nvim_lsp.sumneko_lua.setup {
    on_attach = function(client, bufnr)
        on_attach(client)
        u.buf_map(bufnr, "i", ".", ".<C-x><C-o>")
    end,
    cmd = {sumneko.binary, "-E", sumneko.root .. "/main.lua"},
    settings = sumneko.settings
}

nvim_lsp.diagnosticls.setup {
    on_attach = on_attach,
    filetypes = vim.tbl_keys(diagnosticls.filetypes),
    init_options = {
        filetypes = diagnosticls.filetypes,
        linters = diagnosticls.linters,
        formatters = diagnosticls.formatters,
        formatFiletypes = diagnosticls.formatFiletypes
    }

}
nvim_lsp.bashls.setup {on_attach = on_attach}
nvim_lsp.jsonls.setup {
    on_attach = on_attach,
    filetypes = {"json", "jsonc"},
    init_options = {provideFormatter = false}
}
nvim_lsp.yamlls.setup {on_attach = on_attach}
