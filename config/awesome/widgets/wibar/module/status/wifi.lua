local awful     = require('awful')
local wibox     = require('wibox')
local beautiful = require('beautiful')
local dpi       = beautiful.xresources.apply_dpi

local helpers   = require('helpers')

return function ()
    local wifi = wibox.widget {
        {
            {
                id      = 'text_role',
                font    = beautiful.font_icon .. '15',
                align   = 'center',
                widget  = wibox.widget.textbox,
            },
            margins = dpi(5),
            widget  = wibox.container.margin
        },
        bg     = beautiful.bg_normal,
        shape  = helpers.rounded_rect(dpi(4)),
        widget = wibox.container.background,
        buttons = {
            awful.button({}, 1, function() awesome.emit_signal('network::toggle') end)
        },
        set_text = function(self, content)
            self:get_children_by_id('text_role')[1].text = content
        end
    }
    wifi:connect_signal('mouse::enter', function()
        wifi.bg = beautiful.mid_dark
     end)
     wifi:connect_signal('mouse::leave', function()
        wifi.bg = beautiful.bg_normal
     end)

     awesome.connect_signal('signal::network', function(is_enabled)
        wifi.text   = is_enabled and '' or ''
    end)

    return wifi
end
