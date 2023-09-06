local awful     = require('awful')
local wibox     = require('wibox')
local beautiful = require('beautiful')

local dpi       = beautiful.xresources.apply_dpi

local buttons   = require('bindings.widgets.layoutbox').buttons

return function()
   return wibox.widget {
      widget  = wibox.container.margin,
      margins = {
         top = dpi(7), bottom = dpi(7)
      },
      {
         widget  = awful.widget.layoutbox,
         screen  = s
      },
      buttons = buttons
   }
end
