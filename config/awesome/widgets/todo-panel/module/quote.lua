
-- by chadcat7

local helpers = require('helpers')
local wibox = require('wibox')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi


local quotes = {
  {
    quote = 'He that can have patience can have what he will',
    author = 'Benjamin Franklin'
  },
  {
    quote = 'I am never afraid of failure; for I would sooner fail than not be among the greatest',
    author = 'John Keats'
  },
  {
    quote = 'Tomorrow we will run faster, stretch out our arms farther',
    author = ' F. Scott Fitzgerald '
  },
  {
    quote = 'All we have to decide is what to do with the time that is given us. ',
    author = 'J. R. R. Tolkein'
  }
}

-- Widgets
----------
local finalwidget = wibox.widget {
  {
    {
      {
        {
          {
            id = 'quote',
            font = beautiful.font_sans .. ' 14',
            markup = '',
            valign = 'center',
            align = 'start',
            widget = wibox.widget.textbox,
          },
          {
            {
              id = 'author',
              font = beautiful.font_sans .. ' 12',
              markup = '',
              valign = 'center',
              halign = 'end',
              widget = wibox.widget.textbox,
            },
            widget = wibox.container.place,
            halign = 'end'
          },
          spacing = 15,
          layout = wibox.layout.fixed.vertical
        },
        widget = wibox.container.place,
        valign = 'center'
      },
      widget = wibox.container.margin,
      margins = 20,
    },
    {
      font = beautiful.font_sans .. ' 150',
      markup = helpers.colorize_text('"', beautiful.blue .. '22'),
      valign = 'center',
      align = 'start',
      widget = wibox.widget.textbox,
    },
    forced_width = 600,
    layout = wibox.layout.stack
  },
  forced_width = 700,
  widget = wibox.container.background,
  bg = beautiful.bg_light,
  shape = helpers.rounded_rect(dpi(4)),
}

local update = function()
  local random = quotes[math.random(#quotes)]
  finalwidget:get_children_by_id('quote')[1].markup = random.quote
  finalwidget:get_children_by_id('author')[1].markup = helpers.colorize_text('~ ' .. random.author, beautiful.blue)
end

update()

return finalwidget