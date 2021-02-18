local saga = require("lspsaga")
saga.init_lsp_saga {
    finder_action_keys = {
        open = "<CR>",
        vsplit = "s",
        split = "i",
        quit = "q",
        scroll_down = "<C-f>",
        scroll_up = "<C-b>"
    }
}
