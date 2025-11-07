vim.lsp.enable('bashls')
vim.lsp.enable('clangd')
vim.lsp.enable('hls')
vim.lsp.enable('lua_ls')
vim.lsp.enable('pyright')
vim.lsp.enable('ruff')
vim.lsp.enable('texlab')
vim.lsp.enable('ts_ls')

-- LSP keybindings
vim.api.nvim_create_autocmd(
  "LspAttach",
  {
    callback = function(event)
      local opts = {
        noremap = true,
        silent = true,
        buffer = event.buf,
      }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    end,
  }
)

-- Enable completion
vim.o.completeopt = 'menuone,noselect,popup'
vim.lsp.config(
  "*",
  {
    on_attach = function(client, bufnr)
      vim.lsp.completion.enable(
        true,
        client.id,
        bufnr,
        {
          autotrigger = true,
          convert = function(item)
            return { abbr = item.label:gsub('%b()', '') }
          end,
        }
      )
    end,
    before_init = function(params)
      params.processId = vim.NIL
    end,
  }
)
