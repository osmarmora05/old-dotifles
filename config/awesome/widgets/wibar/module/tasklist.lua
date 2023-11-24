local awful     = require('awful')
local beautiful = require('beautiful')
local wibox     = require('wibox')
local gears     = require('gears')

local dpi       = beautiful.xresources.apply_dpi

local buttons   = require('bindings.widgets.tasklist').buttons
local helpers   = require('helpers')

return function(s)
   return awful.widget.tasklist {
      screen  = s,
      filter  = awful.widget.tasklist.filter.currenttags,
      buttons = buttons,
      source  = function()
         local ret = {}
         for _, t in ipairs(s.tags) do
            gears.table.merge(ret, t:clients())
         end
         return ret
      end,
      style   = {
         disable_task_name = true,
         bg_normal         = '#00000000',
         bg_focus          = beautiful.bg_dark,
         bg_urgent         = beautiful.red_dark,
         bg_minimize       = '#00000000',
         shape             = helpers.rounded_rect(dpi(8))
      },
      layout  = {
         layout = wibox.layout.fixed.vertical
      },
      widget_template = {
         widget = wibox.container.background,
         id     = 'background_role',
         {
            widget  = wibox.container.margin,
            margins = dpi(6),
            {
               widget = awful.widget.clienticon
            }
         }
      }
   }
end