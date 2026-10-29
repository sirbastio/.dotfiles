local function lualine_theme()
    local theme = vim.deepcopy(require("lualine.themes.github_dark_default"))
    local spec = require("github-theme.spec").load("github_dark_default")

    for _, mode in ipairs({ "normal", "insert", "visual", "replace", "command", "terminal", "inactive" }) do
        theme[mode].b.bg = spec.bg0
        theme[mode].b.fg = spec.palette.scale.gray[2]
        theme[mode].c.bg = spec.bg0
        theme[mode].c.fg = spec.palette.scale.gray[2]
    end

    return theme
end

local function muted_component_color()
    local spec = require("github-theme.spec").load("github_dark_default")
    return { bg = spec.bg0, fg = spec.fg2 }
end

local function wide_statusline()
    return vim.go.columns >= 95
end

local function format_mode(mode)
    if wide_statusline() then
        return mode
    end

    return mode:sub(1, 1)
end

local function plural(count, word)
    return string.format("%d %s%s", count, word, count == 1 and "" or "s")
end

local function position()
    local mode = vim.fn.mode()
    local lines = math.abs(vim.fn.line("v") - vim.fn.line(".")) + 1

    if mode == "\22" then
        return string.format("%dx%d", lines, math.abs(vim.fn.virtcol("v") - vim.fn.virtcol(".")) + 1)
    elseif mode == "v" and lines == 1 then
        return plural(math.abs(vim.fn.charcol("v") - vim.fn.charcol(".")) + 1, "char")
    elseif mode == "v" or mode == "V" then
        return plural(lines, "line")
    end

    return string.format("%3d:%-2d", vim.fn.line("."), vim.fn.charcol("."))
end

local function formatter()
    local formatters, uses_lsp = require("conform").list_formatters_to_run(0)
    local names = vim.tbl_map(function(item)
        return item.name
    end, formatters)

    if uses_lsp then
        table.insert(names, "LSP")
    end

    if vim.tbl_isempty(names) then
        return ""
    end

    return "󰉼 " .. table.concat(names, ", ")
end

local function linters()
    local lint = require("lint")
    local names = lint.linters_by_ft[vim.bo.filetype] or {}

    if vim.tbl_isempty(names) then
        return ""
    end

    return "󰃢 " .. table.concat(names, ", ")
end

return {
    -- { "nvim-mini/mini.statusline", version = false, opts = {} },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = function()
            return {
                options = {
                    globalstatus = true,
                    section_separators = { left = "", right = "" },
                    component_separators = { left = "", right = "" },
                    theme = lualine_theme(),
                },
                sections = {
                    lualine_a = { { "mode", fmt = format_mode } },
                    lualine_b = {
                        { "branch", icon = "" },
                        { "diff", symbols = { added = " ", modified = " ", removed = " " } },
                    },
                    lualine_c = {
                        {
                            "filename",
                            path = 1,
                            file_status = false,
                            cond = wide_statusline,
                        },
                        {
                            "filename",
                            path = 0,
                            file_status = false,
                            cond = function()
                                return not wide_statusline()
                            end,
                        },
                    },
                    lualine_x = {
                        { linters, cond = wide_statusline },
                        { formatter, cond = wide_statusline },
                    },
                    lualine_y = {
                        {
                            "lsp_status",
                            symbols = { done = "" },
                            cond = wide_statusline,
                        },
                        "diagnostics",
                        "filetype",
                    },
                    lualine_z = { { position, color = muted_component_color } },
                },
            }
        end,
    },
}
