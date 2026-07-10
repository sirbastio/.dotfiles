# Neovim

This is currently a work in progress project. 

TODO:
- Refactor code
- Refactor theme into plugin specs
- Integrate AI

## Plugins ([Lazy](https://github.com/folke/lazy.nvim))

### Coding

- **LSP Configs:** [lspconfig](https://github.com/neovim/nvim-lspconfig)
- **Formatting:** [Conform](https://github.com/stevearc/conform.nvim)
- **Completions:** [Blink](https://github.com/saghen/blink.cmp)
    - **Snippets:** [LuaSnip](https://github.com/L3MON4D3/LuaSnip), [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
- **Linting:** [lint](https://github.com/mfussenegger/nvim-lint)
- **Syntax Parser & Highlights:** [treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
    - **Context:** [treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context)
    - **Folds:** [ufo](https://github.com/kevinhwang91/nvim-ufo)
- **Package Manager:** [Mason](https://github.com/mason-org/mason.nvim), [Mason-lspconfig](https://github.com/mason-org/mason-lspconfig.nvim)
- **Auto Delimiters:** [mini.pairs](https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-pairs.md) ~~[autopairs](https://github.com/windwp/nvim-autopairs)~~
- **Surround:** [mini.surround](https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-surround.md) ~~[vim-surround](https://github.com/tpope/vim-surround)~~
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
