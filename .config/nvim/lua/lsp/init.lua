local ts_utils = require("nvim-lsp-ts-utils")

local u = require("utils")
local nvim_lsp = require("lspconfig")
local sumneko = require("lsp.sumneko")
local null_ls = require("lsp.null-ls")

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

lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, popup_opts)
lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, popup_opts)

_G.global.lsp = { popup_opts = popup_opts, peek_definition = peek_definition }

local on_attach = function(client, bufnr)
	-- commands
	u.lua_command("LspDef", "vim.lsp.buf.definition()")
	u.lua_command("LspPeekDef", "global.lsp.peek_definition()")
	u.lua_command("LspFormatting", "vim.lsp.buf.formatting()")
	u.lua_command("LspHover", "vim.lsp.buf.hover()")
	u.lua_command("LspRename", "vim.lsp.buf.rename()")
	u.lua_command("LspTypeDef", "vim.lsp.buf.type_definition()")
	u.lua_command("LspImplementation", "vim.lsp.buf.implementation()")
	u.lua_command("LspDiagPrev", "vim.lsp.diagnostic.goto_prev({popup_opts = global.lsp.popup_opts})")
	u.lua_command("LspDiagNext", "vim.lsp.diagnostic.goto_next({popup_opts = global.lsp.popup_opts})")
	u.lua_command("LspDiagLine", "vim.lsp.diagnostic.show_line_diagnostics(global.lsp.popup_opts)")
	u.lua_command("LspSignatureHelp", "vim.lsp.buf.signature_help()")

	-- bindings
	u.buf_map("n", "gd", ":LspDef<CR>", nil, bufnr)
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
			debug = true,
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
		vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
	end,
})

nvim_lsp.sumneko_lua.setup({
	on_attach = function(client, bufnr)
		on_attach(client)
		u.buf_map("i", ".", ".<C-x><C-o>", nil, bufnr)
		vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
	end,
	cmd = { sumneko.binary, "-E", sumneko.root .. "main.lua" },
	settings = sumneko.settings,
})

null_ls.setup(on_attach)
