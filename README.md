# nvim

Neovim configuration (with **lazy.nvim**) focused on Clojure development:
- **LSP** (clojure-lsp, lua-language-server)
- **Autocompletion** (nvim-cmp + LuaSnip + cmp-conjure)
- **REPL/Eval** (Conjure)
- **Treesitter** (Clojure; EDN highlighting via clojure parser mapping)
- **Git integration** (gitsigns; optional diffview/fugitive)
- **File tree + icons** (nvim-tree + devicons)

> Tested on **Neovim 0.11.x**. Use a **Nerd Font** (e.g., *FiraCode Nerd Font*) in your terminal for icons.

---

## 🔧 Prerequisites (macOS)

Install recommended CLI tools:
```bash
brew install git ripgrep fd fzf
brew install lua-language-server
brew install clj-kondo
brew install clojure-lsp/brew/clojure-lsp
brew install --cask font-fira-code-nerd-font
```

Terminal font:
- iTerm2 → Preferences → Profiles → Text → set FiraCode Nerd Font.
- If “Use a different font for non-ASCII text” is enabled, set the same Nerd Font there as well (or disable it).
- Ensure truecolor is enabled in your Neovim config (termguicolors).

🚀 Installation
Clone this repo into your Neovim config directory:
```bash
git clone https://github.com/<YOUR_USERNAME>/nvim ~/.config/nvim
nvim +Lazy! sync
```

Install Treesitter parser for Clojure:
```bash
:TSInstall clojure
```

🗂️ Modular Structure
```arduino
├── init.lua
├── lazy-lock.json
├── lua
│   ├── config
│   │   ├── lazy.lua
│   │   └── lsp.lua
│   ├── core
│   │   ├── keymaps.lua
│   │   └── options.lua
│   ├── lsp
│   │   ├── clojure.lua
│   │   └── lua.lua
│   └── plugins
│       ├── clojure.lua
│       ├── comment.lua
│       ├── devicons.lua
│       ├── git.lua
│       ├── mini.lua
│       ├── nvim-cmp.lua
│       ├── telescope.lua
│       ├── tokionight.lua
│       ├── tree.lua
│       └── vimtmuxnavigator.lua
└── README.md
```

