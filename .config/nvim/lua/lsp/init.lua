local nvim_lsp = require("lspconfig")
local sumneko = require("lsp.sumneko")
local diagnosticls = require("lsp.diagnosticls")
local u = require("utils")

-- disable virtual text
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                 {virtual_text = false, underline = true, signs = true})

local on_attach = function(client, bufnr)
    -- bindings
    u.buf_map(bufnr, "n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
    u.buf_map(bufnr, "n", "gs",
              "<cmd>lua require('lsp.functions').organize_imports()<CR>")
    -- saga bindings
    u.buf_map(bufnr, "n", "gh",
              "<cmd>lua require('lspsaga.provider').lsp_finder()<CR>")
    u.buf_map(bufnr, "n", "<C-f>",
              "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>")
    u.buf_map(bufnr, "n", "<C-b>",
              "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>")
    u.buf_map(bufnr, "n", "ga",
              "<cmd>lua require('lspsaga.codeaction').code_action()<CR>")
    u.buf_map(bufnr, "v", "ga",
              "<cmd>'<,'>lua require('lspsaga.codeaction').range_code_action()<CR")
    u.buf_map(bufnr, "n", "K",
              "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>")
    u.buf_map(bufnr, "n", "gr",
              "<cmd>lua require('lspsaga.rename').rename()<CR>")
    u.buf_map(bufnr, "n", "gd",
              "<cmd>lua require('lspsaga.provider').preview_definition()<CR>")
    u.buf_map(bufnr, "n", "[a",
              "<cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_prev()<CR>")
    u.buf_map(bufnr, "n", "]a",
              "<cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_next()<CR>")
    u.buf_map(bufnr, "n", "<Leader>a",
              "<cmd>lua require('lspsaga.diagnostic').show_line_diagnostics()<CR>")
    u.buf_map(bufnr, "i", "<C-x><C-x>",
              "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>")

    -- enable illuminate highlighting for buffer
    require("illuminate").on_attach(client)
end

nvim_lsp.tsserver.setup {
    on_attach = function(client)
        -- disable to prevent formatting issues
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
        linters = diagnosticls.linters
    }
}

nvim_lsp.bashls.setup {on_attach = on_attach}
nvim_lsp.jsonls.setup {on_attach = on_attach}
nvim_lsp.yamlls.setup {on_attach = on_attach}
