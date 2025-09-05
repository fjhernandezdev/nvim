-- ======================
-- Configuración global de LSP
-- ======================

-- Diagnósticos globales
vim.diagnostic.config({
  virtual_text = { prefix = "●" }, -- punto sólido
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Capabilities compartidos (para nvim-cmp)
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Opcional: handlers globales (ej. hover con bordes)
local border = "rounded"
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = border }
)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = border }
)

-- ======================
-- Cargar setups de cada LSP
-- ======================

local lsp_servers = {
  "clojure",
  "lua",
  -- agrega aquí más archivos que tengas en lua/lsp/
}

for _, server in ipairs(lsp_servers) do
  local ok, mod = pcall(require, "lsp." .. server)
  if ok then
    -- Si el módulo exporta una función, pásale capabilities
    if type(mod) == "function" then
      mod(capabilities)
    end
  else
    vim.notify("No se pudo cargar LSP config para " .. server, vim.log.levels.WARN)
  end
end

