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

-- the file name turns yellow while the buffer has unsaved changes
local function filename_color()
    if vim.bo.modified then
        return { fg = require("github-theme.spec").load("github_dark_default").palette.yellow.base }
    end
end

-- clicking the file name copies its full path to the system clipboard
local function copy_path()
    vim.fn.setreg("+", vim.fn.expand("%:p"))
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

-- cspell reports spelling as ordinary diagnostics, so the two are counted apart
local function is_spelling(diagnostic)
    return diagnostic.source == "cspell"
end

local function code_diagnostics()
    local counts = { 0, 0, 0, 0 }
    for _, diagnostic in ipairs(vim.diagnostic.get(0)) do
        if not is_spelling(diagnostic) then
            counts[diagnostic.severity] = counts[diagnostic.severity] + 1
        end
    end
    return { error = counts[1], warn = counts[2], info = counts[3], hint = counts[4] }
end

local function spelling()
    local count = #vim.tbl_filter(is_spelling, vim.diagnostic.get(0))
    -- a solid pencil, the same weight as the diagnostics' own icons
    return count > 0 and ("\u{f03eb} " .. count) or ""
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
                        { "branch", on_click = function() vim.cmd("Neogit") end, icon ="" },
                        { "diff", on_click = function() Snacks.picker.git_diff() end, symbols ={ added = " ", modified = " ", removed = " " } },
                    },
                    lualine_c = {
                        {
                            "filename",
                            path = 1,
                            file_status = false,
                            color = filename_color,
                            on_click = copy_path,
                            cond = wide_statusline,
                        },
                        {
                            "filename",
                            path = 0,
                            file_status = false,
                            color = filename_color,
                            on_click = copy_path,
                            cond = function()
                                return not wide_statusline()
                            end,
                        },
                    },
                    lualine_x = {
                        { linters, cond = wide_statusline },
                        {
                            formatter,
                            cond = wide_statusline,
                            on_click = function() require("conform").format({ async = true }) end,
                        },
                    },
                    lualine_y = {
                        {
                            "lsp_status",
                            symbols = { done = "" },
                            cond = wide_statusline,
                            on_click = function() vim.cmd("checkhealth vim.lsp") end,
                        },
                        {
                            "diagnostics",
                            sources = { code_diagnostics },
                            on_click = function() vim.cmd("Trouble diagnostics_clean toggle") end,
                        },
                        { spelling, color = muted_component_color, on_click =function() vim.cmd("Trouble spelling toggle") end },
                        "filetype",
                    },
                    lualine_z = { { position, color = muted_component_color } },
                },
            }
        end,
    },
}
