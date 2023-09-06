local awful     = require('awful')
local wibox     = require('wibox')
local gears     = require('gears')
local beautiful = require('beautiful')

local dpi       = beautiful.xresources.apply_dpi

local buttons   = require('bindings.widgets.taglist').buttons
local rubato    = require('modules.rubato')

return function(s)
   return awful.widget.taglist {
      screen  = s,
      filter  = awful.widget.taglist.filter.all,
      buttons = buttons,
      layout  = {
         layout  = wibox.layout.fixed.horizontal,
         spacing = dpi(8)
      },
      style   = {
         bg_focus    = beautiful.yellow,
         bg_occupied = beautiful.mid_light,
         bg_empty    = beautiful.mid_dark,
         bg_urgent   = beautiful.red
      },
      -- The fun stuff.
      widget_template = {
         -- Create the tag icon as an empty textbox.
         widget  = wibox.container.margin,
         margins = {
            bottom = dpi(17), top = dpi(17)
         },
         {
            widget = wibox.container.background,
            id     = 'background_role',
            {
               widget = wibox.widget.textbox,
               text   = ''
            },
         },

         -- Create a callback to change its size with an animation depending
         -- on focus and occupation.
         create_callback = function(self, tag)
            self.animate = rubato.timed {
               duration   = 0.15,
               subscribed = function(h)
                  self:get_children_by_id('background_role')[1].forced_width = h
               end
            }
            self.update = function()
               if tag.selected then
                  -- If the tag is focused:
                  self.animate.target = dpi(64)
               elseif #tag:clients() > 0 then
                  -- If the tag is occupied:
                  self.animate.target = dpi(48)
               else
                  -- If the tag is unoccupied and unfocused:
                  self.animate.target = dpi(32)
               end
            end
            -- Generate the bar sizes once.
            self.update()
         end,
         -- Then update on callback.
         update_callback = function(self)
            self.update()
         end
      }
   }
end
