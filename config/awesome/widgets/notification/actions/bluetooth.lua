local gears = require("gears")
local beautiful = require("beautiful")
local naughty = require("naughty")
local gc        = gears.color
local gfs       = gears.filesystem

local first   = true
local ok  = naughty.action { name = 'Ok' }

awesome.connect_signal('signal::bluetooth', function(is_enabled)
    if first then
        first = false
    else
        if is_enabled then
            naughty.notification({
                icon    = gc.recolor_image(gfs.get_configuration_dir() .. 'theme/assets/notification/bluetooth_on.svg', beautiful.green),
                title   = 'Bluetooth',
                message    = 'bluetooth on',
                actions = { ok }
               })
        else
            naughty.notification({
                icon    = gc.recolor_image(gfs.get_configuration_dir() .. 'theme/assets/notification/bluetooth_off.svg', beautiful.red),
                title   = 'Bluetooth',
                text    = 'bluetooth off',
                actions = { ok }
               })
        end
    end
   
end)