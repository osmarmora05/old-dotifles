local awful     = require('awful')
local wibox     = require('wibox')
local beautiful = require('beautiful')

local dpi       = beautiful.xresources.apply_dpi

local helpers   = require('helpers')
local panel     = require('widgets.calendar')

return function()
   local clock = wibox.widget {
      widget = wibox.container.background,
      shape  = helpers.rounded_rect(dpi(4)),
      bg     = beautiful.bg_light,
      {
         widget  = wibox.container.margin,
         margins = {
            left = dpi(12), right = dpi(12),
            top = dpi(6), bottom = dpi(6)
         },
         {
            layout  = wibox.layout.fixed.horizontal,
            spacing = dpi(8),
            {
               widget = wibox.widget.textclock,
               format = '%H:%M',
               font   = beautiful.font_mono .. 'Bold ' .. dpi(10)
            }
         }
      }
   }

   clock:connect_signal('mouse::enter', function()
      clock.bg = beautiful.mid_dark
   end)
   clock:connect_signal('mouse::leave', function()
      clock.bg = beautiful.bg_light
   end)

   clock.buttons = {
      awful.button({}, 1, function()
         panel:show()
      end)
   }
   
   return clock
end
