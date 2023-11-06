-- by chadcat7

local wibox       = require("wibox")
local awful       = require("awful")
local beautiful   = require("beautiful")
local helpers     = require("helpers")
local gears       = require("gears")
local user        = require('config.user')
local gfs         = gears.filesystem

local preview_image = gfs.get_configuration_dir() .. 'theme/preview/'


local currTheme   = user.colorscheme

-- Change value of colorscheme = "palletes" depending on the set value of the widget
local function set_theme(text,line,path)

  local file = io.open(path,'r')
  local fileContent = {}

  for line in file:lines() do 
    table.insert(fileContent,line)
  end

  io.close(file)

  fileContent[line] = text

  file = io.open(path,'w')
  for index, value in ipairs(fileContent) do
    file:write(value .. '\n')
  end
  io.close(file)

end

local drawing     = wibox.widget {
  resize = true,
  forced_width = 480,
  forced_height = 250,
  shape = helpers.rounded_rect(3),
  widget = wibox.widget.imagebox,
  horizontal_fit_policy = "fit",
  vertical_fit_policy = "fit",
  image = gears.surface.load_uncached(preview_image .. string.lower(currTheme) .. '.png')
}
local name        = wibox.widget {
  markup = currTheme,
  font   = beautiful.font_sans .. " 12",
  widget = wibox.widget.textbox
}
local themes      = {
  'everblush',
  'everforest',
  'tokyonight',
  'fullerene',
  'oxocarbon',
  'catppuccin',
  'dracula',
  'rose',
  'mar',
  'nord',
  'gruvbox_dark',
  'gruvbox_light',
  'solarized_dark',
  'solarized_light',
  'plata',
  'adwaita',
  'janleigh',
  'default',
  'wave',
  'ephemeral',
  'amarena',
  'skyfall'
}

local function reset()
  currTheme = user.colorscheme
  drawing.image = gears.surface.load_uncached(preview_image .. string.lower(currTheme) .. '.png')
  name.markup = currTheme
end

local pos         = helpers.indexOf(themes, currTheme)

local final_widget = wibox.widget {
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
            to = { 335, 0 },
            stops = { { 0, beautiful.bg_normal .. "31" }, { 1, beautiful.bg_normal } }
          },
          widget = wibox.container.background,
        },
        {
          {
            {
              {
                {
                  markup = "󰅁",
                  font   = beautiful.font_icon .. " 18",
                  widget = wibox.widget.textbox
                },
                widget = wibox.container.margin,
                buttons = awful.button({}, 1, function()
                  if pos > 1 then
                    pos = pos - 1
                    currTheme = themes[pos]
                    drawing.image = gears.surface.load_uncached(preview_image .. string.lower(currTheme) .. '.png')
                    name.markup = currTheme
                  end
                end),
              },
              {
                {
                  markup = "󰅂",
                  font   = beautiful.font_icon .. " 18",
                  widget = wibox.widget.textbox
                },
                widget = wibox.container.margin,
                buttons = awful.button({}, 1, function()
                  if pos < #themes then
                    pos = pos + 1
                    currTheme = themes[pos]
                    drawing.image = gears.surface.load_uncached(preview_image .. string.lower(currTheme) .. '.png')
                    name.markup = currTheme
                  end
                end),
              },
              {
                {
                  markup = "Set Theme",
                  font   = beautiful.font_sans .. " 12",
                  widget = wibox.widget.textbox
                },
                widget = wibox.container.margin,
                buttons = awful.button({}, 1, function()
                  set_theme('   colorscheme = "' .. currTheme:gsub('"', '\\"') .. '",',21,gfs.get_configuration_dir() .. "config/user.lua") --Change theme
                  -- set_theme("include " .. currTheme .. ".ini",3,os.getenv("HOME") .. "/.config/kitty/kitty.conf") --Change terminal color (kitty)
                  -- set_theme('@import "'..currTheme:gsub('"', '\\"') .. '.rasi"',1,os.getenv("HOME") .. "/.config/rofi/appmnu.rasi") --Change rofi color
                  awesome.restart()
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
  bg = beautiful.bg_normal .. 'cc',
}

return {
  widget = final_widget,
  reset = reset,
}