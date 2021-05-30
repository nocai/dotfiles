local format = string.format
local api = vim.api
local exists = vim.fn.exists

local exec = function(cmd)
	api.nvim_exec(cmd, false)
end

local start_case = function(str)
	return string.upper(string.sub(str, 1, 1)) .. string.sub(str, 2)
end

local ft_autocmd = function(ft, fn, event)
	local augroup = start_case(ft) .. "Filetype"
	if not exists("#" .. augroup) then
		exec(format([[
        augroup %s
            autocmd!
        augroup END
        ]], augroup))
	end

	exec(format(
		[[
    augroup %s
        autocmd %s lua global.filetypes.%s.%s()
    augroup END
    ]],
		augroup,
		event or ("FileType " .. ft),
		ft,
		fn
	))
end

_G.global.filetypes = {}

_G.global.filetypes.term = {
	setup = function()
		vim.cmd("startinsert")
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
	end,
	breakdown = function()
		if not string.match(vim.fn.expand("<afile>"), "nnn") then
			vim.api.nvim_input("<CR>")
		end
	end,
}
ft_autocmd("term", "setup", "TermOpen *")
ft_autocmd("term", "breakdown", "TermClose *")

_G.global.filetypes.markdown = {
	setup = function()
		vim.opt_local.textwidth = 80
		vim.opt_local.spell = true
	end,
}
ft_autocmd("markdown", "setup")

_G.global.filetypes.typescriptreact = {
	setup = function()
		vim.cmd("UltiSnipsAddFiletypes typescript")
	end,
}
ft_autocmd("typescriptreact", "setup")
