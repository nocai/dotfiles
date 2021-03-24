vim.g.indent_blankline_char = " "
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_context_patterns =
    {
        "class", "function", "method", "return_statement", "jsx_element",
        "jsx_self_closing_element"
    }

vim.g.indent_blankline_context_highlight = "MatchParen"
vim.g.indent_blankline_space_char_highlight = "CursorLine"
