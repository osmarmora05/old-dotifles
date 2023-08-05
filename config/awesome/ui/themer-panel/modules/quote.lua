-------------------------------------
-- todo-panel: quotes by chadcat7 --
-------------------------------------

-- Imports
----------

local helpers = require("helpers")
local wibox = require("wibox")
local beautiful = require("beautiful")

--quotes
-------
local quotes = {
  {
    quote = "He that can have patience can have what he will",
    author = "Benjamin Franklin"
  },
  {
    quote = "The question is not who is going to leave me; is who is going to stop me.",
    author = "Ayn Rand"
  },
  {
    quote = "Life would be so much easier if could just look at the source code",
    author = "Dave Olsen"
  },
  {
    quote = "Work hard in silence and let your success make all the noise.",
    author = "Frank Ocean"
  }
}

-- Widgets
----------
local final_widget = wibox.widget {
  {
    {
      {
        {
          {
            id = "quote",
            font = beautiful.mn_font .. " 14",
            markup = "",
            valign = "center",
            align = "start",
            widget = wibox.widget.textbox,
          },
          {
            {
              id = "author",
              font = beautiful.mn_font .. " 12",
              markup = "",
              valign = "center",
              halign = "end",
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
      font = beautiful.mn_font .. " 150",
      markup = helpers.colorize_text('"', beautiful.blu .. '22'),
      valign = "center",
      align = "start",
      widget = wibox.widget.textbox,
    },
    forced_width = 600,
    layout = wibox.layout.stack
  },
  forced_width = 700,
  widget = wibox.container.background,
  bg = beautiful.lbg,
  shape = helpers.mkroundedrect(8),
}

local update = function()
  local random = quotes[math.random(#quotes)]
  final_widget:get_children_by_id('quote')[1].markup = random.quote
  final_widget:get_children_by_id('author')[1].markup = helpers.colorize_text('~ ' .. random.author, beautiful.blu)
end

update()

return final_widget
