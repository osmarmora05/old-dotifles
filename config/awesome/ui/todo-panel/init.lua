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

local todo = require('ui.todo-panel.modules.todo')
local quote = require('ui.todo-panel.modules.quote')
local quik = require('ui.todo-panel.modules.quiklinks')


-- Create todo panel
local todoBox = wibox {
    ontop    = true,
    visible = false,
    width    = 695,
    height   = 700,
    shape    = helpers.mkroundedrect(),
    bg       = beautiful.bg_normal
}


-- Content of the todo box
todoBox:setup {
    layout = wibox.layout.fixed.vertical,
    {
        layout = wibox.layout.fixed.horizontal,
        todo,
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


awesome.connect_signal("widget::todoBox", function()
    todoBox.visible = not todoBox.visible
    awful.placement.next_to(
        todoBox,
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

end)

