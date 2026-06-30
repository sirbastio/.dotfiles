return {
    {
        "projekt0n/github-nvim-theme",
        name = "github-theme",
        lazy = false,
        priority = 1000,
        config = function()
            local function barbar_groups()
                local statuses = {
                    Alternate = { bg = "bg1", fg = "fg1" },
                    Current = { bg = "bg1", fg = "fg1" },
                    Inactive = { bg = "bg0", fg = "fg2" },
                    Visible = { bg = "bg1", fg = "fg2" },
                }

                local parts = {
                    ADDED = "palette.success.fg",
                    CHANGED = "palette.attention.fg",
                    DELETED = "palette.danger.fg",
                    ERROR = "palette.danger.fg",
                    HINT = "fg2",
                    INFO = "palette.accent.fg",
                    Index = "fg2",
                    Mod = "palette.attention.fg",
                    Number = "fg2",
                    Target = "palette.danger.fg",
                    WARN = "palette.attention.fg",
                }

                local groups = {
                    BufferOffset = { bg = "bg0", fg = "fg2" },
                    BufferScrollArrow = { bg = "bg0", fg = "fg2" },
                    BufferTabpageFill = { bg = "bg0", fg = "bg0" },
                    BufferTabpages = { bg = "bg0", fg = "fg2" },
                    BufferTabpagesSep = { bg = "bg0", fg = "palette.border.muted" },
                }

                for status, colors in pairs(statuses) do
                    local prefix = "Buffer" .. status

                    groups[prefix] = { bg = colors.bg, fg = colors.fg }
                    groups[prefix .. "Icon"] = { bg = colors.bg, fg = colors.fg }
                    groups[prefix .. "Sign"] = { bg = colors.bg, fg = colors.bg }
                    groups[prefix .. "SignRight"] = { bg = colors.bg, fg = "palette.border.default" }

                    for part, fg in pairs(parts) do
                        groups[prefix .. part] = { bg = colors.bg, fg = fg }
                    end
                end

                return groups
            end

            require("github-theme").setup({
                options = {
                    transparent = true,
                },
                groups = {
                    github_dark_default = vim.tbl_extend("force", {
                        CursorLine = { bg = "bg2" },
                        NormalFloat = { bg = "bg0" },
                        FloatBorder = { fg = "palette.border.default", bg = "bg0" },
                        SnacksNormal = { bg = "NONE" },
                        SnacksTitle = { bg = "bg0" },
                        SnacksPickerPreviewTitle = { bg = "bg0" },
                        SnacksLazygitInactiveBorder = { fg = "palette.neutral.muted" },
                        SnacksIndent = { fg = "palette.border.subtle" },
                        SnacksIndentScope = { fg = "palette.neutral.muted" },
                        SnacksIndentChunk = { fg = "palette.neutral.muted" },
                        RainbowDelimiterRed = { fg = "palette.danger.fg" },
                        RainbowDelimiterYellow = { fg = "palette.attention.fg" },
                        RainbowDelimiterBlue = { fg = "palette.accent.fg" },
                        RainbowDelimiterOrange = { fg = "palette.severe.fg" },
                        RainbowDelimiterGreen = { fg = "palette.success.fg" },
                        RainbowDelimiterViolet = { fg = "palette.done.fg" },
                        RainbowDelimiterCyan = { fg = "palette.cyan.base" },
                    }, barbar_groups()),
                },
            })
            vim.cmd.colorscheme("github_dark_default")
        end,
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                transparent = true,
                style = "night",
                on_highlights = function(highlights, colors)
                    highlights.GitSignsChange = { fg = colors.yellow }
                    highlights.WinBar = { bg = colors.none, fg = colors.none }
                    highlights.WinBarNC = { bg = colors.none, fg = colors.none }
                    highlights.SnacksLazygitNormal = { fg = colors.fg, bg = "NONE" }
                    highlights.RainbowDelimiterRed = { fg = colors.red }
                    highlights.RainbowDelimiterYellow = { fg = colors.yellow }
                    highlights.RainbowDelimiterBlue = { fg = colors.blue }
                    highlights.RainbowDelimiterOrange = { fg = colors.orange }
                    highlights.RainbowDelimiterGreen = { fg = colors.green }
                    highlights.RainbowDelimiterViolet = { fg = colors.purple }
                    highlights.RainbowDelimiterCyan = { fg = colors.cyan }

                    -- barbar tab colors
                    local barbar_statuses = {
                        Alternate = { bg = colors.bg_dark, fg = colors.fg },
                        Current = { bg = colors.bg_dark1, fg = colors.fg },
                        Inactive = { bg = colors.bg_dark, fg = colors.dark5 },
                        Visible = { bg = colors.bg_dark, fg = colors.fg_dark },
                    }

                    local barbar_parts = {
                        ADDED = colors.git.add,
                        CHANGED = colors.git.change,
                        DELETED = colors.git.delete,
                        ERROR = colors.error,
                        HINT = colors.hint,
                        INFO = colors.info,
                        Index = colors.info,
                        Mod = colors.warning,
                        Target = colors.red,
                        WARN = colors.warning,
                    }

                    for status, base in pairs(barbar_statuses) do
                        local prefix = "Buffer" .. status

                        highlights[prefix] = { bg = base.bg, fg = base.fg }
                        highlights[prefix .. "Sign"] = { bg = base.bg, fg = base.bg }
                        highlights[prefix .. "SignRight"] = { bg = base.bg, fg = base.bg }

                        for part, fg in pairs(barbar_parts) do
                            highlights[prefix .. part] = { bg = base.bg, fg = fg }
                        end
                    end

                    highlights.BufferOffset = { bg = colors.bg_dark1, fg = colors.dark5 }
                    highlights.BufferScrollArrow = { bg = colors.bg_dark1, fg = colors.dark3 }
                    highlights.BufferTabpageFill = { bg = colors.none, fg = colors.none }
                    highlights.BufferTabpages = { bg = colors.bg_dark1, fg = colors.dark5 }
                    highlights.BufferTabpagesSep = { bg = colors.bg_dark1, fg = colors.dark3 }
                end,
            })
        end,
    },
}
