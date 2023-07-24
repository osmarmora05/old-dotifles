------------------------------
-- Themer configuration --
------------------------------

-- Imports
----------

local wibox     = require('wibox')
local helpers   = require('helpers')
local beautiful = require('beautiful')
local awful     = require('awful')
local dpi       = beautiful.xresources.apply_dpi
local themer = require("ui.themer.modules.themer")


local themerWidget = themer.widget

-- Create themer widgets
local themerBox = wibox {
    ontop    = true,
    visible = false,
    width    = 480,
    height   = 250,
    shape    = helpers.mkroundedrect(),
    bg       = beautiful.bg_normal,
    widget   = wibox.container.margin
}

themerBox:setup {
    layout = wibox.layout.fixed.vertical,
    {
        layout = wibox.layout.fixed.vertical,
        spacing = 15,
        themerWidget
    }
}


awesome.connect_signal("widget::themerBox", function()
    themerBox.visible = not themerBox.visible
    awful.placement.next_to(
        themerBox,
        {
            preferred_positions = beautiful.bar_side == "left" and "right" or
                                  beautiful.bar_side == "right" and "left" or
                                  beautiful.bar_side == "top" and "bottom" or
                                  beautiful.bar_side == "bottom" and "top",
            preferred_anchors   = "front",
            margins             = {
                top    = dpi(810),
                bottom = dpi(15),
                left   = dpi(1375),
                right  = dpi(10)
            },

            -- margins             = dpi(400),
            geometry            = awful.screen.focused().mywibox
        }
    )
    if themerBox.visible then
        themer.reset()
    end
end)
