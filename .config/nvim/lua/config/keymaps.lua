local set = vim.keymap.set
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- === LEADER KEY ===  --
vim.g.mapleader = " "

-- === KEEP CURSOR CENTERED === --
set("n", "J", "mzJ`z", { desc = "[J]oin lines (keep cursor position)" })
set("n", "<C-d>", "<C-d>zz", { desc = "Scroll [d]own (centered)" })
set("n", "<C-u>", "<C-u>zz", { desc = "Scroll [u]p (centered)" })
set("n", "n", "nzzzv", { desc = "[n]ext search result (centered)" })
set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

-- === MOVE LINES === --
set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })
set("x", "<Tab>", ">gv", { desc = "Indent selected lines" })
set("x", "<S-Tab>", "<gv", { desc = "Outdent selected lines" })

-- === OTHER === --
set("n", "<leader>c", ":nohlsearch<CR>", { desc = "[c]lear search highlights" })

-- === FILE EXPLORER === --
set("n", "<leader>e", function() require("mini.files").open() end, { desc = "[e]xplorer" })

-- === CODE FORMATTER === --
set({ "n", "v" }, "<leader>f", function()
    require("conform").format({ async = true })
end, { desc = "[f]ormat" })

-- === COPY & PASTE === --
set("x", "<leader>p", '"_dP', { desc = "[p]aste without yanking" })
set({ "n", "v" }, "<leader>d", '"_d', { desc = "[d]elete without yanking" })

autocmd("TextYankPost", {
    group = augroup("HighlightYank", { clear = true }),
    desc = "Highlight yanked text",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 50 })
    end,
})

-- === LSP === --
autocmd("LspAttach", {
    group = augroup("LspKeymaps", { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc, mode)
            mode = mode or "n"
            set(mode, keys, func, { buffer = event.buf, desc = desc })
        end

        map("gd", vim.lsp.buf.definition, "Go to definition")
        map("gD", vim.lsp.buf.declaration, "Go to declaration")
        map("gr", vim.lsp.buf.references, "Go to references")
        map("gi", vim.lsp.buf.implementation, "Go to implementation")

        map("K", vim.lsp.buf.hover, "Hover documentation")
        map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")

        map("<leader>x", vim.diagnostic.open_float, "Open diagnostics float")
        map("<leader>ca", vim.lsp.buf.code_action, "Code action")
    end
})

-- === GIT === --
set("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "Lazygit" })
set("n", "<leader>gl", function() Snacks.lazygit.log() end, { desc = "Lazygit Logs" })

local function in_git_worktree()
    vim.fn.system({ "git", "rev-parse", "--is-inside-work-tree" })
    return vim.v.shell_error == 0
end

-- === PICKER === --
local function set_default_project_picker_keymaps()
    set("n", "<D-p>", function() Snacks.picker.smart() end, { desc = "pick [p]roject files" })
    set("n", "<leader>pw", function() Snacks.picker.grep() end, { desc = "[p]ick [w]ords" })
    set({ "n", "x" }, "<leader>pW", function() Snacks.picker.grep_word() end, { desc = "[p]ick [W]ord" })
end

set("n", "<leader>pf", function() Snacks.picker.files() end, { desc = "[p]ick [f]iles (all)" })
set("n", "<leader>pr", function() Snacks.picker.recent() end, { desc = "[p]ick [r]ecent" })
set("n", "<D-P>", function() Snacks.picker.resume() end, { desc = "[P]icker resume" })
set("n", "<leader>ps", function() Snacks.picker.lsp_symbols() end, { desc = "[p]ick [s]ymbols (document)" })
set("n", "<leader>pS", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "[p]ick [S]ymbols (workspace)" })
set("n", "<leader>pb", function() Snacks.picker.buffers() end, { desc = "[p]ick [b]uffers" })
set("n", "<leader>pd", function() Snacks.picker.diagnostics() end, { desc = "[p]ick [d]iagnostics (project)" })
set("n", "<leader>ph", function() Snacks.picker.help() end, { desc = "[p]ick [h]elp" })
set("n", "<leader>pp", function() Snacks.picker() end, { desc = "[p]ick [p]icker" })

local function set_git_project_picker_keymaps()
    set("n",
        "<D-p>",
        function()
            Snacks.picker.smart({
                multi = { "buffers", "recent", { source = "git_files", untracked = true } },
            })
        end,
        { desc = "pick [p]roject files" })

    set("n",
        "<leader>pw",
        function()
            Snacks.picker.git_grep({ untracked = true })
        end,
        { desc = "[p]ick [w]ords" })


    set({ "n", "x" },
        "<leader>pW",
        function()
            Snacks.picker.git_grep({
                untracked = true,
                cmd_args = { "--fixed-strings", "--word-regexp" },
                search = function(picker) return picker:word() end,
                live = false,
            })
        end,
        { desc = "[p]ick [W]ord" })
end

autocmd({ "VimEnter", "DirChanged" }, {
    group = augroup("ProjectPickerKeymaps", { clear = true }),
    callback = function()
        if in_git_worktree() then
            set_git_project_picker_keymaps()
        else
            set_default_project_picker_keymaps()
        end
    end,
})
