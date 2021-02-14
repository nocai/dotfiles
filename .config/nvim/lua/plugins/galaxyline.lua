local gl = require("galaxyline")
local gls = gl.section
local colors = require("plugins.galaxyline-colors")

local buffer_not_empty = function()
    if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then return true end
    return false
end

local mode_color = function()
    local mode_colors = {
        [110] = colors.green,
        [105] = colors.blue,
        [99] = colors.green,
        [116] = colors.blue,
        [118] = colors.magenta,
        [22] = colors.magenta,
        [86] = colors.magenta,
        [82] = colors.red,
        [115] = colors.red,
        [83] = colors.red
    }

    local mode_color = mode_colors[vim.fn.mode():byte()]
    if mode_color ~= nil then
        return mode_color
    else
        return colors.magenta
    end
end

local function file_readonly()
    if vim.bo.filetype == "help" then return "" end
    if vim.bo.readonly == true then return "  " end
    return ""
end

local function get_current_file_name()
    local file = vim.fn.expand("%:t")
    if vim.fn.empty(file) == 1 then return "" end
    if string.len(file_readonly()) ~= 0 then return file .. file_readonly() end
    if vim.bo.modifiable then
        if vim.bo.modified then return file .. "  " end
    end
    return file .. " "
end

-- left
gls.left[1] = {
    ViMode = {
        provider = function()
            local aliases = {
                [110] = "NORMAL",
                [105] = "INSERT",
                [99] = "COMMAND",
                [116] = "TERMINAL",
                [118] = "VISUAL",
                [22] = "V-BLOCK",
                [86] = "V-LINE",
                [82] = "REPLACE",
                [115] = "SELECT",
                [83] = "S-LINE"
            }
            vim.api.nvim_command("hi GalaxyViMode guibg=" .. mode_color())
            local alias = aliases[vim.fn.mode():byte()]
            local mode = ""
            if alias ~= nil then
                mode = alias
            else
                mode = vim.fn.mode():byte()
            end
            return "  " .. mode .. " "
        end,
        highlight = {colors.background, colors.background}
    }
}
gls.left[2] = {
    FileIcon = {
        provider = {function() return "  " end, "FileIcon"},
        condition = buffer_not_empty,
        highlight = {
            require("galaxyline.provider_fileinfo").get_file_icon, colors.gray
        }
    }
}
gls.left[3] = {
    FileName = {
        provider = get_current_file_name,
        condition = buffer_not_empty,
        highlight = {colors.foreground, colors.gray},
        separator = " ",
        separator_highlight = {colors.gray, colors.background}
    }
}
gls.left[4] = {
    DiagnosticError = {
        provider = "DiagnosticError",
        icon = "  ",
        highlight = {colors.red, colors.background}
    }
}
gls.left[5] = {
    Space = {
        provider = function() return " " end,
        highlight = {colors.gray, colors.background}
    }
}
gls.left[6] = {
    DiagnosticWarn = {
        provider = "DiagnosticWarn",
        icon = "  ",
        highlight = {colors.yellow, colors.background}
    }
}
gls.left[7] = {
    Space = {
        provider = function() return " " end,
        highlight = {colors.gray, colors.background}
    }
}
gls.left[8] = {
    DiagnosticInfo = {
        provider = "DiagnosticInfo",
        icon = "  ",
        highlight = {colors.blue, colors.gray},
        separator = " ",
        separator_highlight = {colors.gray, colors.background}
    }
}

gls.right[1] = {
    DiffAdd = {
        provider = "DiffAdd",
        icon = "+",
        highlight = {colors.green, colors.background}
    }
}
gls.right[2] = {
    DiffModified = {
        provider = "DiffModified",
        icon = "~",
        highlight = {colors.yellow, colors.background}
    }
}
gls.right[3] = {
    DiffRemove = {
        provider = "DiffRemove",
        icon = "-",
        highlight = {colors.red, colors.background}
    }
}
gls.right[4] = {
    Space = {
        provider = function() return " " end,
        highlight = {colors.gray, colors.background}
    }
}
gls.right[5] = {
    GitIcon = {
        provider = function() return "  " end,
        condition = buffer_not_empty and
            require("galaxyline.provider_vcs").check_git_workspace,
        highlight = {colors.cyan, colors.background}
    }
}
gls.right[6] = {
    GitBranch = {
        provider = "GitBranch",
        condition = buffer_not_empty,
        highlight = {colors.cyan, colors.background}
    }
}
gls.right[7] = {
    PerCent = {
        provider = "LinePercent",
        separator = " ",
        separator_highlight = {colors.blue, colors.background},
        highlight = {colors.gray, colors.blue}
    }
}
