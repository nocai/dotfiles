local null_ls = require("null-ls")
local b = null_ls.builtins

local sources = {
    b.formatting.prettierd.with({
        filetypes = { "html", "json", "yaml", "markdown" },
    }),
    b.formatting.stylua.with({ args = { "--config-path", vim.fn.stdpath("config") .. "/lua/stylua.toml", "-" } }),
    b.formatting.trim_whitespace.with({ filetypes = { "tmux", "teal" } }),
    b.formatting.fish_indent,
    b.formatting.shfmt,
    b.diagnostics.write_good,
    b.diagnostics.markdownlint,
    b.diagnostics.teal,
    b.diagnostics.shellcheck,
    b.diagnostics.misspell,
    b.code_actions.gitsigns,
}

local M = {}
M.setup = function(on_attach)
    null_ls.config({
        sources = sources,
    })
    require("lspconfig")["null-ls"].setup({ on_attach = on_attach })
end

return M
