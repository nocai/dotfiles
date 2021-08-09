local u = require("utils")
local sumneko = require("lsp.sumneko")
local null_ls = require("lsp.null-ls")
local tsserver = require("lsp.tsserver")

local api = vim.api
local lsp = vim.lsp

lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    signs = true,
    virtual_text = false,
})

local popup_opts = { border = "single", focusable = false }

lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, popup_opts)
lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, popup_opts)

local go_to_diagnostic = function(pos)
    return pos and api.nvim_win_set_cursor(0, { pos[1] + 1, pos[2] })
end

local next_diagnostic = function()
    go_to_diagnostic(lsp.diagnostic.get_next_pos() or lsp.diagnostic.get_prev_pos())
    vim.schedule(function()
        lsp.diagnostic.show_line_diagnostics(popup_opts)
    end)
end

local prev_diagnostic = function()
    go_to_diagnostic(lsp.diagnostic.get_prev_pos() or lsp.diagnostic.get_next_pos())
    vim.schedule(function()
        lsp.diagnostic.show_line_diagnostics(popup_opts)
    end)
end

_G.global.lsp = {
    popup_opts = popup_opts,
    next_diagnostic = next_diagnostic,
    prev_diagnostic = prev_diagnostic,
}

local on_attach = function(client, bufnr)
    -- commands
    u.lua_command("LspAct", "vim.lsp.buf.code_action()")
    u.lua_command("LspRef", "vim.lsp.buf.references()")
    u.lua_command("LspDef", "vim.lsp.buf.definition()")
    u.lua_command("LspFormatting", "vim.lsp.buf.formatting()")
    u.lua_command("LspHover", "vim.lsp.buf.hover()")
    u.lua_command("LspRename", "vim.lsp.buf.rename()")
    u.lua_command("LspTypeDef", "vim.lsp.buf.type_definition()")
    u.lua_command("LspImplementation", "vim.lsp.buf.implementation()")
    u.lua_command("LspDiagPrev", "global.lsp.prev_diagnostic()")
    u.lua_command("LspDiagNext", "global.lsp.next_diagnostic()")
    u.lua_command("LspDiagLine", "vim.lsp.diagnostic.show_line_diagnostics(global.lsp.popup_opts)")

    -- bindings
    u.buf_map("n", "ga", ":LspAct<CR>", nil, bufnr)
    u.buf_map("n", "gr", ":LspRef<CR>", nil, bufnr)
    u.buf_map("n", "gd", ":LspDef<CR>", nil, bufnr)
    u.buf_map("n", "gy", ":LspTypeDef<CR>", nil, bufnr)
    u.buf_map("n", "gi", ":LspRename<CR>", nil, bufnr)
    u.buf_map("n", "K", ":LspHover<CR>", nil, bufnr)
    u.buf_map("n", "[a", ":LspDiagPrev<CR>", nil, bufnr)
    u.buf_map("n", "]a", ":LspDiagNext<CR>", nil, bufnr)
    u.buf_map("n", "<Leader>a", ":LspDiagLine<CR>", nil, bufnr)

    if client.resolved_capabilities.document_formatting then
        u.buf_augroup("LspFormatOnSave", "BufWritePre", "lua vim.lsp.buf.formatting_sync()")
    end

    require("lsp_compl").attach(client, bufnr)
    require("illuminate").on_attach(client)
    require("lspfuzzy").setup({})
end

tsserver.setup(on_attach)
sumneko.setup(on_attach)
null_ls.setup(on_attach)
