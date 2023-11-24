local gears = require("gears")
local beautiful = require("beautiful")
local naughty = require("naughty")
local gc        = gears.color
local gfs       = gears.filesystem

local first   = true
local ok  = naughty.action { name = 'Ok' }

awesome.connect_signal('signal::network', function(is_enabled)
    if first then
        first = false
    else
        if is_enabled then
            naughty.notification({
                icon    = gc.recolor_image(gfs.get_configuration_dir() .. 'theme/assets/notification/wifi_on.svg', beautiful.green),
                title   = 'Wifi',
                message    = 'Wifi on',
                actions = { ok }
               })
        else
            naughty.notification({
                icon    = gc.recolor_image(gfs.get_configuration_dir() .. 'theme/assets/notification/wifi_off.svg', beautiful.red),
                title   = 'Wifi',
                text    = 'Wifi off',
                actions = { ok }
               })
        end
        
    end

   
end)