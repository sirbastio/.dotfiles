-- centres markdown in a narrow column by padding the window with an empty one on each side
local enabled = false

-- splits are left to the plugin, which makes room for them by itself
local function has_split()
    local windows = 0
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        local is_padding = vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "no-neck-pain"
        if not is_padding and vim.api.nvim_win_get_config(win).relative == "" then
            windows = windows + 1
        end
    end
    return windows > 1
end

-- on for markdown, off again for any other file or the dashboard. special buffers (pickers,
-- prompts, the padding windows themselves) change nothing
local function sync()
    local filetype, buftype = vim.bo.filetype, vim.bo.buftype
    local is_markdown = filetype == "markdown" and buftype == ""

    if has_split() then
        return
    elseif is_markdown and not enabled then
        require("no-neck-pain").enable()
    elseif enabled and not is_markdown and (buftype == "" or filetype == "snacks_dashboard") then
        require("no-neck-pain").disable()
    end
end

return {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    lazy = true,
    opts = {
        width = 92, -- about 90 columns of text beside the markdown sign column
        -- no divider between the left padding and the text; the markdown ftplugin hides the right one
        buffers = { wo = { fillchars = "vert: ,eob: " } },
        callbacks = {
            postEnable = function() enabled = true end,
            postDisable = function() enabled = false end,
        },
    },
    init = function()
        vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
            group = vim.api.nvim_create_augroup("MarkdownCentering", { clear = true }),
            desc = "Centre markdown in a narrow column",
            -- a moment later: windows can't be split while a buffer is still being entered, and the
            -- plugin must finish reacting to a closed split before it can be turned off
            callback = function()
                vim.defer_fn(sync, 50)
            end,
        })
    end,
}
