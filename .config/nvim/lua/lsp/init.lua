local nvim_lsp = require("lspconfig")
local efm_languages = require("lsp.efm")
local sumneko_config = require("lsp.sumneko")

local on_attach = function(client, bufnr)
    local function map(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local opts = {noremap = true, silent = true}

    map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    map("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    map("n", "<Leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    map("n", "gr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    map("n", "gR", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    map("n", "[a", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
    map("n", "]a", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    map("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    map("n", "gs", "<cmd>lua require(\"lsp.functions\").organize_imports()<CR>",
        opts)
    map("n", "<Leader>a",
        "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
    map("n", "<Leader>A", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
    map("i", "<C-x><C-x>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_command [[augroup FormatOnSave]]
        vim.api.nvim_command [[autocmd! * <buffer>]]
        vim.api
            .nvim_command [[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting_sync(null, 500)]]
        vim.api.nvim_command [[augroup END]]
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
    cmd = {"efm-langserver", "-logfile", "/tmp/efm.log"},
    init_options = {documentFormatting = true},
    settings = {languages = efm_languages},
    filetypes = vim.tbl_keys(efm_languages)
})

nvim_lsp.vimls.setup {on_attach = on_attach}
nvim_lsp.bashls.setup {on_attach = on_attach}
nvim_lsp.jsonls.setup {on_attach = on_attach}
nvim_lsp.yamlls.setup {on_attach = on_attach}
