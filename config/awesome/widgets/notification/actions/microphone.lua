local gears = require("gears")
local beautiful = require("beautiful")
local naughty = require("naughty")
local gc        = gears.color
local gfs       = gears.filesystem


local first   = true
local ok  = naughty.action { name = 'Ok' }

awesome.connect_signal('signal::microphone', function(mic_level, mic_muted)

    if first then
        first = false
    else
        if mic_muted then
            naughty.notification({
                icon    = gc.recolor_image(gfs.get_configuration_dir() .. 'theme/assets/notification/microphone_on.svg', beautiful.green),
                title   = 'Microphone',
                message    = 'Microphone on',
                actions = { ok }
               })
        else
            naughty.notification({
                icon    = gc.recolor_image(gfs.get_configuration_dir() .. 'theme/assets/notification/microphone_off.svg', beautiful.red),
                title   = 'Microphone',
                message    = 'Microphone off',
                actions = { ok }
               })
        end
    end  
end)