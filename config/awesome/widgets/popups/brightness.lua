local awful = require('awful')
local beautiful = require('beautiful')
local gears = require('gears')
local wibox = require('wibox')
local animation = require('modules.animation')
local dpi      = beautiful.xresources.apply_dpi



return function(s)
  local icon = wibox.widget {
    widget = wibox.widget.textbox,
    font = beautiful.font_icon .. ' 60',
    halign = 'center',
  }
  local progress = wibox.widget {
    widget = wibox.widget.progressbar,
    forced_width = 130,
    forced_height = 15,
    shape = gears.shape.rounded_bar,
    bar_shape = gears.shape.rounded_bar,
    value = 0,
    max_value = 1,
    background_color = beautiful.bg_normal,
    color = beautiful.blue,
  }
  local anim = animation:new {
    duration = 0.1,
    easing = animation.easing.linear,
    update = function(self, pos)
      progress:set_value(pos)
    end,
  }

  local widget = awful.popup {
    visible = false,
    ontop = true,
    x = dpi(880),
    y = dpi(800),
    minimum_width = 170,
    minimum_height = 170,
    shape = gears.shape.rectangle,
    bg = gears.color.transparent,
    widget = {
      {
        widget = wibox.container.place,
        halign = 'center',
        valign = 'center',
        { layout = wibox.layout.fixed.vertical, spacing = 20, icon, progress },
      },
      widget = wibox.container.background,
      bg = beautiful.bg_normal
    }
  }
  local hide = gears.timer {
    timeout = 1,
    callback = function()
      widget.visible = false
    end
  }
  local show = false

awesome.connect_signal('signal::brightness', function(brightness)
    if show == true then
        if brightness == 0 or brightness <= 35 then
            icon.text = '󰃜'
          elseif brightness > 35 and brightness <= 75 then
            icon.text = '󰃛'
          elseif brightness > 50 then
            icon.text = '󰃚'
          end
          anim:set(brightness / 100)
    
          if widget.visible then
            hide:again()
          else
            widget.visible = true
            hide:again()
        end
    else
        anim:set(brightness / 100)
      show = true
    end
end)

  return widget
end
