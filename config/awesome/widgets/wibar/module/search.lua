-- by chadcat7

local beautiful = require('beautiful')
local wibox = require('wibox')
local awful = require('awful')
local helpers = require('helpers')
local dpi       = beautiful.xresources.apply_dpi
local menubar       = require('menubar')


return function ()
  local search = wibox.widget {
  {
    {
      {
        font = beautiful.font_icon .. ' 14',
        markup = helpers.colorize_text('󰍉 ', beautiful.blue),
        widget = wibox.widget.textbox,
        valign = 'center',
        align = 'center'
      },
      {
        id = 'search',
        font = beautiful.font_sans .. ' 11',
        markup = 'Search',
        widget = wibox.widget.textbox,
        valign = 'center',
        align = 'center'
      },
      spacing = 10,
      layout = wibox.layout.fixed.horizontal
    },
    widget = wibox.container.margin,
    margins = 7,
  },
  forced_width = 150,
  shape = helpers.rounded_rect(dpi(4)),
  widget = wibox.container.background,
  bg = beautiful.bg_light .. 'cc'
}


search:connect_signal('mouse::enter', function()
  search.bg = beautiful.mid_dark
end)
search:connect_signal('mouse::leave', function()
  search.bg = beautiful.bg_light
end)

search.buttons = {
  awful.button({}, 1, function()
    menubar.show()
  end)
}

return search
end


