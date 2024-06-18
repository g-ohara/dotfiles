-- Design.lua
-- This file configures the appearance of Neovim.


-- Visually indent wrapped lines
vim.opt.breakindent = true

-- Set column lign at 80 characters
vim.opt.colorcolumn = "80"

-- Set column lign at 72 and 79 characters for Python
vim.api.nvim_create_autocmd(
    "FileType",
    {
        group = vim.api.nvim_create_augroup("local_colorcolumn", {}),
        pattern = { "python" },
        callback = function()
            vim.opt.colorcolumn = "72,79"
        end
    }
)

-- Display underline for cursor line
vim.opt.cursorline = true

-- Set line number
vim.opt.number = true

-- Not show mode since it is already shown by lualine
vim.opt.showmode = false

-- Enable syntax highlighting
vim.opt.syntax = "on"
