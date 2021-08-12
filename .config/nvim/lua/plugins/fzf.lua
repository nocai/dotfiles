local actions = require("fzf-lua.actions")

local u = require("utils")
local commands = require("commands")

-- replace current buffer with selected
local breplace = function(selected)
    commands.bdelete()
    for _, file in ipairs(vim.list_slice(selected, 2)) do
        vim.cmd("e " .. file)
    end
end

-- delete all buffers and open selected
local bonly = function(selected)
    commands.bwipeall()
    for _, file in ipairs(vim.list_slice(selected, 2)) do
        vim.cmd("e " .. file)
    end
end

-- open file and test file in split
local split_test_file = function(selected)
    vim.cmd("e " .. selected[2])
    commands.edit_test_file("Vsplit", function()
        vim.cmd("wincmd w")
    end)
end

local vsplit = function(selected)
    commands.vsplit(selected[2])
end

local file_actions = {
    ["default"] = actions.file_edit,
    ["ctrl-t"] = actions.file_tabedit,
    ["ctrl-q"] = actions.file_sel_to_qf,
    ["ctrl-f"] = split_test_file,
    ["ctrl-x"] = bonly,
    ["ctrl-r"] = breplace,
    ["ctrl-v"] = vsplit,
}

require("fzf-lua").setup({
    fzf_layout = "default",
    winopts = { win_height = 0.85, win_width = 0.90 },
    fzf_binds = {
        "ctrl-u:clear-query",
        "alt-p:toggle-preview",
    },
    previewers = {
        bat = { theme = "ansi" },
    },
    files = {
        actions = file_actions,
    },
    grep = {
        -- only search file content, not names
        rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case",
        actions = file_actions,
    },
    lsp = {
        -- make lsp requests synchronous so they work with null-ls
        async_or_timeout = 3000,
    },
})

u.lua_command("LspActions", 'require("fzf-lua").lsp_code_actions()')
u.lua_command("LspRefs", 'require("fzf-lua").lsp_references({ jump_to_single_result = true })')
u.lua_command("LspDefs", 'require("fzf-lua").lsp_definitions({ jump_to_single_result = true })')
u.lua_command("LspTypeDefs", 'require("fzf-lua").lsp_typedefs({ jump_to_single_result = true })')

u.nmap("<Leader>ff", ":FzfLua files<CR>")
u.nmap("<Leader>fb", ":FzfLua buffers<CR>")
u.nmap("<Leader>fl", ":FzfLua grep_curbuf<CR>")
u.nmap("<Leader>fg", ":FzfLua live_grep<CR>")
u.nmap("<Leader>fo", ":FzfLua oldfiles<CR>")
u.nmap("<Leader>fh", ":FzfLua help_tags<CR>")
u.nmap("<Leader>fc", ":FzfLua git_bcommits<CR>")
