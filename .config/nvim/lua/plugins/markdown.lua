-- a rule under h1 (thick) and h2 (thin), as GitHub draws it. it is drawn over the blank line that
-- follows the heading, so a heading with text directly under it gets none. the plugin's own heading
-- border only comes with a background bar behind the heading
local rule_chars = { atx_h1_marker = "━", atx_h2_marker = "─" }

local function heading_rules(ctx)
    local query = vim.treesitter.query.parse("markdown", "[(atx_h1_marker) (atx_h2_marker)] @marker")

    local marks = {}
    for _, node in query:iter_captures(ctx.root, ctx.buf) do
        local below = node:start() + 1
        if vim.api.nvim_buf_get_lines(ctx.buf, below, below + 1, false)[1] == "" then
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

return {
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
}
