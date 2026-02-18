-- ~/.config/nvim/lua/plugins/lsp.lua
return {
  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim", "nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "rust_analyzer" },
      })
      -- rustaceanvim will take over rust-analyzer setup for Rust buffers,
      -- but keeping mason-lspconfig ensures the server is installed.
    end,
  },
}