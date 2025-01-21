-- General settings
require("config.general")

-- Plugins
require("config.lazy")

-- For each filetype
local home = os.getenv('HOME')
package.path = home .. '/.config/nvim/lua/config/filetype/?.lua;' .. package.path
require("sh")
require("c")
require("haskell")
require("lua")
require("python")
require("tex")
require("typescript")
