local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local set = require("telescope.actions.set")

local u = require("utils")
local commands = require("commands")

telescope.setup({
    extensions = {
        fzf = { fuzzy = true, override_generic_sorter = true, override_file_sorter = true },
    },
    defaults = { vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--ignore",
        "--hidden",
        "-g",
        "!.git",
    }, mappings = {
        i = { ["<Esc>"] = actions.close, ["<C-u>"] = false },
    } },
})

telescope.load_extension("fzf")

_G.global.telescope = {
    -- try git_files and fall back to find_files
    find_files = function()
        local opts = {
            attach_mappings = function(_, map)
                -- edit file and matching test file in split
                map("i", "<C-f>", function(prompt_bufnr)
                    set.edit(prompt_bufnr, "edit")

                    commands.wwipeall()
                    commands.edit_test_file("vsplit", function()
                        vim.cmd("wincmd w")
                    end)
                end)

                return true
            end,
        }

        local is_git_project = pcall(builtin.git_files, opts)
        if not is_git_project then
            builtin.find_files(opts)
        end
    end,
}

u.lua_command("Files", "global.telescope.find_files()")
u.command("Rg", "Telescope live_grep")
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
