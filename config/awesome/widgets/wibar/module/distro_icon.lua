local awful     = require('awful')
local gears     = require('gears')
local wibox     = require('wibox')
local beautiful = require('beautiful')
local dpi       = beautiful.xresources.apply_dpi
local control   = require('widgets.control')
local colors    = require('widgets.wibar.module.colors')

return function()
    local distro_icon = wibox.widget {
        {
            {
                {
                    image      = beautiful.distro_logo,
                    widget     = wibox.widget.imagebox
                },
                margins = dpi(9),
                widget  = wibox.container.margin
            },
            align  = 'center',
            widget = wibox.container.place
        },
        bg            = colors.bg_light,
        shape         = function(c, w, h)
            gears.shape.rounded_rect(c, w, h, dpi(4))
        end,
        forced_height = dpi(50),
        widget        = wibox.container.background
    }

    distro_icon:connect_signal('mouse::enter', function()
        distro_icon.bg = colors.mid_dark
    end)

    distro_icon:connect_signal('mouse::leave', function()
        distro_icon.bg = colors.bg_light
    end)

    distro_icon.buttons = {
        awful.button({}, 1, function()
            control:show()
        end)
    }

    return distro_icon
end