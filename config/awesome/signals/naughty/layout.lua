local naughty   = require('naughty')
local beautiful = require('beautiful')
local gears     = require('gears')
local awful     = require('awful')
local wibox     = require('wibox')

local dpi       = beautiful.xresources.apply_dpi

local helpers   = require('helpers')
local rubato    = require('modules.rubato')

local def_icon  =
   gears.color.recolor_image(gears.filesystem.get_configuration_dir() .. 'theme/assets/awesome.svg', beautiful.yellow)

local _W = {}

function _W.title(n)
   return wibox.widget {
      widget = wibox.container.scroll.horizontal,
      speed  = 100,
      rate   = 60,
      {
         widget = wibox.widget.textbox,
         markup = n.title ~= nil and '<b>' .. n.title .. '</b>'
            or '<b>Notification</b>',
         font   = beautiful.font_sans .. dpi(11),
         halign = 'center',
         valign = 'center'
      }
   }
end

function _W.body(n)
   return wibox.widget {
      widget = wibox.container.scroll.horizontal,
      speed  = 100,
      rate   = 60,
      {
         widget = wibox.widget.textbox,
         markup = gears.string.xml_unescape(n.message),
         font   = beautiful.font_sans .. dpi(9),
         halign = 'center',
         valign = 'center'
      }
   }
end

function _W.image(n)
   return wibox.widget {
      widget = wibox.widget.imagebox,
      image  = n.icon and helpers.crop_surface(1, gears.surface.load_uncached(n.icon))
         or def_icon,
      resize = true,
      halign = 'center',
      valign = 'center',
      clip_shape = gears.shape.rounded_rect,
      buttons = { awful.button({}, 1, function() n:destroy() end) }
   }
end

function _W.timeout(n)
   return wibox.widget {
      widget           = wibox.widget.progressbar,
      min_value        = 0,
      max_value        = 100,
      value            = 0,
      background_color = beautiful.bg_dark,
      color            = {
         type  = 'linear',
         from  = { 0, 0   },
         to    = { 0, 100 },
         stops = { { 0, beautiful.green }, { 1, beautiful.green_dark } }
      },
      forced_height    = dpi(6)
   }
end

function _W.actions(n)
   if #n.actions == 0 then return nil end
   return wibox.widget {
      widget  = wibox.container.margin,
      margins = { top = dpi(8) },
      {
         widget       = naughty.list.actions,
         notification = n,
         base_layout  = wibox.widget {
            spacing = dpi(4),
            layout  = wibox.layout.flex.horizontal
         },
         style = {
            underline_normal   = false,
            underline_selected = false,
            bg_normal          = beautiful.bg_light,
            bg_selected        = beautiful.mid_dark,
            border_width       = 0
         },
         widget_template = {
            widget = wibox.container.background,
            id     = 'background_role',
            {
               widget  = wibox.container.margin,
               margins = dpi(4),
               {
                  widget = wibox.widget.textbox,
                  id     = 'text_role',
                  font   = beautiful.font_sans .. dpi(7)
               }
            }
         }
      }
   }
end

-- Default layout
naughty.connect_signal('request::display', function(n)
   -- Store the original timeout, and change it to a big, unreachable, number.
   local timeout = n.timeout
   n.timeout = 999999

   local timeout_bar = _W.timeout(n)
   
   local widget = naughty.layout.box {
      notification = n,
      cursor       = 'hand2',
      border_width = 0,
      -- position     = 'bottom_right',
      shape        = helpers.rounded_rect(dpi(8)),
      widget_template = {
         widget   = wibox.container.constraint,
         strategy = 'max',
         width    = dpi(300),
         height   = dpi(100),
         {
            widget   = wibox.container.constraint,
            strategy = 'min',
            width    = dpi(250),
            {
               widget = wibox.container.background,
               bg     = beautiful.bg_normal,
               {
                  layout  = wibox.layout.align.horizontal,
                  {
                     widget   = wibox.container.constraint,
                     strategy = 'exact',
                     width    = dpi(64),
                     {
                        widget = wibox.container.background,
                        bg     = beautiful.bg_light,
                        {
                           widget  = wibox.container.margin,
                           margins = dpi(10),
                           _W.image(n)
                        }
                     }
                  },
                  {
                     widget  = wibox.container.margin,
                     margins = dpi(16),
                     {
                        widget = wibox.container.place,
                        halign = 'left',
                        valign = 'center',
                        {
                           layout = wibox.layout.fixed.vertical,
                           _W.title(n),
                           _W.body(n),
                           _W.actions(n)
                        }
                     }
                  },
                  {
                     widget    = wibox.container.rotate,
                     direction = 'east',
                     timeout_bar
                  }
               }
            }
         }
      },
      buttons = {}
   }

   -- Set an animation for the timeout.
   local anim = rubato.timed {
      intro      = 0,
      duration   = timeout,
      subscribed = function(pos, time)
         timeout_bar.value = pos
         if time == timeout then n:destroy() end
      end
   }
   -- Whenever the notification is hovered, the animation (and timeout) are paused.
   widget:connect_signal('mouse::enter', function()
      anim.pause = true
   end)
   widget:connect_signal('mouse::leave', function()
      anim.pause = false
   end)
   anim.target = 100
end)
