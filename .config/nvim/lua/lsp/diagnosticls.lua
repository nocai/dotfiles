local M = {}

M.filetypes = {
    markdown = {"markdownlint", "writeGood"},
    lua = ""
}

M.linters = {
    markdownlint = {
        command = "markdownlint",
        rootPatterns = {".git"},
        isStderr = true,
        debounce = 100,
        args = {
            "--config", vim.fn.getenv("HOME") .. "/.markdownlint.json",
            "--stdin"
        },
        offsetLine = 0,
        offsetColumn = 0,
        sourceName = "markdownlint",
        securities = {undefined = "hint"},
        formatLines = 1,
        formatPattern = {
            "^.*:(\\d+)\\s+(.*)$", {line = 1, column = -1, message = 2}
        }
    },
    writeGood = {
        command = "write-good",
        debounce = 100,
        args = {"--text=%text"},
        offsetLine = 0,
        offsetColumn = 1,
        sourceName = "write-good",
        formatLines = 1,
        formatPattern = {
            "(.*)\\s+on\\s+line\\s+(\\d+)\\s+at\\s+column\\s+(\\d+)\\s*$",
            {line = 2, column = 3, message = 1}
        }
    }
}

M.formatters = {
    luaFormat = {
        command = "lua-format",
        args = {"--single-quote-to-double-quote", "-i"}
    },
}

M.formatFiletypes = {lua = "luaFormat"}

return M
