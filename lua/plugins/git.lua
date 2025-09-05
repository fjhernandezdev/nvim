return {
  -- 1) Gitsigns: integración principal
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "▎" },
        topdelete    = { text = "▔" },
        changedelete = { text = "▎" },
        untracked    = { text = "▎" },
      },
      signcolumn = true,
      numhl = false,
      current_line_blame = true, -- muestra blame en la línea actual
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- eol | overlay | right_align
        delay = 300,
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- Navegación entre hunks
        map("n", "]h", function() gs.next_hunk() end, "Next hunk")
        map("n", "[h", function() gs.prev_hunk() end, "Prev hunk")

        -- Acciones sobre hunks
        map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", "Stage hunk")
        map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", "Reset hunk")
        map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
        map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")
        map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")
        map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
        map("n", "<leader>hd", gs.diffthis, "Diff this")
        map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff against HEAD")

        -- Textobject: ah/ih para seleccionar hunk
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Inner hunk")
        map({ "o", "x" }, "ah", ":<C-U>Gitsigns select_hunk<CR>", "A hunk")
      end,
    },
  },

  -- 2) Diffview: UI para diffs, history, revisar commits
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles",
      "DiffviewFocusFiles", "DiffviewFileHistory",
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      enhanced_diff_hl = true,
      view = { merge_tool = { layout = "diff3_mixed" } },
    },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<CR>",          desc = "Diff (current branch)" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "File history (current file)" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<CR>",   desc = "Repo history" },
    },
  },

  -- 3) Fugitive (opcional): comandos Git estilo Vim
  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git", "Gdiffsplit", "Gedit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete" },
    keys = {
      { "<leader>gg", "<cmd>Git<CR>",        desc = "Fugitive status" },
      { "<leader>gc", "<cmd>Git commit<CR>", desc = "Commit" },
      { "<leader>gp", "<cmd>Git push<CR>",   desc = "Push" },
      { "<leader>gl", "<cmd>Gclog<CR>",      desc = "Git log (buffer)" },
    },
  },
}
