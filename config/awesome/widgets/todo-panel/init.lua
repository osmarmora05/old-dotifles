-- wii bar meta

local wibox     = require('wibox')
local beautiful = require('beautiful')
local dpi       = beautiful.xresources.apply_dpi
local helpers   = require('helpers')

local modules   = require('widgets.todo-panel.module')



local todo_and_quiklink = wibox.widget {
    {
        modules.todo,
        modules.quiklinks,
        spacing = 15,
        layout = wibox.layout.fixed.horizontal
    },
    spacing = 0,
    layout = wibox.layout.fixed.horizontal,
}



local panel = wibox{
    ontop   = true,
    visible = false,
    width   = dpi(695),
    height  = dpi(700),
    y       = dpi(55),
    x       = dpi(600),
    bg      = beautiful.bg_normal,
    shape   = helpers.rounded_rect(dpi(4)),
    widget = {
        {
            {
                todo_and_quiklink,
                modules.quote,
                spacing = 15,
                layout = wibox.layout.fixed.vertical
            },
            layout = wibox.layout.fixed.horizontal
        },
        margins = dpi(0),
        widget = wibox.container.margin
    }
}




function panel:show()
    panel.visible = not panel.visible
 end
 
return panel

