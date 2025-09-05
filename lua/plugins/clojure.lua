return {
  -- LSP base
  { "neovim/nvim-lspconfig" },

  -- Conjure: REPL / Eval interactivo para Clojure
  {
    "Olical/conjure",
    ft = { "clojure", "fennel", "janet", "racket" },
    init = function()
      -- Opciones útiles de Conjure
      vim.g["conjure#mapping#doc_word"] = "K"              -- K para docs del símbolo
      vim.g["conjure#log#hud#enabled"] = false             -- usa split en vez de HUD flotante
      vim.g["conjure#log#botright"] = true
      vim.g["conjure#extract#context_header_lines"] = 999  -- mejor detección de ns
    end,
  },

  -- Fuente de completado para Conjure
  { "PaterJason/cmp-conjure", dependencies = { "hrsh7th/nvim-cmp", "Olical/conjure" } },

  -- Treesitter para Clojure / EDN
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "clojure", "query", "bash", "lua", "vim", "vimdoc" },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      vim.treesitter.language.register("clojure", "edn")
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- Paredit (manipulación estructural de s-exprs)
  {
    "julienvincent/nvim-paredit",
    ft = { "clojure", "fennel", "scheme", "lisp" },
    opts = { use_default_keys = true },
  },

  -- Opcional: jack-in (lanzar REPL con Lein/CLI/Shadow)
  {
    "clojure-vim/vim-jack-in",
    ft = { "clojure" },
    dependencies = { "radenling/vim-dispatch-neovim" }, -- para :Dispatch en Neovim
  },
}

