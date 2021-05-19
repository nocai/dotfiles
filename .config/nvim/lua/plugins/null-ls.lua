local null_ls = require("null-ls")

null_ls.register({
    {
        method = null_ls.methods.DIAGNOSTICS,
        generators = {null_ls.builtins.write_good}
    }, {
        method = null_ls.methods.CODE_ACTION,
        generators = {null_ls.builtins.toggle_line_comment}
    }
})
null_ls.setup()
