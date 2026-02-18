return {
  {
    "stevearc/conform.nvim",
    opts = {
      -- Map filetypes to formatters
      formatters_by_ft = {
        rust = { "rustfmt" },
        toml = { "taplo" }, -- optional
      },

      -- Format on save (with sensible timeout)
      format_on_save = function(bufnr)
        return {
          timeout_ms = 2000,
          lsp_fallback = true, -- if no formatter configured, try LSP
        }
      end,
    },
    config = function(_, opts)
      require("conform").setup(opts)

      -- Optional: manual format keybind as well
      vim.keymap.set("n", "<leader>f", function()
        require("conform").format({ async = true, lsp_fallback = true })
      end, { desc = "Format file" })
    end,
  },
}