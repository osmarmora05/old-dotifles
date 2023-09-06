-- wii bar meta

local awful     = require('awful')
local wibox     = require('wibox')
local beautiful = require('beautiful')
local dpi       = beautiful.xresources.apply_dpi

local modules   = require('widgets.wibar.module')

-- ? Add functionality to hide the wibar? but if it were added, 
-- ? think of a logic when the menubar is shown, since if it is hidden, why does it show the menubar.


return function(s)
   return awful.wibar {
      screen   = s,
      position = 'top',
      height   = dpi(48),
      widget   = {
         widget = wibox.container.background,
         bg     = beautiful.bg_normal,
         {
            widget  = wibox.container.margin,
            margins = {
               left = dpi(10), right = dpi(10),
               top = dpi(6), bottom = dpi(6)
            },
            {
               layout = wibox.layout.align.horizontal,
               expand = 'none',
               -- left widgets
               {
                  layout  = wibox.layout.fixed.horizontal,
                  spacing = dpi(10),
                  --modules.clock(),
                  modules.distro_icon(),
                  modules.search(),
                  modules.tasklist(s)
               },
               -- middle widgets
               modules.taglist(s),  
               -- right widgets
               {
                  layout  = wibox.layout.fixed.horizontal,
                  spacing = dpi(16),
                  modules.systray(),
                  modules.battery,
                  modules.wifi(),
                  modules.clock(),
                  modules.layoutbox(),
                  modules.shutdown_icon()
               }
            }
         }
      }
   }
end
