

package.path = package.path .. ';./?.lua'
--package.path = './?.lua;' .. package.path

require('bootstrap_lazy')

local plugin_table = require('plugin_table')
require('lazy').setup( plugin_table)
