-- ~/.config/nvim/lua/plugins/rust.lua
return {
  -- Install LSP servers, formatters, debuggers
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "rust_analyzer" },
        automatic_installation = true,
      })
    end,
  },

  -- Autocomplete
  { "hrsh7th/cmp-nvim-lsp" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },

  -- Treesitter (better syntax + motions)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "rust", "toml", "lua", "markdown" },
      highlight = { enable = true },
    },
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft = { "rust" },
    init = function()
      vim.g.rustaceanvim = {
        tools = {
          inlay_hints = { auto = true },
        },
        server = {
          on_attach = function(_, bufnr)
            local function nmap(lhs, rhs, desc)
              vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
            end
            nmap("gd", vim.lsp.buf.definition, "Go to definition")
            nmap("gr", vim.lsp.buf.references, "References")
            nmap("K", vim.lsp.buf.hover, "Hover")
            nmap("<leader>rn", vim.lsp.buf.rename, "Rename")
            nmap("<leader>ca", vim.lsp.buf.code_action, "Code action")
          end,
          default_settings = {
            ["rust-analyzer"] = {
              cargo = { allFeatures = true },
              checkOnSave = { command = "clippy" },
              procMacro = { enable = true },
              imports = {
                granularity = { group = "module" },
                prefix = "self",
              },
            },
          },
        },
      }
    end,
  },


  -- Nice status updates for LSP
  { "j-hui/fidget.nvim", opts = {} },

  -- Telescope for fuzzy finding (optional but very “Rust project friendly”)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      telescope.setup({})
      vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
      vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
    end,
  },

  -- nvim-cmp config
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
            else fallback() end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then luasnip.jump(-1)
            else fallback() end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
        },
      })
    end,
  },
}