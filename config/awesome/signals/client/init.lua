require('awful.autofocus')

------------------------
-- Client Decorations --
------------------------

local awful     = require('awful')
local wibox     = require('wibox')
local gears     = require('gears')
local beautiful = require('beautiful')
local dpi       = beautiful.xresources.apply_dpi
local animation    = require("modules.animation")

local helpers   = require('helpers')

local width_buttons = 12


-- Focus client on hover.
client.connect_signal('mouse::enter', function(c)
   c:activate { context = 'mouse_enter', raise = false }
end)



-- Buttons
----------

-- Circular buttons
-------------------
local mkbutton = function (width,color,onclick)
  return function(c)
    local button = wibox.widget {
      wibox.widget.textbox(),
      forced_width  = dpi(width),
      forced_height = dpi(12),
      bg            = color,
      shape         = helpers.rounded_rect(dpi(10)),
      widget        = wibox.container.background
    }

    local color_transition = helpers.apply_transition {
      element   = button,
      prop      = 'bg',
      bg        = color,
      hbg       = beautiful.titlebar_fg_normal,
    }

    client.connect_signal('property::active', function()
      if c.active then
        color_transition.off()
      else
        color_transition.on()
      end
    end)

    button:add_button(awful.button({}, 1, function()
      if onclick then
        onclick(c)
      end
    end))

     -- Animation
     local anim = animation:new({
      duration = 0.12,
      easing = animation.easing.linear,
      update = function(_, pos)
        button.forced_width = pos
      end,
    })
    button:connect_signal('mouse::enter', function(_)
      anim:set(50)
    end)
    button:connect_signal('mouse::leave', function(_)
      anim:set(12)
    end)

    return button
  end
end


local close = mkbutton(width_buttons,beautiful.red, function(c)
  c:kill()
end)

local maximize = mkbutton(width_buttons,beautiful.blue, function(c)
    c.maximized = not c.maximized
end)

local minimize = mkbutton(width_buttons,beautiful.magenta,function(c)
    gears.timer.delayed_call(function()
        c.minimized = not c.minimized
    end)
end)





client.connect_signal('request::titlebars', function(c)
   -- Don't show titlebars on clients that explictly request not to
   -- have them, like the Steam client or many fullscreen apps, for
   -- example.
   if c.requests_no_titlebar then return end

   -- buttons for the titlebar

   local buttons = {
      awful.button({ }, 1, function()
          c:activate { context = "titlebar", action = "mouse_move"  }
      end),
      awful.button({ }, 3, function()
          c:activate { context = "titlebar", action = "mouse_resize"}
      end),
  }

  local n_titlebar = awful.titlebar(c, {
      size     = dpi(30),
      position = 'top',
  })
  n_titlebar.widget = {
      {
          {
              { -- Start
                  close(c),
                  maximize(c),
                  minimize(c),
                  spacing = dpi(8),
                  layout  = wibox.layout.fixed.horizontal
              },
              { -- Middle
                  buttons = buttons,
                  layout  = wibox.layout.fixed.horizontal
              },
              { -- End
                  --sticky(c),
                  spacing = dpi(10),
                  layout  = wibox.layout.fixed.horizontal
              },
              spacing = dpi(5),
              layout  = wibox.layout.align.horizontal
          },
          direction = 'north',
          widget    = wibox.container.rotate
      },
      margins = dpi(9),
      widget  = wibox.container.margin

   }

   -- Draws titlebars as inner border on all 4 sides of the client.
   -- The outer border is declared in `theme/init.lua`, as well as all colors.

   -- for _, p in ipairs({ 'left', 'right', 'top', 'bottom' }) do
   --    awful.titlebar(c, { position = p, size = dpi(user.borders) }).widget = {
   --       layout = wibox.layout.align.horizontal,
   --       nil, nil, nil,
   --       buttons = buttons
   --    }
   -- end
end)

-- Floating windows always on top.
client.connect_signal('property::floating', function(c) c.ontop = c.floating end)

-- Send fullscreen windows to the top.
client.connect_signal('property::fullscreen', function(c) c:raise() end)
