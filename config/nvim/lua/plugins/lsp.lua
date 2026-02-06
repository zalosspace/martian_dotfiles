return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "clangd",
          "pyright",
          "tsserver",
          "rust_analyzer",
        },
      })

      -- Keymaps when LSP attaches
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(e)
          local opts = { buffer = e.buf }

          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        end,
      })

      vim.lsp.enable({
        "lua_ls",
        "clangd",
        "pyright",
        "tsserver",
        "rust_analyzer",
      })
    end,
  },
}
