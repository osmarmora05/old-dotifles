-- by chadcat7

local beautiful  = require('beautiful')
local wibox      = require('wibox')
local awful      = require('awful')
local menubar    = require('menubar')
local dpi        = beautiful.xresources.apply_dpi
local helpers    = require('helpers')


return function ()
  local search = wibox.widget {
    {
        {
          text = '󰍉',
            font    = beautiful.font_icon .. '15',
            align   = 'center',
            widget  = wibox.widget.textbox,
        },
        margins = dpi(5),
        widget  = wibox.container.margin
    },
    shape  = helpers.rounded_rect(dpi(4)),
    widget = wibox.container.background
}


search:connect_signal('mouse::enter', function()
  search.bg = beautiful.mid_dark
end)
search:connect_signal('mouse::leave', function()
  search.bg = beautiful.bg_normal
end)

search.buttons = {
  awful.button({}, 1, function()
    menubar.show()
  end)
}

return search
end