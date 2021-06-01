local ts_utils = require("nvim-lsp-ts-utils")

local u = require("utils")
local nvim_lsp = require("lspconfig")
local sumneko = require("lsp.sumneko")
local null_ls = require("lsp.null-ls")

local api = vim.api
local lsp = vim.lsp

lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    signs = true,
    virtual_text = false,
})

local popup_opts = { border = "single" }

local peek_definition = function()
    vim.lsp.buf_request(0, "textDocument/definition", lsp.util.make_position_params(), function(_, _, result)
        if result == nil or vim.tbl_isempty(result) then
            return nil
        end
        lsp.util.preview_location(result[1], popup_opts)
    end)
end

-- simplified version of original omnifunc to prevent annoying errors
local omnifunc = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    local row = vim.api.nvim_get_current_line()
    local line = string.sub(row, 1, pos[2])

    local text_match = vim.fn.match(line, "\\k*$")
    local prefix = string.sub(line, text_match + 1)

    lsp.buf_request(
        api.nvim_get_current_buf(),
        "textDocument/completion",
        lsp.util.make_position_params(),
        function(_, _, result)
            if not result or vim.fn.mode() ~= "i" then
                return
            end

            vim.fn.complete(text_match + 1, lsp.util.text_document_completion_list_to_complete_items(result, prefix))
        end
    )

    return -2
end

lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, popup_opts)
lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, popup_opts)

local go_to_diagnostic = function(pos)
    if not pos then
        return
    end

    api.nvim_win_set_cursor(0, { pos[1] + 1, pos[2] })
    vim.schedule(function()
        lsp.diagnostic.show_line_diagnostics(popup_opts, api.nvim_win_get_buf(0))
    end)
end

local next_diagnostic = function()
    go_to_diagnostic(lsp.diagnostic.get_next_pos() or lsp.diagnostic.get_prev_pos())
end

local prev_diagnostic = function()
    go_to_diagnostic(lsp.diagnostic.get_prev_pos() or lsp.diagnostic.get_next_pos())
end

_G.global.lsp = {
    popup_opts = popup_opts,
    peek_definition = peek_definition,
    next_diagnostic = next_diagnostic,
    prev_diagnostic = prev_diagnostic,
    omnifunc = omnifunc,
}

local on_attach = function(client, bufnr)
    -- commands
    u.lua_command("LspPeekDef", "global.lsp.peek_definition()")
    u.lua_command("LspFormatting", "vim.lsp.buf.formatting()")
    u.lua_command("LspHover", "vim.lsp.buf.hover()")
    u.lua_command("LspRename", "vim.lsp.buf.rename()")
    u.lua_command("LspTypeDef", "vim.lsp.buf.type_definition()")
    u.lua_command("LspImplementation", "vim.lsp.buf.implementation()")
    u.lua_command("LspDiagPrev", "global.lsp.prev_diagnostic()")
    u.lua_command("LspDiagNext", "global.lsp.next_diagnostic()")
    u.lua_command("LspDiagLine", "vim.lsp.diagnostic.show_line_diagnostics(global.lsp.popup_opts)")
    u.lua_command("LspSignatureHelp", "vim.lsp.buf.signature_help()")

    -- bindings
    u.buf_map("n", "gh", ":LspPeekDef<CR>", nil, bufnr)
    u.buf_map("n", "gy", ":LspTypeDef<CR>", nil, bufnr)
    u.buf_map("n", "gi", ":LspRename<CR>", nil, bufnr)
    u.buf_map("n", "K", ":LspHover<CR>", nil, bufnr)
    u.buf_map("n", "[a", ":LspDiagPrev<CR>", nil, bufnr)
    u.buf_map("n", "]a", ":LspDiagNext<CR>", nil, bufnr)
    u.buf_map("i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>", nil, bufnr)

    u.buf_augroup("LspAutocommands", "CursorHold", "LspDiagLine")

    if client.resolved_capabilities.document_formatting then
        u.buf_augroup("LspFormatOnSave", "BufWritePost", "lua vim.lsp.buf.formatting()")
    end

    -- telescope
    u.buf_map("n", "ga", ":LspAct<CR>", nil, bufnr)
    u.buf_map("n", "gr", ":LspRef<CR>", nil, bufnr)
    u.buf_map("n", "gd", ":LspDef<CR>", nil, bufnr)

    require("illuminate").on_attach(client)
end

nvim_lsp.tsserver.setup({
    cmd = {
        "typescript-language-server",
        "--stdio",
        "--tsserver-path",
        "/usr/local/bin/tsserver-wrapper",
    },
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        on_attach(client)

        ts_utils.setup({
            enable_import_on_completion = true,
            complete_parens = true,
            signature_help_in_parens = true,
            eslint_bin = "eslint_d",
            eslint_enable_diagnostics = true,
            enable_formatting = true,
            formatter = "eslint_d",
            update_imports_on_move = true,
        })
        ts_utils.setup_client(client)

        u.buf_map("n", "gs", ":TSLspOrganize<CR>", nil, bufnr)
        u.buf_map("n", "gI", ":TSLspRenameFile<CR>", nil, bufnr)
        u.buf_map("n", "gt", ":TSLspImportAll<CR>", nil, bufnr)
        u.buf_map("n", "qq", ":TSLspFixCurrent<CR>", nil, bufnr)
        u.buf_map("i", ".", ".<C-x><C-o>", nil, bufnr)
        vim.opt_local.omnifunc = "v:lua.global.lsp.omnifunc"
    end,
})

nvim_lsp.sumneko_lua.setup({
    on_attach = function(client, bufnr)
        on_attach(client)
        u.buf_map("i", ".", ".<C-x><C-o>", nil, bufnr)
        vim.opt_local.omnifunc = "v:lua.global.lsp.omnifunc"
    end,
    cmd = { sumneko.binary, "-E", sumneko.root .. "main.lua" },
    settings = sumneko.settings,
})

null_ls.setup(on_attach)
