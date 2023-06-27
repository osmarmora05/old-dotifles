------------------------
-- Client Decorations --
------------------------

-- Imports
----------
local awful     = require('awful')
local wibox     = require('wibox')
local gears     = require('gears')
local beautiful = require('beautiful')
local dpi       = beautiful.xresources.apply_dpi

local helpers   = require('helpers')


-- Buttons
----------

-- Text button
-------------
local function create_text_title_button(symbol, font, color_focus, color_unfocus, onclick)
  return function(c)
    local tb = wibox.widget {
      align = "center",
      valign = "center",
      font = font,
      markup = helpers.colorizeText(symbol, color_focus),
      forced_width = dpi(21),
      widget = wibox.widget.textbox
    }

    local color_transition = helpers.apply_transition {
      element = tb,
      prop = 'bg',
      bg = color_focus,
      hbg = beautiful.red,
    }

    client.connect_signal("property::active", function()
      if c.active then
        color_transition.off()
        tb.markup = helpers.colorizeText(symbol, color_focus) -- Apply color to text when window is active
      else
        color_transition.on()
        tb.markup = helpers.colorizeText(symbol, color_unfocus) -- Apply color to text when window is inactive
      end
    end)

    tb:connect_signal("button::press", function()
      if onclick then
        onclick(c)
      end
    end)

    tb.visible = true
    return tb
  end
end

-- Circular buttons
-------------------
local mkbutton = function (width,color,onclick)
  return function(c)
    local button = wibox.widget {
      wibox.widget.textbox(),
      forced_width  = dpi(width),
      forced_height = dpi(beautiful.title_size),
      bg            = color,
      shape         = helpers.mkroundedrect(beautiful.border_radius),
      widget        = wibox.container.background
    }

    local color_transition = helpers.apply_transition {
      element   = button,
      prop      = 'bg',
      bg        = color,
      hbg       = beautiful.titlebar_fg_normal,
    }

    client.connect_signal("property::active", function()
      if c.active then
        color_transition.off()
      else
        color_transition.on()
      end
    end)

    button:add_button(awful.button({}, 1, function()
      if onclick then
        onclick(c)
      end
    end))

    return button
  end
end

local close = create_text_title_button("󰣐", beautiful.mn_font .. " 12", beautiful.red, beautiful.titlebar_fg_normal, function(c)
  c:kill()
end)

local maximize = mkbutton(beautiful.title_size * 1/3,beautiful.blu, function(c)
    c.maximized = not c.maximized
end)

local minimize = mkbutton(beautiful.title_size * 1/3,beautiful.mag,function(c)
    gears.timer.delayed_call(function()
        c.minimized = not c.minimized
    end)
end)


-- Titlebars
------------
-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)

    if c.requests_no_titlebar then
        return
    end
    -- buttons for the titlebar
    local buttons = {
        awful.button({ }, 1, function()
            c:activate { context = "titlebar", action = "mouse_move"  }
        end),
        awful.button({ }, 3, function()
            c:activate { context = "titlebar", action = "mouse_resize"}
        end),
    }

    local n_titlebar = awful.titlebar(c, {
        size     = beautiful.title_size,
        position = beautiful.title_side,
    })
    n_titlebar.widget = {
      {
          {
              { -- Start
                  close(c),
                  maximize(c),
                  minimize(c),
                  spacing = dpi(beautiful.item_spacing+3),
                  layout  = wibox.layout.fixed.horizontal
              },
              { -- Middle
                  buttons = buttons,
                  layout  = wibox.layout.fixed.horizontal
              },
              { -- End
                  nil,
                  layout  = wibox.layout.fixed.horizontal
              },
              layout  = wibox.layout.align.horizontal
          },
          margins = dpi(beautiful.scaling),
          widget  = wibox.container.margin
      },
      layout = wibox.layout.fixed.horizontal
  }
end)