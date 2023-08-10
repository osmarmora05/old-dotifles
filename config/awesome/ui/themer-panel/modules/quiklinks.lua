-------------------------------------
-- todo-panel: quick links by chadcat7 --
-------------------------------------

-- Imports
----------
local helpers = require("helpers")
local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")

--Widgets
--------
local function create_button(icon, name, color, colorFocus)
  local button_widget =  wibox.widget {
      {
        {
          id = "icon",
          font = beautiful.mn_font .. " 35",
          markup = helpers.colorize_text(icon, color),
          valign = "center",
          align = "center",
          widget = wibox.widget.textbox,
        },
        widget = wibox.container.margin,
        top = 10,
        left = 8,
        bottom = 10,
        right = 20,
      },
      shape = helpers.mkroundedrect(),
      bg = beautiful.blk,
      widget = wibox.container.background,
      buttons = {
        awful.button({}, 1, function()
          awful.spawn.with_shell(browser.." " .. name)
        end)
      },
  }

  helpers.add_hover(button_widget, beautiful.blk, colorFocus)
  return button_widget
end


local final_widget = wibox.widget {
  {
    {
      create_button("󰑍", 'https://www.reddit.com/', beautiful.red,beautiful.gry),
      create_button("󰖣", 'https://web.whatsapp.com/', beautiful.grn,beautiful.gry),
      create_button("󰉎", 'https://drive.google.com/drive/', beautiful.cya,beautiful.gry),
      create_button("󰊤", 'https://github.com/osmarmora05', beautiful.wht,beautiful.gry),
      create_button("󰊫", "https://mail.google.com/", beautiful.blu,beautiful.gry),
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
  shape = helpers.mkroundedrect(),
  widget = wibox.container.background,
  bg = beautiful.lbg
}

return final_widget
