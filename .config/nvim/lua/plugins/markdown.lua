-- a rule under h1 (thick) and h2 (thin), as GitHub draws it. it is drawn over the blank line that
-- follows the heading, so a heading with text directly under it gets none. the plugin's own heading
-- border only comes with a background bar behind the heading
local rule_chars = { atx_h1_marker = "━", atx_h2_marker = "─" }

local function heading_rules(ctx)
    local query = vim.treesitter.query.parse("markdown", "[(atx_h1_marker) (atx_h2_marker)] @marker")

    local marks = {}
    for _, node in query:iter_captures(ctx.root, ctx.buf) do
        local below = node:start() + 1
        local lines = vim.api.nvim_buf_get_lines(ctx.buf, below, below + 2, false)
        -- a table right after the blank line draws its top border there, and the rule would run on
        -- past the table's corner
        local table_follows = (lines[2] or ""):match("^%s*|") ~= nil
        if lines[1] == "" and not table_follows then
            marks[#marks + 1] = {
                conceal = true, -- the cursor line shows the real blank line
                start_row = below,
                start_col = 0,
                -- overlays are cut at the window edge, so this spans any window
                opts = {
                    virt_text = { { rule_chars[node:type()]:rep(vim.o.columns), "RenderMarkdownHeadingRule" } },
                    virt_text_pos = "overlay",
                },
            }
        end
    end
    return marks
end

-- a rule between the body rows of a table, as GitHub draws it. the plugin has no option for it, so
-- its table renderer is wrapped: every body row but the last gets a ├───┼───┤ line under it. a row
-- too wide for the window is replaced by wrapped lines, and its rule goes at the end of those
local function add_row_rules()
    local Render = require("render-markdown.render.markdown.table")

    local function rule(self, row)
        local rows = self.data.rows
        local is_header = row.node.type == "pipe_table_header"
        if is_header or row == rows[#rows] or not self.data.layout.valid then
            return nil
        end
        local border = self.config.border
        local parts = vim.tbl_map(function(col) return border[11]:rep(col.width) end, self.data.cols)
        return border[4] .. table.concat(parts, border[5]) .. border[6]
    end

    local row = Render.row
    function Render:row(item)
        row(self, item)
        local text = rule(self, item)
        if text then
            local line = self:line():pad(self.data.layout.col):text(text, self.config.row)
            self.marks:add(self.config, "virtual_lines", item.node.start_row, 0, {
                virt_lines = { self:indent():line(true):extend(line):get() },
            })
        end
    end

    local wrapped_row = Render.wrapped_row
    function Render:wrapped_row(item)
        local lines = wrapped_row(self, item)
        local text = rule(self, item)
        if text then
            lines[#lines + 1] = self:line():extend(self.data.prefixes[item.node.start_row]):text(text, self.config.row):get()
        end
        return lines
    end
end

return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown" },
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
        opts = {
            -- rendered in every mode: switching to raw markdown on insert shifted the whole document
            render_modes = true,
            sign = { enabled = false },
            -- hierarchy comes from color and weight alone: the '#'s are hidden and nothing replaces them
            heading = { icons = { "" }, position = "inline", backgrounds = {} },
            -- full-width blocks with a label on the top row
            code = {
                left_pad = 2,
                language_pad = 1,
                border = "thick",
                language_name = false, -- the icon alone
                highlight_language = "RenderMarkdownCodeInfo",
            },
            link = { enabled = false }, -- no icons in front of links
            bullet = { icons = { "•" } }, -- the same dot at every nesting level
            -- the bar repeats on wrapped lines; the ftplugin's breakindent leaves room for it
            quote = { icon = "▎", repeat_linebreak = true },
            custom_handlers = { markdown = { extends = true, parse = heading_rules } },
        },
        config = function(_, opts)
            require("render-markdown").setup(opts)
            add_row_rules()

            -- the plugin re-renders on a resize, but that render can be dropped when another update
            -- lands in the same moment, as when the centring opens its padding, leaving tables laid
            -- out for the old width. render again once things settle
            vim.api.nvim_create_autocmd("WinResized", {
                group = vim.api.nvim_create_augroup("RenderMarkdownAfterResize", { clear = true }),
                callback = function()
                    for _, win in ipairs(vim.v.event.windows or {}) do
                        local buf = vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_buf(win)
                        if buf and vim.bo[buf].filetype == "markdown" then
                            vim.defer_fn(function()
                                if vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_buf(win) == buf then
                                    require("render-markdown").render({ buf = buf, win = win })
                                end
                            end, 200)
                        end
                    end
                end,
            })
        end,
    },
    -- a live preview in the browser, drawn with GitHub's own styles. needs Bun (in the Brewfile)
    {
        "wallpants/github-preview.nvim",
        cmd = { "GithubPreviewToggle", "GithubPreviewStart", "GithubPreviewStop" },
        opts = {},
    },
}
