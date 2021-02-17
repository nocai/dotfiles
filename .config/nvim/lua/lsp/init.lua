local nvim_lsp = require("lspconfig")
local efm_languages = require("lsp.efm")
local sumneko_config = require("lsp.sumneko")
local u = require("utils")
local buf_map = u.buf_map

vim.lsp.handlers["textDocument/formatting"] =
    require("lsp.functions").format_async

vim.lsp.handlers["textDocument/codeAction"] =
    require"lsputil.codeAction".code_action_handler
vim.lsp.handlers["textDocument/references"] =
    require"lsputil.locations".references_handler
vim.lsp.handlers["textDocument/definition"] =
    require"lsputil.locations".definition_handler
vim.lsp.handlers["textDocument/declaration"] =
    require"lsputil.locations".declaration_handler
vim.lsp.handlers["textDocument/typeDefinition"] =
    require"lsputil.locations".typeDefinition_handler
vim.lsp.handlers["textDocument/implementation"] =
    require"lsputil.locations".implementation_handler
vim.lsp.handlers["textDocument/documentSymbol"] =
    require"lsputil.symbols".document_handler
vim.lsp.handlers["workspace/symbol"] =
    require"lsputil.symbols".workspace_handler

local on_attach = function(client, bufnr)
    buf_map(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
    buf_map(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
    buf_map(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
    buf_map(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
    buf_map(bufnr, "n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
    buf_map(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.rename()<CR>")
    buf_map(bufnr, "n", "gR", "<cmd>lua vim.lsp.buf.references()<CR>")
    buf_map(bufnr, "n", "[a", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
    buf_map(bufnr, "n", "]a", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
    buf_map(bufnr, "n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>")
    buf_map(bufnr, "n", "gs",
            "<cmd>lua require('lsp.functions').organize_imports()<CR>")
    buf_map(bufnr, "n", "<Leader>a",
            "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
    buf_map(bufnr, "n", "<Leader>A",
            "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>")
    buf_map(bufnr, "n", "<Leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>")
    buf_map(bufnr, "i", "<C-x><C-x>",
            "<cmd>lua vim.lsp.buf.signature_help()<CR>")

    -- disable virtual text
    vim.lsp.handlers["textDocument/publishDiagnostics"] =
        vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                     {virtual_text = false, underline = true, signs = true})

    -- enable format on save
    if client.resolved_capabilities.document_formatting then
        u.exec([[
        augroup FormatOnSave
            autocmd! * <buffer>
            autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()
        augroup END
        ]])
    end

    require("illuminate").on_attach(client)
end

nvim_lsp.tsserver.setup {
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = false
        on_attach(client)
    end
}

nvim_lsp.sumneko_lua.setup {
    on_attach = on_attach,
    cmd = {sumneko_config.binary, "-E", sumneko_config.root .. "/main.lua"},
    settings = {Lua = {diagnostics = {enable = true, globals = {"vim", "use"}}}}
}

nvim_lsp.efm.setup({
    on_attach = on_attach,
    rootMarkers = nvim_lsp.util.root_pattern(".git/"),
    init_options = {documentFormatting = true},
    settings = {languages = efm_languages},
    filetypes = vim.tbl_keys(efm_languages)
})

nvim_lsp.bashls.setup {on_attach = on_attach}
nvim_lsp.jsonls.setup {on_attach = on_attach}
nvim_lsp.yamlls.setup {on_attach = on_attach}
