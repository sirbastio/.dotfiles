return {
    {
        "projekt0n/github-nvim-theme",
        name = "github-theme",
        lazy = false,
        priority = 1000,
        config = function()
            local spell_underline = { sp = "bg4", style = "underdotted" }

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

            local function snacks_notifier_groups()
                local bg = "bg0"
                local fg = "fg1"
                local levels = {
                    Trace = "fg2",
                    Debug = "fg2",
                    Info = "palette.accent.fg",
                    Warn = "palette.attention.fg",
                    Error = "palette.danger.fg",
                }
                local groups = {
                    SnacksNotifierHistory = { bg = bg, fg = fg },
                    SnacksNotifierMinimal = { bg = bg, fg = fg },
                }

                for level, level_fg in pairs(levels) do
                    groups["SnacksNotifier" .. level] = { bg = bg, fg = fg }
                    groups["SnacksNotifierIcon" .. level] = { bg = bg, fg = level_fg }
                    groups["SnacksNotifierBorder" .. level] = { bg = bg, fg = level_fg }
                    groups["SnacksNotifierTitle" .. level] = { bg = bg, fg = level_fg }
                    groups["SnacksNotifierFooter" .. level] = { bg = bg, fg = level_fg }
                end

                return groups
            end

            local function noice_groups()
                return {
                    NoiceCmdlinePopup = { bg = "bg0", fg = "fg1" },
                    NoiceCmdlinePopupBorder = { bg = "bg0", fg = "palette.border.default" },
                    NoiceCmdlinePopupBorderCmdline = { bg = "bg0", fg = "palette.border.default" },
                    NoiceCmdlinePopupTitle = { bg = "bg0", fg = "fg1" },
                    NoiceCmdlinePopupTitleCmdline = { bg = "bg0", fg = "fg1" },
                }
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
                        DiagnosticUnderlineInfo = spell_underline,
                        SpellBad = spell_underline,
                        SpellCap = spell_underline,
                        SpellLocal = spell_underline,
                        SpellRare = spell_underline,
                        SnacksNormal = { bg = "NONE" },
                        SnacksTitle = { bg = "bg0" },
                        SnacksPickerPreviewTitle = { bg = "bg0" },
                        SnacksLazygitInactiveBorder = { fg = "palette.neutral.muted" },
                        SnacksIndent = { fg = "palette.border.subtle" },
                        SnacksIndentScope = { fg = "palette.neutral.muted" },
                        SnacksIndentChunk = { fg = "palette.neutral.muted" },
                        RainbowDelimiterRed = { fg = "palette.red.bright" },
                        RainbowDelimiterYellow = { fg = "palette.yellow.bright" },
                        RainbowDelimiterBlue = { fg = "palette.blue.bright" },
                        RainbowDelimiterOrange = { fg = "palette.orange.bright" },
                        RainbowDelimiterGreen = { fg = "palette.green.bright" },
                        RainbowDelimiterPink = { fg = "palette.pink.bright" },
                        RainbowDelimiterPurple = { fg = "palette.magenta.bright" },
                        RainbowDelimiterViolet = { fg = "palette.done.fg" },
                        RainbowDelimiterCyan = { fg = "palette.cyan.base" },
                    }, barbar_groups(), snacks_notifier_groups(), noice_groups()),
                },
            })
            vim.cmd.colorscheme("github_dark_default")
        end,
    },
}
