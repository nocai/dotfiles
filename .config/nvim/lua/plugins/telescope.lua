local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local conf = require("telescope.config").values
local u = require("utils")

local vimgrep_arguments = vim.list_extend(conf.vimgrep_arguments, {
    "--hidden", "-g", "!{node_modules,.git}"
})

telescope.setup {
    extensions = {
        fzf = {override_generic_sorter = true, override_file_sorter = true}
    },
    defaults = {mappings = {i = {["<Esc>"] = actions.close, ["<C-u>"] = false}}}
}

local find_files = function(opts)
    if opts and opts.search_dirs then
        builtin.find_files(opts)
        return
    end

    local is_git_project = pcall(builtin.git_files, opts)
    if not is_git_project then builtin.find_files(opts) end
end

_G.telescope_custom = {
    live_grep = function()
        builtin.grep_string {
            shorten_path = true,
            word_match = "-w",
            only_sort_text = true,
            search = "",
            vimgrep_arguments = vimgrep_arguments
        }
    end,
    find_files = find_files
}

u.lua_command("Files", "telescope_custom.find_files()")
u.lua_command("Rg", "telescope_custom.live_grep()")
u.command("BLines", "Telescope current_buffer_fuzzy_find")
u.command("History", "Telescope oldfiles")
u.command("Buffers", "Telescope buffers")
u.command("BCommits", "Telescope git_bcommits")
u.command("Commits", "Telescope git_commits")

u.map("n", "<Leader>ff", "<cmd>Files<CR>")
u.map("n", "<Leader>fg", "<cmd>Rg<CR>")
u.map("n", "<Leader>fb", "<cmd>Buffers<CR>")
u.map("n", "<Leader>fh", "<cmd>History<CR>")
u.map("n", "<Leader>fl", "<cmd>BLines<CR>")
u.map("n", "<Leader>fs", "<cmd>LspSym<CR>")

-- lsp
u.command("LspRef", "Telescope lsp_references")
u.command("LspSym", "Telescope lsp_workspace_symbols")
u.command("LspAct", "Telescope lsp_code_actions")

u.map("n", "ga", "<cmd>LspAct<CR>")
u.map("n", "gr", "<cmd>LspRef<CR>")
