------------------------------
-- Todo Panel configuration --
------------------------------

-- Imports
----------

local wibox     = require('wibox')
local helpers   = require('helpers')
local beautiful = require('beautiful')
local awful     = require('awful')
local dpi       = beautiful.xresources.apply_dpi

local quote = require('ui.themer-panel.modules.quote')
local quik = require('ui.themer-panel.modules.quiklinks')
local themer = require("ui.themer-panel.modules.themer")


-- Create todo panel
local themer_widget = themer.widget

local themer_box = wibox {
    ontop    = true,
    visible = false,
    width    = 695,
    height   = 700,
    shape    = helpers.mkroundedrect(),
    bg       = beautiful.bg_normal
}


-- Content of the todo box
themer_box:setup {
    layout = wibox.layout.fixed.vertical,
    {
        layout = wibox.layout.fixed.horizontal,
        themer_widget,
        quik,
        spacing = 15,
    },
    {
        layout = wibox.layout.fixed.horizontal,
        quote,
        spacing = 20,
    },
    spacing = 15,
    {
        widget = wibox.widget.textbox
    },
    {
        left = 10,
        right = 10,
        layout = wibox.container.margin
    },
    {
        widget = wibox.widget.textbox
    },
}

--todoBox

awesome.connect_signal("widget::themer_box", function()
    themer_box.visible = not themer_box.visible
    awful.placement.next_to(
        themer_box,
        {
            preferred_positions = beautiful.bar_side == "left" and "right" or
                                  beautiful.bar_side == "right" and "left" or
                                  beautiful.bar_side == "top" and "bottom" or
                                  beautiful.bar_side == "bottom" and "top",
            preferred_anchors   = "front",
            margins             = {
                top    = dpi(10),   --position
                bottom = dpi(10),
                left   = dpi(600),
                right  = dpi(550)
            },
            geometry            = awful.screen.focused().mywibox
        }
    )

    if themer_box.visible then
        themer.reset()
    end

end)

