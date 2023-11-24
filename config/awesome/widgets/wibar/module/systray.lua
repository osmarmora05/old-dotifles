-- by chadcat7

local awful       = require('awful')
local beautiful   = require('beautiful')
local helpers     = require('helpers')
local wibox       = require('wibox')
local dpi         = beautiful.xresources.apply_dpi

-- TOGGLER

local togglertext = wibox.widget {
  font = beautiful.font_icon .. ' 18',
  text = '󰅃',
  valign = 'center',
  align = 'center',
  buttons = {
    awful.button({}, 1, function()
      awesome.emit_signal('systray::toggle')
    end)
  },
  widget = wibox.widget.textbox,
}

-- TRAY

local systray     = wibox.widget {
  {
    widget = wibox.widget.systray,
  },
  top = dpi(9),
  bottom = dpi(9),
  visible = false,
  left = dpi(9),
  right = dpi(9),
  widget = wibox.container.margin
}

awesome.connect_signal('systray::toggle', function()
  if systray.visible then
    systray.visible = false
    togglertext.text = '󰅃'
  else
    systray.visible = true
    togglertext.text = '󰅀'
  end
end)

-- Final widget 

return function ()
  return wibox.widget {
    {
      {
        systray,
        togglertext,
        layout = wibox.layout.fixed.vertical,
      },
      shape = helpers.rounded_rect(dpi(2)),
      bg = beautiful.bg_normal,
      widget = wibox.container.background,
    },
    margins = 0,
    widget  = wibox.container.margin,
  }
end