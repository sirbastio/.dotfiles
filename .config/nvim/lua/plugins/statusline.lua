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

local function wide_statusline()
    return vim.go.columns >= 95
end

local function format_mode(mode)
    if wide_statusline() then
        return mode
    end

    return mode:sub(1, 1)
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
                        {
                            "branch",
                            icon = "",
                        },
                        {
                            "diff",
                            symbols = { added = " ", modified = " ", removed = " " },
                            -- cond = wide_statusline,
                        },
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
                    lualine_x = {},
                    lualine_y = {
                        "diagnostics",
                        { "lsp_status", symbols = { done = "" } },
                        { "filetype", cond = wide_statusline },
                    },
                    lualine_z = { "location" },
                },
            }
        end,
    },
}
