-- by

local wibox       = require("wibox")
local awful       = require("awful")
local beautiful   = require("beautiful")
local dpi       = beautiful.xresources.apply_dpi
local helpers     = require("helpers")
local gears       = require("gears")
local user        = require('config.user')
local gfs         = gears.filesystem



local preview_image = gfs.get_configuration_dir() .. 'widgets/controlCenter/module/images/'

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

-- Widgets
----------
local currTheme   = user.colorscheme

local drawing     = wibox.widget {
  image = gears.surface.load_uncached(preview_image .. string.lower(currTheme) .. '.png'),
  opacity = 0.30,
  align       = 'center',
  widget = wibox.widget.imagebox
}
local name        = wibox.widget {
  markup = currTheme,
  font   = beautiful.font_sans .. ' 12',
  align = 'right',
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
  'mar',
  'nord',
  'gruvbox_dark',
  'gruvbox_light',
  'solarized',
  'plata',
  'adwaita',
  'janleigh',
  'default'
}

local function reset()
  currTheme = user.colorscheme
  drawing.image = gears.surface.load_uncached(preview_image .. string.lower(currTheme) .. '.png')
  name.markup = currTheme
end

local pos         = helpers.indexOf(themes, currTheme)

local prev_button = wibox.widget {
  markup = '󰅁',
  font   = beautiful.font_icon .. ' 18',
  widget = wibox.widget.textbox
}

prev_button:buttons(gears.table.join(awful.button({}, 1, function()
  if pos > 1 then
    pos = pos - 1
    currTheme = themes[pos]
    drawing.image = gears.surface.load_uncached(preview_image .. string.lower(currTheme) .. '.png')
    name.markup = currTheme
  end
end)))

local next_button = wibox.widget {
  markup = '󰅂',
  font   = beautiful.font_icon .. ' 18',
  widget = wibox.widget.textbox
}

next_button:buttons(gears.table.join(awful.button({}, 1, function()
  if pos < #themes then
    pos = pos + 1
    currTheme = themes[pos]
    drawing.image =  gears.surface.load_uncached(preview_image .. string.lower(currTheme) .. '.png')
    name.markup = currTheme
  end
end)))

local set_theme_button = wibox.widget {
  markup = 'Set Theme',
  font   = beautiful.font_sans .. ' 12',
  widget = wibox.widget.textbox
}

set_theme_button:buttons(gears.table.join(awful.button({}, 1, function()
  set_theme('   colorscheme = "' .. currTheme:gsub('"', '\\"') .. '",',21,gfs.get_configuration_dir() .. "config/user.lua") --Change theme
  -- set_theme("include " .. currTheme .. ".ini",3,os.getenv("HOME") .. "/.config/kitty/kitty.conf") --Change terminal color (kitty)
  -- set_theme('@import "'..currTheme:gsub('"', '\\"') .. '.rasi"',1,os.getenv("HOME") .. "/.config/rofi/appmnu.rasi") --Change rofi color
end)))


local buttons_layout = wibox.widget {
  prev_button,
  next_button,
  set_theme_button,
  spacing = 10,
  layout = wibox.layout.fixed.horizontal
}

local buttons_with_padding = wibox.container.margin(buttons_layout, 218, 10, 0, 0)
local name_with_padding = wibox.container.margin(name, 240, 10, 10, 0)

local name_and_buttons_layout = wibox.widget {
  name_with_padding,
  buttons_with_padding,
  spacing = 180,
  layout = wibox.layout.fixed.vertical
}

local image_and_name_and_buttons_layout = wibox.widget {
  drawing,
  name_and_buttons_layout,
  layout = wibox.layout.stack
}

local final_widget = wibox.widget {
  image_and_name_and_buttons_layout,
  bg = {
    type = 'linear',
    from = { 0, 0 },
    to = { 500, 0 },
    stops = { { 0, beautiful.bg_light .. '31' }, { 1, beautiful.bg_normal } }
  },
  widget = wibox.container.background,
  forced_width = 250,
  forced_height = 250,
  shape = helpers.rounded_rect(dpi(4))
}


return {
  widget = final_widget,
  reset = reset,
}