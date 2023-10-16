local beautiful = require('beautiful')
local wibox     = require('wibox')

local dpi       = beautiful.xresources.apply_dpi

local helpers   = require('helpers')
local widgets   = require('widgets.calendar.module')


local panel = wibox {
   ontop   = true,
   visible = false,
   width   = dpi(400),
   height  = dpi(520),
   y       = dpi(5),
   x       = dpi(1510),
   bg      = beautiful.bg_normal,
   shape   = helpers.rounded_rect(dpi(4)),
   widget  = {
      layout = wibox.layout.fixed.vertical,
      {
         widget  = wibox.container.margin,
         margins = {
            top = dpi(5), left = dpi(24),
            bottom = dpi(16)
         },
      },
      {
         widget  = wibox.container.margin,
         margins = dpi(32),
         {
            layout  = wibox.layout.fixed.vertical,
            spacing = dpi(20),
            {
               layout = wibox.layout.fixed.vertical,
               spacing = dpi(35),
               widgets.clock(),
               widgets.calendar
            },
         }
      }
   }
}

function panel:show()
   panel.visible = not panel.visible

   if panel.visible then
      widgets.calendar.reset_calendar()
   end
end

return panel