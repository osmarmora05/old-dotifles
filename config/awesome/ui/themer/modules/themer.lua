-------------------------------------
-- Widget themer by chadcat7 --
-------------------------------------

-- Imports
----------

local wibox       = require("wibox")
local awful       = require("awful")
local beautiful   = require("beautiful")
local dpi         = require("beautiful").xresources.apply_dpi
local helpers     = require("helpers")
local gears       = require("gears")
local user        = require("userconf")

-- Change value of user.color_palette depending on the set value of the widget
local function setTheme(name)
  local pathFile = os.getenv("HOME") .. "/.config/awesome/userconf.lua"

  local file = io.open(pathFile,'r')
  local fileContent = {}

  for line in file:lines() do 
    table.insert(fileContent,line)
  end

  io.close(file)

  fileContent[115] = 'user.clr_palette  = "' .. name:gsub('"', '\\"') .. '"'

  file = io.open(pathFile,'w')
  for index, value in ipairs(fileContent) do
    file:write(value .. '\n')
  end
  io.close(file)

end

-- Widgets
----------
local currTheme   = user.clr_palette
local drawing     = wibox.widget {
  resize = true,
  forced_width = 480,
  forced_height = 250,
  shape = helpers.mkroundedrect(),
  widget = wibox.widget.imagebox,
  horizontal_fit_policy = "fit",
  vertical_fit_policy = "fit",

image = helpers.crop_surface(2,
    gears.surface.load_uncached(os.getenv("HOME").."/.config/awesome/ui/themer/modules/image/" ..
      string.lower(currTheme) .. ".png"))
}
local name        = wibox.widget {
  markup = currTheme,
  font   = beautiful.mn_font .. " 12",
  widget = wibox.widget.textbox
}
local themes      = {
  'everblush',
  'everforest',
  'tokyonight',
  'fullerene',
  'oxocarbon',
  'catppuccin',
  'mar',
  'gruvbox',
  'solarized',
  'plata'
}

local function reset()
  currTheme = user.clr_palette
  drawing.image = helpers.crop_surface(2, gears.surface.load_uncached(os.getenv("HOME") .. "/.config/awesome/ui/themer/modules/image/" .. string.lower(currTheme) .. ".png"))
  name.markup = currTheme
end

local pos         = helpers.indexOf(themes, currTheme)

local finalwidget = wibox.widget {
  {
    {
      {
        drawing,
        {
          {
            widget = wibox.widget.textbox,
          },
          bg = {
            type = "linear",
            from = { 0, 0 },
            to = { 350, 0 },
            stops = { { 0, beautiful.bg_normal .. "31" }, { 1, beautiful.bg_normal .. 'f1' } }
          },
          widget = wibox.container.background,
        },
        {
          {
            {
              {
                {
                  markup = "󰅁",
                  font   = beautiful.mn_font .. " 18",
                  widget = wibox.widget.textbox
                },
                widget = wibox.container.margin,
                buttons = awful.button({}, 1, function()
                  if pos > 1 then
                    pos = pos - 1
                    currTheme = themes[pos]
                    drawing.image = helpers.crop_surface(2,
                    gears.surface.load_uncached(os.getenv("HOME").."/.config/awesome/ui/themer/modules/image/" ..
                    string.lower(currTheme) .. ".png"))
                    name.markup = currTheme
                  end
                end),
              },
              {
                {
                  markup = "󰅂",
                  font   = beautiful.mn_font .. " 18",
                  widget = wibox.widget.textbox
                },
                widget = wibox.container.margin,
                buttons = awful.button({}, 1, function()
                  if pos < #themes then
                    pos = pos + 1
                    currTheme = themes[pos]
                    drawing.image = helpers.crop_surface(2,
                    gears.surface.load_uncached(os.getenv("HOME").."/.config/awesome/ui/themer/modules/image/" ..
                    string.lower(currTheme) .. ".png"))
                    name.markup = currTheme
                  end
                end),
              },
              {
                {
                  markup = "Set Theme",
                  font   = beautiful.mn_font .. " 12",
                  widget = wibox.widget.textbox
                },
                widget = wibox.container.margin,
                buttons = awful.button({}, 1, function()
                  setTheme(currTheme)
                end),
              },
              spacing = 10,
              layout = wibox.layout.fixed.horizontal
            },
            widget = wibox.container.place,
            halign = 'right',
            valign = 'bottom',
          },
          widget = wibox.container.margin,
          bottom = 10,
          right = 10,
        },
        {
          {
            name,
            widget = wibox.container.place,
            halign = 'right',
            valign = 'top',
          },
          widget = wibox.container.margin,
          top = 10,
          right = 10,
        },
        widget = wibox.layout.stack
      },
      spacing = 15,
      layout = wibox.layout.fixed.vertical
    },
    widget = wibox.container.margin,
  },
  widget = wibox.container.background,
  bg = beautiful.bg_normal,
}


return {
  widget = finalwidget,
  reset = reset,
}