
local awful     = require('awful')
local wibox     = require('wibox')
local beautiful = require('beautiful')
local helpers   = require('helpers')
local dpi       = beautiful.xresources.apply_dpi
local controlCenter = require('widgets.controlCenter')

return function ()
    local distro_icon = wibox.widget {
        {
            {
                {
                    image      = beautiful.distro_logo,
                    clip_shape = helpers.rounded_rect(dpi(4)),
                    widget     = wibox.widget.imagebox 
                },
                margins = dpi(6),
                widget  = wibox.container.margin
            },
            align  = 'center',
            widget = wibox.container.place
        },
        bg     = beautiful.bg_light,
        shape  = helpers.rounded_rect(dpi(4)),
        widget = wibox.container.background
    }
    
    
    distro_icon:connect_signal('mouse::enter', function()
        distro_icon.bg = beautiful.mid_dark
     end)
     distro_icon:connect_signal('mouse::leave', function()
        distro_icon.bg = beautiful.bg_light
     end)
    
    
     distro_icon.buttons = {
        awful.button({}, 1, function()
            controlCenter:show()
        end)
    }
    return distro_icon
end
