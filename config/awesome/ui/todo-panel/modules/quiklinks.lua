-------------------------------------
-- todo-panel: quick links by chadcat7 --
-------------------------------------

-- Imports
----------
local helpers = require("helpers")
local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")

-- Widgets
----------
local createButton = function(icon, name, color)
  return wibox.widget {
    {
      {
        {
          id = "icon",
          font = beautiful.mn_font .. " 35",
          markup = helpers.colorizeText(icon, color),
          valign = "center",
          align = "center",
          widget = wibox.widget.textbox,
        },
        widget = wibox.container.margin,
        top = 10,
        left = 18,
        bottom = 10,
        right = 10,
      },
      shape = helpers.mkroundedrect(),
      bg = beautiful.blk,
      widget = wibox.container.background,
      buttons = {
        awful.button({}, 1, function()
          awful.spawn.with_shell(browser.." " .. name)
        end)
      },
    },
    widget = wibox.container.place,
    halign = 'center',
  }
end

local finalwidget = wibox.widget {
  {
    {
      createButton(" ", 'https://www.reddit.com/', beautiful.red),
      createButton(" ", 'https://web.whatsapp.com/', beautiful.grn),
      createButton(" ", 'https://stackoverflow.com/', beautiful.ylw),
      createButton(" ", 'https://github.com/osmarmora05', beautiful.wht),
      createButton(" ", "https://youtube.com/", beautiful.blu),
      spacing = 18,
      layout = wibox.layout.fixed.vertical
    },
    widget = wibox.container.margin,
    top = 10,
    bottom = 18
  },
  forced_width = 100,
  shape = helpers.mkroundedrect(),
  widget = wibox.container.background,
  bg = beautiful.lbg
}

return finalwidget
