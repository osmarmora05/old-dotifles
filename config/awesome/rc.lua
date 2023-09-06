-- awesome_mode: api-level=4:screen=on

-- load luarocks if installed
pcall(require, 'luarocks.loader')

-- load theme
local beautiful = require('beautiful')
local gfs       = require('gears.filesystem')
beautiful.init(gfs.get_configuration_dir() .. 'theme/init.lua')

-- load key and mouse bindings
require('bindings')

-- load rules
require('rules')

-- load signals
require('signals')

-- load autoexecs
require('config.auto')


-- 🗑 Garbage Collector Settings
collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)