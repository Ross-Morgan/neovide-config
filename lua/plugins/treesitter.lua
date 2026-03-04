return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = false,
        opts = {
            ensure_installed = { "html", "css", "scss", "javascript", "json", "lua", "rust", "python" },
            highlight = { enable = true },
            indent = { enable = true },
        },
    },
}
