local helpers = require("helpers")
local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")

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
        margins = 12,
      },
      shape = helpers.mkroundedrect(),
      bg = beautiful.bg_normal,
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
      createButton("", 'https://www.reddit.com/', beautiful.red),
      createButton("", 'https://www.4chan.org/', beautiful.grn),
      createButton("", 'https://stackoverflow.com/', beautiful.ylw),
      createButton("", 'https://github.com/', beautiful.wht),
      createButton("", "https://youtube.com/", beautiful.red),
      spacing = 18,
      layout = wibox.layout.fixed.vertical
    },
    widget = wibox.container.margin,
    top = 18,
    bottom = 18
  },
  forced_width = 100,
  shape = helpers.mkroundedrect(),
  widget = wibox.container.background,
  bg = beautiful.lbg
}

return finalwidget
