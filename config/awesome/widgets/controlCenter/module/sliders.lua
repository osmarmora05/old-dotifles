local wibox            = require('wibox')
local beautiful        = require('beautiful')
local dpi = beautiful.xresources.apply_dpi
local gears            = require('gears')
local helpers          = require('helpers')

local createHandle     = function()
  return function(cr)
    gears.shape.rounded_rect(cr, 13, 13, 50)
  end
end

local brightnessSlider = wibox.widget {
  bar_shape           = helpers.rounded_rect(dpi(20)),
  bar_height          = 3,
  handle_color        = beautiful.mid_normal,
  bar_color           = beautiful.mid_normal .. '55',
  bar_active_color    = beautiful.mid_normal,
  handle_shape        = createHandle(),
  handle_border_width = 0,
  handle_width        = dpi(13),
  handle_margins      = { top = 11 },
  handle_border_color = beautiful.mid_dark .. 'cc',
  value               = 25,
  forced_height       = 3,
  maximum             = 100,
  widget              = wibox.widget.slider,
}

local brightnessLabel  = wibox.widget {
  font = beautiful.font_sans .. ' Bold 12',
  markup = '86' .. '%',
  valign = 'center',
  widget = wibox.widget.textbox,
}


local brightnessLabelBox = wibox.widget {
  brightnessLabel,
  widget = wibox.container.margin,
  margins = {
    left = dpi(16),
  }
}

local brightnessIcon = wibox.widget {
  {
    {
      {
        font = beautiful.font_icon .. ' 15',
        markup = helpers.colorize_text('', beautiful.fg_normal ),
        valign = 'center',
        widget = wibox.widget.textbox,
      },
      widget = wibox.container.margin,
      margins = 7,
    },
    bg = beautiful.mid_normal .. '11',
    widget = wibox.container.background
  },
  widget = wibox.container.margin,
  margins = {
    right = dpi(16)
  }
}

local brightnessScale = wibox.widget {
  brightnessIcon,
  brightnessSlider,
  brightnessLabelBox,
  layout = wibox.layout.align.horizontal,
}



local volumeSlider = wibox.widget {
  bar_shape           = helpers.rounded_rect(dpi(20)),
  bar_height          = 3,
  handle_color        = beautiful.mid_normal,
  bar_color           = beautiful.mid_normal .. '55',
  bar_active_color    = beautiful.mid_normal,
  handle_shape        = createHandle(),
  handle_border_width = 0,
  handle_width        = dpi(13),
  handle_margins      = { top = 11 },
  handle_border_color = beautiful.mid_dark .. 'cc',
  value               = 25,
  forced_height       = 3,
  maximum             = 100,
  widget              = wibox.widget.slider,
}

local volumeLabel = wibox.widget {
  font = beautiful.font_sans .. ' Bold 12',
  markup = '86' .. '%',
  valign = 'center',
  widget = wibox.widget.textbox,
}


local volumeLabelBox = wibox.widget {
  volumeLabel,
  widget = wibox.container.margin,
  margins = {
    left = dpi(16),
  }
}

local volumeIcon = wibox.widget {
  {
    {
      {
        font = beautiful.font_icon .. ' 15',
        markup = helpers.colorize_text('', beautiful.fg_normal),
        valign = 'center',
        widget = wibox.widget.textbox,
      },
      widget = wibox.container.margin,
      margins = 7,
    },
    bg = beautiful.mid_normal .. '11',
    widget = wibox.container.background
  },
  widget = wibox.container.margin,
  margins = {
    right = dpi(16)
  }
}

local volumeScale = wibox.widget {
  volumeIcon,
  volumeSlider,
  volumeLabelBox,
  layout = wibox.layout.align.horizontal,
}

-- Volume
---------
awesome.connect_signal('signal::volume', function(volume, muted)
    volumeSlider.value = volume
    volumeLabel.markup  = volume .. '%'
end)
volumeSlider:connect_signal('property::value', function(_, value)
    awesome.emit_signal('volume::set', tonumber(value))
end)


-- Brightness
-------------
awesome.connect_signal('signal::brightness', function(brightness)
    brightnessSlider.value = brightness
    brightnessLabel.markup = brightness .. '%'
end)

brightnessSlider:connect_signal('property::value', function(_, value)
    awesome.emit_signal('brightness::set', value)
end)


-- Final widget
return wibox.widget {
  {
    {
      brightnessScale,
      volumeScale,
      spacing = 15,
      layout = wibox.layout.fixed.vertical,
    },
    widget = wibox.container.margin,
    margins = dpi(15)
  },

  widget = wibox.container.background,
  shape = helpers.rounded_rect(dpi(4)),
  bg = beautiful.bg_light
}