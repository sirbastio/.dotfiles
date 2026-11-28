-- gitsigns sizes the hunk popup to its longest line and never wraps it. in a wrapped window
-- (markdown) a paragraph is one line, so the popup ran off screen. there it is capped to the
-- window's text width and wraps like the buffer does. press <leader>gh again to focus and scroll it.
local function fit_hunk_popup(source_win)
    local popup
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.w[win].gitsigns_preview == "hunk" then popup = win end
    end
    if not popup or not vim.wo[source_win].wrap then return end

    local text_width = vim.api.nvim_win_get_width(source_win) - vim.fn.getwininfo(source_win)[1].textoff
    local width = math.min(vim.api.nvim_win_get_width(popup), text_width, vim.o.columns - 4)
    for option, value in pairs({ wrap = true, linebreak = true, breakindent = true, smoothscroll = true }) do
        vim.wo[popup][option] = value
    end

    local function resize()
        if not vim.api.nvim_win_is_valid(popup) then return end
        vim.api.nvim_win_set_width(popup, width)
        local rows = vim.api.nvim_win_text_height(popup, {}).all
        vim.api.nvim_win_set_height(popup, math.max(1, math.min(rows, vim.o.lines - vim.o.cmdheight - 4)))
    end
    resize()
    -- gitsigns puts the popup back to its first size when the buffer scrolls; size it again after
    vim.api.nvim_create_autocmd("WinScrolled", {
        group = vim.api.nvim_create_augroup("gitsigns_popup", { clear = false }),
        buffer = vim.api.nvim_win_get_buf(source_win),
        callback = resize,
    })
end

local function preview_hunk()
    local source_win = vim.api.nvim_get_current_win()
    require("gitsigns").preview_hunk()
    if vim.api.nvim_get_current_win() == source_win then fit_hunk_popup(source_win) end
end

-- the inline preview draws removed lines as virtual lines, which neovim never wraps, so in a wrapped
-- window each one is split into rows here: at spaces like 'linebreak', and under the text after a
-- list marker like 'breakindent'.

-- the chunks covering bytes from+1..to of the text they spell out
local function slice(chunks, from, to)
    local out, pos = {}, 0
    for _, chunk in ipairs(chunks) do
        local first, last = math.max(from, pos), math.min(to, pos + #chunk[1])
        if first < last then out[#out + 1] = { chunk[1]:sub(first - pos + 1, last - pos), chunk[2] } end
        pos = pos + #chunk[1]
    end
    return out
end

local function wrap_virt_line(chunks, buf, textoff, width)
    -- gitsigns' copy of the gutter, then the deleted line padded with spaces in its background
    local gutter, used = {}, 0
    while used < textoff do
        gutter[#gutter + 1] = chunks[#gutter + 1]
        used = used + vim.fn.strdisplaywidth(gutter[#gutter][1])
    end
    local body = vim.list_slice(chunks, #gutter + 1)
    local text = table.concat(vim.tbl_map(function(chunk) return chunk[1] end, body)):gsub("%s+$", "")
    local padding = { (" "):rep(500), chunks[#chunks][2] }
    local marker = text:sub(1, math.max(vim.fn.matchend(text, vim.bo[buf].formatlistpat), #text:match("^%s*")))
    local indent = vim.fn.strdisplaywidth(marker)

    -- where each row ends: a word goes on the next row when it doesn't fit, trailing spaces aside
    local ends, row_width, pos = {}, 0, 1
    while pos <= #text do
        local word_end = select(2, text:find("^%s*%S*%s*", pos))
        local room = width - (#ends > 0 and indent or 0)
        if row_width > 0 and row_width + vim.fn.strdisplaywidth((text:sub(pos, word_end):gsub("%s+$", ""))) > room then
            ends[#ends + 1], row_width = pos - 1, 0
        end
        row_width, pos = row_width + vim.fn.strdisplaywidth(text:sub(pos, word_end)), word_end + 1
    end
    ends[#ends + 1] = #text

    -- later rows: the gutter blanked out, then the indent
    local indented = vim.tbl_map(function(chunk) return { (" "):rep(vim.fn.strdisplaywidth(chunk[1])), chunk[2] } end, gutter)
    indented[#indented + 1] = { (" "):rep(indent), padding[2] }
    local rows = {}
    for i, row_end in ipairs(ends) do
        local row = vim.deepcopy(i == 1 and gutter or indented)
        vim.list_extend(row, slice(body, i == 1 and 0 or ends[i - 1], row_end))
        rows[i] = vim.list_extend(row, { padding })
    end
    return rows
end

local function wrap_inline_preview(win)
    local ns = vim.api.nvim_get_namespaces().gitsigns_preview_inline
    if not ns or not vim.api.nvim_win_is_valid(win) or not vim.wo[win].wrap then return end
    local buf = vim.api.nvim_win_get_buf(win)
    local info = vim.fn.getwininfo(win)[1]
    local width = info.width - info.textoff
    for _, mark in ipairs(vim.api.nvim_buf_get_extmarks(buf, ns, 0, -1, { details = true })) do
        local details = mark[4]
        if details.virt_lines then
            local rows = {}
            for _, chunks in ipairs(details.virt_lines) do
                vim.list_extend(rows, wrap_virt_line(chunks, buf, info.textoff, width))
            end
            vim.api.nvim_buf_set_extmark(buf, ns, mark[2], mark[3], {
                id = mark[1],
                priority = details.priority,
                virt_lines = rows,
                virt_lines_above = details.virt_lines_above,
                virt_lines_leftcol = details.virt_lines_leftcol,
            })
        end
    end
end

local function preview_hunk_inline()
    local win = vim.api.nvim_get_current_win()
    require("gitsigns").preview_hunk_inline(vim.schedule_wrap(function() wrap_inline_preview(win) end))
end

return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            attach_to_untracked = true,
            signs = {
                add = { text = " ┃" },
                change = { text = " ┃" },
                delete = { text = " ▁" },
                topdelete = { text = " ▔" },
                changedelete = { text = " ┃" },
                untracked = { text = " ┆" },
            },
        },
        keys = {
            { "<leader>gh", ":Gitsigns preview_hunk<CR>", desc = "[g]it [h]unk preview" },
            { "<leader>gH", ":Gitsigns preview_hunk_inline<CR>", desc = "[G]it [H]unk preview inline" },
            { "<leader>gd", ":Gitsigns diffthis<CR>", desc = "[g]it [d]iff" },
            { "<leader>gn", ":Gitsigns nav_hunk next<CR>", desc = "[g]it [n]ext hunk" },
            { "<leader>gp", ":Gitsigns nav_hunk prev<CR>", desc = "[g]it [p]revious hunk" },
            { "<leader>gr", ":Gitsigns reset_hunk<CR>", desc = "[g]it [r]eset hunk" },
        },
    },
    {
        "NeogitOrg/neogit",
        lazy = true,
        cmd = "Neogit",
        dependencies = {
            "folke/snacks.nvim",
            { "m00qek/baleia.nvim", config = function() vim.g.baleia = require("baleia").setup({}) end },
        },
        opts = {
            log_pager = {"sh", "-c", [[delta --file-style omit --hunk-header-style omit | tail -n +2 | perl -pe 's/\e\[0K/" " x 400/ge']],},
            commit_editor = { staged_diff_split_kind = "vsplit" },
            graph_style = "unicode",
            process_spinner = true,
            treesitter_diff_highlight = true,
        },
        keys = { { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" } },
        init = function()
            -- clean up hunk headers
            vim.api.nvim_create_autocmd("BufWinEnter", {
                callback = function(args)
                    local diff_views = { "NeogitStatus", "NeogitCommitView", "NeogitDiffView" }
                    if not vim.tbl_contains(diff_views, vim.bo[args.buf].filetype) or vim.w.neogit_hunk_conceal then
                        return
                    end
                    vim.wo.conceallevel = 3
                    vim.wo.concealcursor = "nvic"
                    vim.w.neogit_hunk_conceal = vim.fn.matchadd("Conceal", [[^@@ [^@]* @@ \?]], 10, -1, { conceal = "" })
                end,
            })
        end,
    },
}
