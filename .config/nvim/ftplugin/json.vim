augroup FormatOnSave
    autocmd! * <buffer>
    autocmd BufWritePost <buffer> lua require'nvim-lsp-ts-utils'.format()
augroup END
