local nvim_lsp = require("lspconfig")
local sumneko = require("lsp.sumneko")
local diagnosticls = require("lsp.diagnosticls")
local u = require("utils")

-- disable virtual text
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                 {virtual_text = false, underline = true, signs = true})

vim.lsp.handlers["textDocument/formatting"] =
    require("lsp.functions").format_async

local on_attach = function(client, bufnr)
    -- bindings
    u.buf_map(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
    u.buf_map(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
    u.buf_map(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
    u.buf_map(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
    u.buf_map(bufnr, "n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
    u.buf_map(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.rename()<CR>")
    u.buf_map(bufnr, "n", "gR", "<cmd>lua vim.lsp.buf.references()<CR>")
    u.buf_map(bufnr, "n", "[a", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
    u.buf_map(bufnr, "n", "]a", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
    u.buf_map(bufnr, "n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>")
    u.buf_map(bufnr, "n", "gs",
              "<cmd>lua require('lsp.functions').organize_imports()<CR>")
    u.buf_map(bufnr, "n", "<Leader>a",
              "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
    u.buf_map(bufnr, "i", "<C-x><C-x>",
              "<cmd>lua vim.lsp.buf.signature_help()<CR>")

    if client.resolved_capabilities.document_formatting then
        u.exec([[
         augroup FormatOnSave
             autocmd! * <buffer>
             autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()
         augroup END
         ]])
    end
end

nvim_lsp.tsserver.setup {
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = false
        on_attach(client)
    end
}

nvim_lsp.sumneko_lua.setup {
    on_attach = on_attach,
    cmd = {sumneko.binary, "-E", sumneko.root .. "/main.lua"},
    settings = {Lua = {diagnostics = {enable = true, globals = {"vim", "use"}}}}
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
