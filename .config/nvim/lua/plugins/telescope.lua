local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

local u = require("utils")

local api = vim.api

telescope.setup({
    extensions = {
        fzf = { override_generic_sorter = true, override_file_sorter = true },
    },
    defaults = { mappings = { i = { ["<Esc>"] = actions.close, ["<C-u>"] = false } } },
})

-- try git_files and fall back to find_files
local find_files = function()
    local current = api.nvim_get_current_buf()
    local find_files_opts = {
        attach_mappings = function(_, map)
            -- replace current buffer with selected
            map("i", "<C-r>", function(prompt_bufnr)
                require("telescope.actions.set").edit(prompt_bufnr, "edit")
                require("commands").bdelete(current)
            end)

            return true
        end,
    }

    local is_git_project = pcall(builtin.git_files, find_files_opts)
    if not is_git_project then
        builtin.find_files(find_files_opts)
    end
end

_G.global.telescope = {
    -- live grep in project (slow)
    live_grep = function()
        builtin.grep_string({
            shorten_path = true,
            word_match = "-w",
            only_sort_text = true,
            search = "",
            vimgrep_arguments = vim.list_extend(require("telescope.config").values.vimgrep_arguments, {
                "--hidden",
                "-g",
                "!{node_modules,.git}",
            }),
        })
    end,

    -- grep string from prompt (fast, but less convenient)
    grep_prompt = function()
        builtin.grep_string({
            shorten_path = true,
            search = vim.fn.input("grep > "),
        })
    end,

    find_files = find_files,
}

u.lua_command("Files", "global.telescope.find_files()")
u.lua_command("Rg", "global.telescope.live_grep()")
u.lua_command("GrepPrompt", "global.telescope.grep_prompt()")
u.command("BLines", "Telescope current_buffer_fuzzy_find")
u.command("History", "Telescope oldfiles")
u.command("Buffers", "Telescope buffers")
u.command("BCommits", "Telescope git_bcommits")
u.command("Commits", "Telescope git_commits")
u.command("HelpTags", "Telescope help_tags")
u.command("ManPages", "Telescope man_pages")

u.map("n", "<Leader>H", ":HelpTags<CR>")

u.map("n", "<Leader>ff", "<cmd>Files<CR>")
u.map("n", "<Leader>fg", "<cmd>Rg<CR>")
u.map("n", "<Leader>fb", "<cmd>Buffers<CR>")
u.map("n", "<Leader>fh", "<cmd>History<CR>")
u.map("n", "<Leader>fl", "<cmd>BLines<CR>")
u.map("n", "<Leader>fs", "<cmd>LspSym<CR>")

-- lsp
u.command("LspRef", "Telescope lsp_references")
u.command("LspDef", "Telescope lsp_definitions")
u.command("LspSym", "Telescope lsp_workspace_symbols")
u.command("LspAct", "Telescope lsp_code_actions")
