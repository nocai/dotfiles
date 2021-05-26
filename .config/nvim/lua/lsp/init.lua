local ts_utils = require("nvim-lsp-ts-utils")

local u = require("utils")
local nvim_lsp = require("lspconfig")
local sumneko = require("lsp.sumneko")
local null_ls = require("lsp.null-ls")

local api = vim.api
local lsp = vim.lsp

lsp.handlers["textDocument/publishDiagnostics"] =
    lsp.with(lsp.diagnostic.on_publish_diagnostics,
             {underline = true, signs = true, virtual_text = false})

local popup_opts = {border = "single"}

lsp.handlers["textDocument/signatureHelp"] =
    lsp.with(lsp.handlers.signature_help, popup_opts)
lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, popup_opts)

_G.lsp_custom = {popup_opts = popup_opts}

local on_attach = function(client, bufnr)
    -- commands
    u.define_lua_command("LspDef", "vim.lsp.buf.definition()")
    u.define_lua_command("LspFormatting", "vim.lsp.buf.formatting()")
    u.define_lua_command("LspHover", "vim.lsp.buf.hover()")
    u.define_lua_command("LspRename", "vim.lsp.buf.rename()")
    u.define_lua_command("LspTypeDef", "vim.lsp.buf.type_definition()")
    u.define_lua_command("LspImplementation", "vim.lsp.buf.implementation()")
    u.define_lua_command("LspDiagPrev",
                         "vim.lsp.diagnostic.goto_prev({popup_opts = lsp_custom.popup_opts})")
    u.define_lua_command("LspDiagNext",
                         "vim.lsp.diagnostic.goto_next({popup_opts = lsp_custom.popup_opts})")
    u.define_lua_command("LspDiagLine",
                         "vim.lsp.diagnostic.show_line_diagnostics(lsp_custom.popup_opts)")
    u.define_lua_command("LspSignatureHelp", "vim.lsp.buf.signature_help()")

    -- bindings
    u.map("n", "gd", ":LspDef<CR>", nil, bufnr)
    u.map("n", "gy", ":LspTypeDef<CR>", nil, bufnr)
    u.map("n", "gi", ":LspRename<CR>", nil, bufnr)
    u.map("n", "K", ":LspHover<CR>", nil, bufnr)
    u.map("n", "[a", ":LspDiagPrev<CR>", nil, bufnr)
    u.map("n", "]a", ":LspDiagNext<CR>", nil, bufnr)
    u.map("n", "<Leader>a", ":LspDiagLine<CR>", nil, bufnr)
    u.map("i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>", nil, bufnr)

    u.define_buf_augroup("LspAutocommands", "CursorHold", "LspDiagLine")
    api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    if client.resolved_capabilities.document_formatting then
        u.define_buf_augroup("LspFormatOnSave", "BufWritePost",
                             "lua vim.lsp.buf.formatting()")
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

        ts_utils.setup {
            debug = true,
            enable_import_on_completion = true,
            complete_parens = true,
            signature_help_in_parens = true,
            eslint_bin = "eslint_d",
            eslint_enable_diagnostics = true,
            enable_formatting = true,
            formatter = "eslint_d",
            update_imports_on_move = true
        }
        ts_utils.setup_client(client)

        u.map("n", "gs", ":TSLspOrganize<CR>", nil, bufnr)
        u.map("n", "gI", ":TSLspRenameFile<CR>", nil, bufnr)
        u.map("n", "gt", ":TSLspImportAll<CR>", nil, bufnr)
        u.map("n", "qq", ":TSLspFixCurrent<CR>", nil, bufnr)
        u.map("i", ".", ".<C-x><C-o>", nil, bufnr)
    end
}

nvim_lsp.sumneko_lua.setup {
    on_attach = function(client, bufnr)
        on_attach(client)
        u.map("i", ".", ".<C-x><C-o>", nil, bufnr)
    end,
    cmd = {sumneko.binary, "-E", sumneko.root .. "main.lua"},
    settings = sumneko.settings
}

null_ls.setup(on_attach)
