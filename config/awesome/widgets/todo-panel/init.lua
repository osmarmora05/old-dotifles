-- wii bar meta

local wibox     = require('wibox')
local beautiful = require('beautiful')
local dpi       = beautiful.xresources.apply_dpi
local helpers   = require('helpers')
local modules   = require('widgets.todo-panel.module')
local rubato    = require('modules.rubato')


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
    --y       = dpi(55),
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

-- Animations
local slide = rubato.timed{
    pos = dpi(-panel.height),
    rate = 60,
    intro = 0.1,
    duration = 0.46,
    awestore_compat = true,
    subscribed = function(pos) panel.y = pos end
}

-- Flag
local todo_panel_status = false

slide.ended:subscribe(function()
    if todo_panel_status then
        panel.visible = false
    end
end)

local todo_panel_show = function()
    slide:set(dpi(55) + beautiful.useless_gap * 2)
    panel.visible = true
    todo_panel_status = false
end

local todo_panel_hide = function()
    slide:set(dpi(-panel.height))
    todo_panel_status = true
end

function panel:show()
    if panel.visible then
        todo_panel_hide()
    else
        todo_panel_show()
    end

    -- panel.visible = not panel.visible
 end
 
return panel

