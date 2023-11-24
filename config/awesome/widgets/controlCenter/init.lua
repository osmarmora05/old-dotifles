local beautiful = require('beautiful')
local wibox     = require('wibox')

local dpi       = beautiful.xresources.apply_dpi

local helpers   = require('helpers')
local widgets   = require('widgets.controlCenter.module')


local panel = wibox{
   ontop   = true,
   visible = false,
   width   = dpi(410),
   height  = dpi(640),
   y       = dpi(5),
   x       = dpi(60),
   bg      = beautiful.bg_normal,
   shape   = helpers.rounded_rect(dpi(4)),
   widget = {
    {
        {
            
            { -- Top
                widgets.profile,
                widgets.setting,
                spacing = dpi(28),
                layout = wibox.layout.fixed.horizontal
            },
            { -- Middle
                widgets.sliders,
                spacing = dpi(28),
                layout = wibox.layout.fixed.horizontal
            }, -- Bottom
            widgets.themer,
            spacing = dpi(28),
            layout = wibox.layout.fixed.vertical
        },
        spacing = dpi(28),
        layout = wibox.layout.fixed.horizontal
    },
    margins = dpi(28),
    widget = wibox.container.margin

}

}

function panel:show()
    panel.visible = not panel.visible

    if panel.visible then
        widgets.themer.reset()
    end
 end


return panel