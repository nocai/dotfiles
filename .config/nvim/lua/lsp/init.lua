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
_G.lsp_omnifunc = function(...)
    local ok, results = pcall(lsp.omnifunc, ...)
    return not ok and nil or results
end

local on_attach = function(client, bufnr)
    -- commands
    u.define_command("LspDef", "vim.lsp.buf.definition()")
    u.define_command("LspFormatting", "vim.lsp.buf.formatting()")
    u.define_command("LspCodeAction", "vim.lsp.buf.code_action()")
    u.define_command("LspHover", "vim.lsp.buf.hover()")
    u.define_command("LspRename", "vim.lsp.buf.rename()")
    u.define_command("LspTypeDef", "vim.lsp.buf.type_definition()")
    u.define_command("LspImplementation", "vim.lsp.buf.implementation()")
    u.define_command("LspDiagPrev",
                     "vim.lsp.diagnostic.goto_prev({popup_opts = lsp_popup_opts})")
    u.define_command("LspDiagNext",
                     "vim.lsp.diagnostic.goto_next({popup_opts = lsp_popup_opts})")
    u.define_command("LspDiagLine",
                     "vim.lsp.diagnostic.show_line_diagnostics(lsp_popup_opts)")
    u.define_command("LspSignatureHelp", "vim.lsp.buf.signature_help()")

    -- bindings
    u.buf_map(bufnr, "n", "gd", ":LspDef<CR>")
    u.buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>")
    u.buf_map(bufnr, "n", "gi", ":LspRename<CR>")
    u.buf_map(bufnr, "n", "K", ":LspHover<CR>")
    u.buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>")
    u.buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>")
    u.buf_map(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>")
    u.buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>")

    u.define_buf_augroup("LspAutocommands", "CursorHold", "LspDiagLine")

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

        _G.lsp_formatting = functions.lua_format
        u.define_buf_augroup("LspFormatOnSave", "BufWritePost",
                             "lua lsp_formatting()")
    end,
    cmd = {sumneko.binary, "-E", sumneko.root .. "/main.lua"},
    settings = sumneko.settings
}
