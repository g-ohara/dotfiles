-- General settings
require('general')

-- Plugins
require('plugins')

-- For each filetype
local home = os.getenv('HOME')
package.path = home .. '/.config/nvim/lua/filetype/?.lua;' .. package.path
require("c")
require("haskell")
require("lua")
require("python")
require("tex")
require("typescript")
