local awful     = require('awful')
local wibox     = require('wibox')
local beautiful = require('beautiful')

local dpi       = beautiful.xresources.apply_dpi

local helpers   = require('helpers')
local panel     = require('widgets.calendar')

return function()
   local clock = wibox.widget {
      {
          {
              {
                  format = '<b>%H</b>',
                  font   = beautiful.font_mono .. 'Bold ' .. dpi(11),
                  halign = "center",
                  widget = wibox.widget.textclock
              },
              {
                  {
                      format = '<b>%M</b>',
                      font   = beautiful.font_mono .. dpi(11),
                      halign = "center",
                      widget = wibox.widget.textclock
                  },
                  fg     = beautiful.fg_normal ..'90',
                  widget = wibox.container.background
              },
              layout  = wibox.layout.fixed.vertical
          },
          margins = dpi(10),
          widget  = wibox.container.margin
      },
      bg     = beautiful.bg_light,
      shape  = helpers.rounded_rect(4),
      widget = wibox.container.background
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
