return {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "1.*",
    opts = {
        keymap = { preset = "default" },
        appearance = { nerd_font_variant = "mono" },
        completion = { documentation = { auto_show = true } },
        signature = { enabled = true, window = { border = "rounded" } },
        sources = { default = { "lsp", "path", "snippets", "buffer" } },
        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    -- If blink.cmp is extended by another plugin, merge/append
    -- sources.default instead of replacing the whole list.
    opts_extend = { "sources.default" },
}
