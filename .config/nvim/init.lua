-- General settings
require("config.general")

-- Plugins
require("config.lazy")

-- LSP configurations
require("lsp")

-- For each filetype
local home = os.getenv('HOME')
package.path = home .. '/.config/nvim/lua/config/filetype/?.lua;' .. package.path
require("python")
require("tex")
