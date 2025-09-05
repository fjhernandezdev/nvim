return {
  -- Snippets engine + colección de snippets
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp", -- opcional, mejora regex de snippets
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local ls = require("luasnip")
      -- Carga snippets estilo VSCode (friendly-snippets)
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Opcional: mantener historial y actualizar en InsertEnter
      ls.config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = false,
      })
    end,
  },

  -- Autocompletado
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",     -- fuente LSP
      "hrsh7th/cmp-buffer",       -- fuente buffer
      "hrsh7th/cmp-path",         -- rutas de archivos
      "hrsh7th/cmp-cmdline",      -- línea de comandos
      "saadparwaiz1/cmp_luasnip", -- fuente snippets (LuaSnip)
      "PaterJason/cmp-conjure"
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        completion = {
          completeopt = "menu,menuone,noselect",
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          -- Navegar ítems
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),

          -- Confirmar selección
          ["<CR>"] = cmp.mapping.confirm({ select = false }),

          -- Desplegar menú manualmente
          ["<C-Space>"] = cmp.mapping.complete(),

          -- Documentación
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),

          -- Expandir/avanzar snippet
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),

          -- Retroceder en snippet
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip"  },
          { name = "conjure"  },
          { name = "path"     },
          { name = "buffer"   },
        }),
        -- Opcional: formato mínimo de menú
        formatting = {
          fields = { "abbr", "menu" },
          format = function(entry, vim_item)
            local menus = {
              nvim_lsp = "[LSP]",
              buffer   = "[Buf]",
              path     = "[Path]",
              luasnip  = "[Snip]",
            }
            vim_item.menu = menus[entry.source.name] or ("[" .. entry.source.name .. "]")
            return vim_item
          end,
        },
        experimental = {
          ghost_text = false, -- ponlo en true si te gusta el "preview" inline (Neovim 0.10+)
        },
      })

      -- Config para búsqueda en / y ? (usa buffer)
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- Config para :
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
        matching = { disallow_symbol_nonprefix_matching = false },
      })
    end,
  },
}

