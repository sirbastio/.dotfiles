local opt = vim.opt_local

opt.wrap = true
opt.linebreak = true
opt.breakindent = true
opt.breakindentopt = "list:-1"
opt.cursorline = false
opt.smoothscroll = true -- scroll wrapped paragraphs a row at a time

-- the width of the match is the wrap indent. task items stop at the box, since the rendered
opt.formatlistpat = table.concat({
    [[^\s*\%(>\s\=\)*\s*[-*+]\s\[\ze.\]\s]], -- task items
    [[^\s*\%(>\s\=\)*\s*\%([-*+]\|\d\+[.)]\)\s\+]], -- bullets and numbers, also inside quotes
    [[^\s*\%(>\s\=\)\+]], -- block quotes
}, [[\|]])

-- a quiet gutter: only the sign column, so git signs still show
opt.number = false
opt.relativenumber = false
opt.foldcolumn = "0"
opt.statuscolumn = "%{%v:lua.require'config.utils'.prose_statuscolumn()%}"
opt.fillchars:append({ vert = " " }) -- no divider beside the centring plugin's padding window

opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2

vim.b.snacks_indent = false -- indent guides would draw through nested lists and code blocks

-- move by screen line through wrapped paragraphs
vim.keymap.set({ "n", "x" }, "j", "gj", { buffer = true })
vim.keymap.set({ "n", "x" }, "k", "gk", { buffer = true })
