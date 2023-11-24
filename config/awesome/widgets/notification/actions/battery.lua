local gears = require("gears")
local beautiful = require("beautiful")
local naughty = require("naughty")
local gc        = gears.color
local gfs       = gears.filesystem

local display_low = true
local display_half= true
local ok  = naughty.action { name = 'Ok' }

awesome.connect_signal('signal::battery', function (level, state, _, _, _)
    local value = level

    if value <=20 and display_low then
        naughty.notification({
         icon    = gc.recolor_image(gfs.get_configuration_dir() .. 'theme/assets/notification/battery_low.svg', beautiful.red),
         title   = 'Uh, oh!',
         text    = 'Your battery is low. ' .. math.floor(value) .. "%",
         actions = { ok }
        })
        display_low = false
    end
    
    if value > 20 and value <40 then
        display_low = true
    end

    if value >=21 and value <= 40 and display_half then
        naughty.notification({
            icon    = gc.recolor_image(gfs.get_configuration_dir() .. 'theme/assets/notification/battery_half.svg', beautiful.yellow),
            title   = 'Halfway There!',
            text    = 'Your battery level is at ' .. math.floor(value) .. "%",
            actions = { ok }
           })
           display_half = false
    end

    if value > 40 then
        display_half = true
    end

end)
