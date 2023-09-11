local beautiful = require('beautiful')
local wibox     = require('wibox')

local dpi       = beautiful.xresources.apply_dpi

local helpers   = require('helpers')
local widgets   = require('widgets.calendar.module')
local rubato    = require('modules.rubato')


local panel = wibox {
   ontop   = true,
   visible = false,
   width   = dpi(400),
   height  = dpi(520),
   --y       = dpi(55),
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

-- Animations
local slide = rubato.timed{
   pos = dpi(-panel.height),
   rate = 60,
   intro = 0.1,
   duration = 0.46,
   awestore_compat = true,
   subscribed = function(pos) panel.y = pos end
}

-- Flag
local calendar_status = false

slide.ended:subscribe(function()
   if calendar_status then
       panel.visible = false
   end
end)

local calendar_show = function()
   slide:set(dpi(55) + beautiful.useless_gap * 2)
   panel.visible = true
   calendar_status = false
end

local calendar_hide = function()
   slide:set(dpi(-panel.height))
   calendar_status = true
end

function panel:show()
   --panel.visible = not panel.visible

   if panel.visible then
      calendar_hide()
   else
      calendar_show()
   end

   if panel.visible then
      widgets.calendar.reset_calendar()
   end
end

return panel
