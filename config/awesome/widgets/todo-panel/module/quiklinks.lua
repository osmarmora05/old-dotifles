-- by chadcat7 

local helpers = require('helpers')
local wibox = require('wibox')
local awful = require('awful')
local beautiful = require('beautiful')
local dpi       = beautiful.xresources.apply_dpi
local apps          = require('config.apps')


local function create_button(icon, name, color)
  local button_widget =  wibox.widget {
      {
        {
          id = 'icon',
          font = beautiful.font_icon .. ' 35',
          markup = helpers.colorize_text(icon, color),
          valign = 'center',
          align = 'center',
          widget = wibox.widget.textbox,
        },
        widget = wibox.container.margin,
        top = 10,
        left = 8,
        bottom = 10,
        right = 20,
      },
      shape = helpers.rounded_rect(dpi(4)),
      bg = beautiful.mid_dark,
      widget = wibox.container.background,
      buttons = {
        awful.button({}, 1, function()
          awful.spawn.with_shell(apps.browser..' ' .. name)
        end)
      },
  }

    button_widget:connect_signal('mouse::enter', function()
        button_widget.bg = beautiful.mid_normal
    end)

    button_widget:connect_signal('mouse::leave', function()
        button_widget.bg = beautiful.mid_dark
    end)

  return button_widget
end


return wibox.widget {
  {
    {
      create_button('󰑍', 'https://www.reddit.com/', beautiful.red),
      create_button('󰖣', 'https://web.whatsapp.com/', beautiful.green),
      create_button('󰉎', 'https://drive.google.com/drive/', beautiful.cyan),
      create_button('󰊤', 'https://github.com/osmarmora05', beautiful.fg_normal),
      create_button('󰊫', 'https://mail.google.com/', beautiful.blue),
      spacing = 20,
      layout = wibox.layout.fixed.vertical
    },
    widget = wibox.container.margin,
    top = 10,
    bottom = 10,
    left = 8,
    right = 8
  },
  forced_width = 100,
  shape = helpers.rounded_rect(dpi(4)),
  widget = wibox.container.background,
  bg = beautiful.bg_light
}

