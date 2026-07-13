# Neovim

> The vision was to create minimal, lean and maintainable, but feature-rich text editor

## Build-In Features

### Smart Keymaps 

- Keymaps stay true to the original vim experience with QOL improvements
- `<leader>` set to space
- Yank (copy) and pasting can be prefixed with `<leader>` to not copy text
- QOL keymaps such as keeping the cursor centered when moving
- `jk` while in insert mode to exit
- Move selection/s in visual modes with `J` and `K`
- Indent and outdent in visual modes with `<Tab>` and `<S-Tab>`
- More found in `lua/config/keymaps.lua`
- Plugin keymaps are all found within the corresponding implementations found in `lua/plugins`

### Sane Options

- Use system clipboard for yanking and pasting
- Blinking cursor, especially useful over ssh connections to see if connection is stable
- Use of an undofile so undos and redos persist
- Swap file and backup files are off
- Include hyphen (-) separated words as full words e.g. neovim, neo_vim, and neo-vim are all one word
- More found in `lua/config/options.lua`

### Preview Buffers/Tabs

- Allows auto-management of files that are not edited so the tabs/buffers stay clean and there isn't an excessive amount open
- Similar to VS Codes preview tabs.
- When a file is opened it is marked as the "preview buffer/tab"
- If another file is opened then the existing preview tab is replaced by the new file
- The opened file now the preview tab
- If a preview tab/buffer has its file edited or saved, it is no longer marked as the preview tab and will persist
- A file can be opened the written with `<leader>` to persist it without modifying, this has no effect since it would have no been modified
- The code for this functionality is found in `lua/plugins/buffers.lua`

### File View-States

- Automatically loads and remembers file-view states
- This includes cursor position and folded sections
- Does not do this for diff views

## Plugins ([Lazy](https://github.com/folke/lazy.nvim))

For specific implementations and keymaps of the plugins see their implementations in `lua/plugins`

### Coding

- **LSP Configs:** [lspconfig](https://github.com/neovim/nvim-lspconfig)
- **Package Manager:** [Mason](https://github.com/mason-org/mason.nvim), [Mason-lspconfig](https://github.com/mason-org/mason-lspconfig.nvim), [mason-tool-installer](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim)
- **Formatting:** [Conform](https://github.com/stevearc/conform.nvim)
- **Completions:** [Blink](https://github.com/saghen/blink.cmp)
    - **Snippets:** [LuaSnip](https://github.com/L3MON4D3/LuaSnip), [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
- **AI Inline Suggestions:** [Copilot](https://github.com/zbirenbaum/copilot.lua)
- **Linting:** [lint](https://github.com/mfussenegger/nvim-lint)
- **Syntax Parser & Highlights:** [treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
    - **Context:** [treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context)
    - **Folds:** [ufo](https://github.com/kevinhwang91/nvim-ufo)
- **Auto Delimiters:** [mini.pairs](https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-pairs.md) ~~[autopairs](https://github.com/windwp/nvim-autopairs)~~
- **Surround:** [mini.surround](https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-surround.md) ~~[vim-surround](https://github.com/tpope/vim-surround)~~
- **Argument Splits/Joins:** [mini.splitjoin](https://github.com/nvim-mini/mini.splitjoin)
- **Auto-Tags:** [ts-autotag](https://github.com/windwp/nvim-ts-autotag)

### Editor

- **Dashboard:** [Snacks.dashboard](https://github.com/folke/snacks.nvim/blob/main/docs/dashboard.md)
- **Theme:** [GitHub](https://github.com/projekt0n/github-nvim-theme)
- **Status Line:** [lualine](https://github.com/nvim-lualine/lualine.nvim) ~~[mini.statusline](https://github.com/nvim-mini/mini.statusline)~~
- **Notifications**: [Snacks.notifier](https://github.com/folke/snacks.nvim/blob/main/docs/notifier.md) ~~[mini.notify](https://github.com/nvim-mini/mini.notify)~~ ~~[Fidget](https://github.com/j-hui/fidget.nvim)~~
- **Command Line**: [Noice](https://github.com/folke/noice.nvim)
- **Diagnostics:** [trouble](https://github.com/folke/trouble.nvim)
- **Terminal:** [snacks.terminal](https://github.com/folke/snacks.nvim/blob/main/docs/terminal.md)
- **Tabs**: [barbar](https://github.com/romgrk/barbar.nvim) ~~[bufferline](https://github.com/akinsho/bufferline.nvim)~~
- **Icons:** [web-devicons](https://github.com/nvim-tree/nvim-web-devicons) ~~[mini.icons](https://github.com/nvim-mini/mini.icons)~~
- **Delimiter Highlights:** [rainbow-delimiters](https://github.com/hiphish/rainbow-delimiters.nvim)
- **Indent Guides:** [Snacks.indent](https://github.com/folke/snacks.nvim/blob/main/docs/indent.md) ~~[mini.indentscope](https://github.com/nvim-mini/mini.indentscope)~~ 
- **Cursor Word Highlighting:** [Snacks.words](https://github.com/folke/snacks.nvim/blob/main/docs/words.md) ~~[mini.cursorword](https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-cursorword.md)~~ ~~[illuminate](https://github.com/rrethy/vim-illuminate)~~
- **Scrollbar:** [scrollbar](https://github.com/petertriho/nvim-scrollbar)
- **TODO Comments:** [todo-comments](https://github.com/folke/todo-comments.nvim)

### Navigation
- **Picker:** [Snacks.picker](https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#-sources) ~~[fff](https://github.com/dmtrKovalenko/fff)~~ ~~[mini.pick](https://github.com/nvim-mini/mini.pick)~~ ~~[Telescope](https://github.com/nvim-telescope/telescope.nvim)~~
- **Explorer:** [mini.files](https://github.com/nvim-mini/mini.files), [oil.nvim](https://github.com/stevearc/oil.nvim) ~~[Neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim)~~

### Git
- **Diffs:** [gitsigns](https://github.com/lewis6991/gitsigns.nvim) ~~[mini.diff](https://github.com/nvim-mini/mini.diff)~~
- **Gui:** [Neogit](https://github.com/neogitorg/neogit) [Snacks.Lazygit](https://github.com/folke/snacks.nvim/blob/main/docs/lazygit.md)

### Other

- [undotree](https://github.com/mbbill/undotree)
- [snacks.quickfile](https://github.com/folke/snacks.nvim/blob/main/docs/quickfile.md)
- [snacks.input](https://github.com/folke/snacks.nvim/blob/main/docs/input.md): better `vim.ui.input`
- [which-key](https://github.com/folke/which-key.nvim)
